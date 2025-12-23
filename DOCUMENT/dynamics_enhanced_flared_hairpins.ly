\version "2.24.4"

% similar to the original version

#(define-public ((elbowed-hairpin-revised coords mirrored?) grob)
  "This scheme code was originally the scheme code 'elbowed-hairpin
taken from output-lib.scm, and was revised to suit the need.
"
  (define (scale-coords coords-list x y)
   (map
    (lambda (coord) (cons (* x (car coord)) (* y (cdr coord))))
    coords-list))

  (define (hairpin::print-part points decresc? me)
   (let ((stil (make-connected-line points me)))
    (if decresc? (ly:stencil-scale stil -1 1)
        (ly:stencil-scale stil 1 1))))

  ;; outer let to trigger suicide
  (let ((sten (ly:hairpin::print grob)))
   (if (grob::is-live? grob)
       (let*
        ((decresc? (eqv? (ly:grob-property grob 'grow-direction) LEFT))
         (hairpinHeight (ly:grob-property grob 'height))
         (toBarline? (ly:grob-property grob 'to-barline))
         (orig (ly:grob-original grob))
         (siblings (if (ly:grob? orig)
                       (ly:spanner-broken-into orig)
                       '()))
         (hairpinTypeA?
          (and (eqv? (end-broken-spanner? grob )               #f)
               (eqv? (first-broken-spanner? grob )             #f)
               (eqv? (middle-broken-spanner? grob )            #f)
               (eqv? (not-first-broken-spanner? grob )         #f)
               (eqv? (not-last-broken-spanner? grob )          #f)
               (eqv? (unbroken-or-first-broken-spanner? grob ) #t)
               (eqv? (unbroken-or-last-broken-spanner? grob )  #t)
               (eqv? (unbroken-spanner? grob )                 #t)
               )) ;Hairpins that end within one line without reaching
         ;to the end of the system
         (hairpinTypeB?
          (or (and (eqv? (end-broken-spanner? grob )               #t)
                   (eqv? (first-broken-spanner? grob )             #t)
                   (eqv? (middle-broken-spanner? grob )            #f)
                   (eqv? (not-first-broken-spanner? grob )         #f)
                   (eqv? (not-last-broken-spanner? grob )          #f)
                   (eqv? (unbroken-or-first-broken-spanner? grob ) #t)
                   (eqv? (unbroken-or-last-broken-spanner? grob )  #t)
                   (eqv? (unbroken-spanner? grob )                 #f)
                   )
              (and (eqv? (end-broken-spanner? grob )               #f)
                   (eqv? (first-broken-spanner? grob )             #t)
                   (eqv? (middle-broken-spanner? grob )            #f)
                   (eqv? (not-first-broken-spanner? grob )         #f)
                   (eqv? (not-last-broken-spanner? grob )          #t)
                   (eqv? (unbroken-or-first-broken-spanner? grob ) #t)
                   (eqv? (unbroken-or-last-broken-spanner? grob )   #f)
                   (eqv? (unbroken-spanner? grob )                 #f)
                   )
              )) ;Hairpins that breaks into next line
         (hairpinTypeC?
          (and (eqv? (end-broken-spanner? grob )               #f)
               (eqv? (first-broken-spanner? grob )             #f)
               (eqv? (middle-broken-spanner? grob )            #t)
               (eqv? (not-first-broken-spanner? grob )         #t)
               (eqv? (not-last-broken-spanner? grob )          #t)
               (eqv? (unbroken-or-first-broken-spanner? grob ) #f)
               (eqv? (unbroken-or-last-broken-spanner? grob )   #f)
               (eqv? (unbroken-spanner? grob )                 #f)
               )) ;Midway-through Hairpins
         (hairpinTypeD?
          (and (eqv? (end-broken-spanner? grob )               #t)
               (eqv? (first-broken-spanner? grob )             #f)
               (eqv? (middle-broken-spanner? grob )            #f)
               (eqv? (not-first-broken-spanner? grob )         #t)
               (eqv? (not-last-broken-spanner? grob )          #f)
               (eqv? (unbroken-or-first-broken-spanner? grob ) #f)
               (eqv? (unbroken-or-last-broken-spanner? grob )   #t)
               (eqv? (unbroken-spanner? grob )                 #f)
               )) ;multi-system Hairpin that terminates
         (xex (if decresc?
                  (cons (+ (car (ly:stencil-extent sten X)) 0.75)
                        (cdr (ly:stencil-extent sten X)))
                  (cons (car (ly:stencil-extent sten X))
                        (- (cdr (ly:stencil-extent sten X)) 1.25))
                  ))
         (lenx (interval-length xex))
         (yex (ly:stencil-extent sten Y))
         (leny (interval-length yex))
         (xtrans (+ (car xex) (if decresc? lenx 0)))
         (ytrans (car yex))
         (uplist (scale-coords coords lenx (/ leny 2)))
         (downlist (scale-coords coords lenx (/ leny -2)))
         ; crescStencil is used when the flared crescendo takes place
         ; and finishes within one line.
         (crescStencil
          (if toBarline?
              ;I added here to make it default to stretch
              ;the hairpin immediately to the dynamics
              (ly:stencil-combine-at-edge
               (ly:stencil-combine-at-edge
                (hairpin::print-part
                 (scale-coords
                  coords
                  (+ lenx 0.95) (/ leny 2))  decresc? grob)
                1
                -1
                (if mirrored?
                    (hairpin::print-part
                     (scale-coords
                      coords
                      (+ lenx 0.95) (/ leny -2))  decresc? grob)
                    empty-stencil)
                -0.1 ;vertical padding value here
                )
               0
               1
               (make-path-stencil
                (list
                 'moveto 0 (* 0.2 (/ hairpinHeight 0.666) )
                 'rlineto 0.25 0.3
                 'moveto 0 (* -0.2 (/ hairpinHeight 0.666) )
                 'rlineto 0.25 -0.3
                 )
                0.1
                2
                2
                #f
                )
               -0.075
               )
              ;if not to barline
              (ly:stencil-combine-at-edge
               (ly:stencil-combine-at-edge
                (hairpin::print-part
                 (scale-coords
                  coords
                  (+ lenx 0.95) (/ leny 2))  decresc? grob)
                1
                -1
                (if mirrored?
                    (hairpin::print-part
                     (scale-coords
                      coords
                      (+ lenx 0.95) (/ leny -2))  decresc? grob)
                    empty-stencil)
                -0.1 ;vertical padding value here
                )
               0
               1
               (make-path-stencil

                (list
                 'moveto 0 (* 0.2 (/ hairpinHeight 0.666) )
                 'rlineto 0.25 0.3
                 'moveto 0 (* -0.2 (/ hairpinHeight 0.666) )
                 'rlineto 0.25 -0.3
                 )
                0.1
                2
                2
                #f
                )
               -0.075
               ))
          )
         ; when crescendo begins but breaks off to
         ; the subsequent system(s)
         (crescStencilBrokenBeginning
          ; if the hairpin is set only to barline...
          (if toBarline?
              ; ... AND if the hairpin finishes at the beginning
              ; of the next line
              ( if  (= (length siblings) 1)
                    (ly:stencil-combine-at-edge
                     (ly:stencil-combine-at-edge
                      (hairpin::print-part
                       (scale-coords
                        coords
                        (+ lenx 0.95) (/ leny 2))  decresc? grob)
                      1
                      -1
                      (if mirrored?
                          (hairpin::print-part
                           (scale-coords
                            coords
                            (+ lenx 0.95) (/ leny -2))  decresc? grob)
                          empty-stencil)
                      -0.1 ;vertical padding value here
                      )
                     0
                     1
                     (make-path-stencil
                      (list
                       'moveto 0 (* 0.2 (/ hairpinHeight 0.666) )
                       'rlineto 0.25 0.3
                       'moveto 0 (* -0.2 (/ hairpinHeight 0.666) )
                       'rlineto 0.25 -0.3
                       )
                      0.1
                      2
                      2
                      #f
                      )
                     -0.075
                     )
                    (ly:stencil-combine-at-edge
                     (hairpin::print-part
                      (scale-coords
                       coords
                       (+ lenx 1) (/ leny 1.5)) decresc? grob)
                     1
                     -1
                     (if mirrored?
                         (hairpin::print-part
                          (scale-coords
                           coords

                           (+ lenx 1) (/ leny -1.5))  decresc? grob)
                         empty-stencil)
                     -0.1 ;vertical padding value here
                     )
                    )
              (ly:stencil-combine-at-edge
               (hairpin::print-part
                (scale-coords
                 coords
                 (+ lenx 1) (/ leny 1.5)) decresc? grob)
               1
               -1
               (if mirrored?
                   (hairpin::print-part
                    (scale-coords
                     coords

                     (+ lenx 1) (/ leny -1.5))  decresc? grob)
                   empty-stencil)
               -0.1 ;vertical padding value here
               )
              )
          )
         (crescStencilBrokenContinuation
          (ly:stencil-combine-at-edge
           (hairpin::print-part
            (scale-coords
             coords
             (+ lenx 1) (/ leny 2)) decresc? grob)
           1
           -1
           (if mirrored?
               (hairpin::print-part
                (scale-coords
                 coords
                 (+ lenx 1) (/ leny -2))  decresc? grob)
               empty-stencil)
           0.1 ;vertical padding value here
           )
          )
         (crescStencilBrokenEnding
          ;if the flare end is applied
          ;on the dynamic at the beginning
          ;of the system, meaning lenx is super low
          (cond ((< lenx 0.2)
                 (make-path-stencil
                  (list 'moveto 0.45 (* 0.2 (/ hairpinHeight 0.666) )
                        'rlineto -0.65 -0.1
                        'moveto 0.45 (* 0.2 (/ hairpinHeight 0.666) )
                        'rlineto 0.25 0.3
                        'moveto 0.45 (* -0.2 (/ hairpinHeight 0.666) )
                        'rlineto -0.65 0.1
                        'moveto 0.45 (* -0.2 (/ hairpinHeight 0.666) )
                        'rlineto 0.25 -0.3
                        )
                  0.1
                  2
                  2
                  #f
                  ))
                ((and (>= lenx 0.2)(< lenx 2))
                 ;if the flare end is applied
                 ;on the note at the beginning of the system
                 ;without the dynamics (lenx is about 1 to 2)
                 (ly:stencil-combine-at-edge
                  (ly:stencil-combine-at-edge
                   (hairpin::print-part
                    (scale-coords
                     (list
                      (cons (- (car (car coords)) 0)
                            (cdr (car coords )))
                      (cons (- (car (cadr coords)) 0)
                            (cdr (cadr coords))))
                     (+ lenx 0.25) (/ leny 2.75)) decresc? grob)
                   1
                   -1
                   (if mirrored?
                       (hairpin::print-part
                        (scale-coords
                         (list
                          (cons (- (car (car coords)) 0)
                                (cdr (car coords )))
                          (cons (- (car (cadr coords)) 0)
                                (cdr (cadr coords))))
                         (+ lenx 0.25) (/ leny -2.75))  decresc? grob)
                       empty-stencil)
                   0.1 ;vertical padding value here
                   )
                  0
                  1
                  (make-path-stencil
                   (list   'moveto 0 (* 0.15 (/ hairpinHeight 0.666) )
                           'rlineto 0.25 0.3
                           'moveto 0
                           (- (* -0.15 (/ hairpinHeight 0.666) ) 0.1)
                           'rlineto 0.25 -0.3
                           )
                   0.1
                   2
                   2
                   #f
                   )
                  -0.075
                  ))
                ((>= lenx 2)
                 ;if the normal ending flare crescendo
                 ;is applied...
                 (ly:stencil-combine-at-edge
                  (ly:stencil-combine-at-edge
                   (hairpin::print-part
                    (scale-coords
                     coords
                     (+ lenx 0.75) (/ leny 3)) decresc? grob)
                   1
                   -1
                   (if mirrored?
                       (hairpin::print-part
                        (scale-coords
                         coords
                         (+ lenx 0.75) (/ leny -3))  decresc? grob)
                       empty-stencil)
                   0.1 ;vertical padding value here
                   )
                  0
                  1
                  (make-path-stencil
                   (list   'moveto 0 (* 0.133 (/ hairpinHeight 0.666) )
                           'rlineto 0.25 0.3
                           'moveto 0
                           (- (* -0.133 (/ hairpinHeight 0.666) ) 0.1)
                           'rlineto 0.25 -0.3
                           )
                   0.1
                   2
                   2
                   #f
                   )
                  -0.075
                  )
                 (ly:stencil-combine-at-edge
                  (ly:stencil-combine-at-edge
                   (hairpin::print-part
                    (scale-coords
                     coords
                     (+ lenx 0.75) (/ leny 3)) decresc? grob)
                   1
                   -1
                   (if mirrored?
                       (hairpin::print-part
                        (scale-coords
                         coords
                         (+ lenx 0.75) (/ leny -3))  decresc? grob)
                       empty-stencil)
                   0.1 ;vertical padding value here
                   )
                  0
                  1
                  (make-path-stencil
                   (list   'moveto 0 (* 0.133 (/ hairpinHeight 0.666) )
                           'rlineto 0.25 0.3
                           'moveto 0
                           (- (* -0.133 (/ hairpinHeight 0.666) ) 0.1)
                           'rlineto 0.25 -0.3
                           )
                   0.1
                   2
                   2
                   #f
                   )
                  -0.075
                  ))
                )
          )
         (decrescStencil
          (if toBarline?
              ;I added here to make it default to stretch
              ;the hairpin immediately to the dynamics
              (ly:stencil-combine-at-edge
               (ly:stencil-combine-at-edge
                (hairpin::print-part
                 (scale-coords
                  coords
                  (+ lenx 0.25) (/ leny 2)) decresc? grob)
                1
                -1
                (if mirrored?
                    (hairpin::print-part
                     (scale-coords
                      coords
                      (+ lenx 0.25) (/ leny -2))  decresc? grob)
                    empty-stencil)
                -0.1 ;vertical padding value here
                )
               0
               -1
               (make-path-stencil
                (list   'moveto 0 (* 0.19 (/ hairpinHeight 0.666) )
                        'rlineto -0.25 0.3
                        'moveto 0 (* -0.19 (/ hairpinHeight 0.666) )
                        'rlineto -0.25 -0.3
                        )
                0.1
                2
                2
                #f
                )
               -0.075
               )
              ;if not to barline
              (ly:stencil-combine-at-edge
               (ly:stencil-combine-at-edge
                (hairpin::print-part
                 (scale-coords
                  coords
                  (+ lenx 0.25) (/ leny 2))  decresc? grob)
                1
                -1
                (if mirrored?
                    (hairpin::print-part
                     (scale-coords
                      coords
                      (+ lenx 0.25) (/ leny -2))  decresc? grob)
                    empty-stencil)
                -0.1 ;vertical padding value here
                )
               0
               -1
               (make-path-stencil
                (list
                 'moveto 0 (* 0.2 (/ hairpinHeight 0.666) )
                 'rlineto -0.25 0.3
                 'moveto 0 (* -0.2 (/ hairpinHeight 0.666) )
                 'rlineto -0.25 -0.3
                 )
                0.1
                2
                2
                #f
                )
               -0.075
               ))
          )

         (decrescStencilBrokenBeginning
          (ly:stencil-combine-at-edge
           (ly:stencil-combine-at-edge
            (hairpin::print-part
             (scale-coords
              coords
              (+ lenx 0.2) (/ leny 2.5))
             decresc? grob)
            1
            -1
            (if mirrored?
                (hairpin::print-part
                 (scale-coords
                  coords
                  (+ lenx 0.2) (/ leny -2.5))  decresc? grob)
                empty-stencil)
            0.1 ;vertical padding value here
            )
           0
           -1
           (make-path-stencil
            (list   'moveto 0 (* 0.15 (/ hairpinHeight 0.666) )
                    'rlineto -0.25 0.3
                    'moveto 0
                    (- (* -0.15 (/ hairpinHeight 0.666) ) 0.1)
                    'rlineto -0.25 -0.3
                    )
            0.1
            2
            2
            #f
            )
           -0.075
           )
          )
         (decrescStencilBrokenEnding
          (ly:stencil-combine-at-edge
           (hairpin::print-part uplist decresc? grob)
           1
           -1
           (if mirrored?
               (hairpin::print-part downlist decresc? grob)
               empty-stencil)
           -0.1 ;vertical padding value here
           )
          )
         (cresc
          (cond (hairpinTypeA? crescStencil)
                (hairpinTypeB? crescStencilBrokenBeginning)
                (hairpinTypeC? crescStencilBrokenContinuation)
                (hairpinTypeD? crescStencilBrokenEnding)
                )
          )
         (decres
          (cond (hairpinTypeA? decrescStencil)
                (hairpinTypeB? decrescStencilBrokenBeginning)
                (hairpinTypeC? crescStencilBrokenContinuation)
                ;crescStencilBrokenContinuation can be used for decresc
                ;as well, because it gets inverted.
                (hairpinTypeD? decrescStencilBrokenEnding)
                )
          )
         (stil
          (ly:stencil-aligned-to
           (ly:stencil-translate
            (if decresc?
                decres
                cresc
                )
            (cons xtrans ytrans))
           Y CENTER))
         (stil-y-extent (ly:stencil-extent stil Y)))
        ; for debugging purposes
        ;         (display "Is this type A Hairpin? " )
        ;         (display hairpinTypeA?)
        ;         (newline)
        ;         (display "Is this type B Hairpin? " )
        ;         (display hairpinTypeB?)
        ;         (newline)
        ;         (display "Is this type C Hairpin? " )
        ;         (display hairpinTypeC?)
        ;         (newline)
        ;         (display "Is this type D Hairpin? " )
        ;         (display hairpinTypeD?)
        ;
        ;         (newline)
        ;         (display "Is it decrescendo? " )
        ;         (display decresc?)
        ;         (newline)
        ;         (display "end-broken-spanner???  " )
        ;         (display (end-broken-spanner? grob ))
        ;         (newline)
        ;         (display "(first-broken-spanner?) Is spanner broken
        ;and the first of its broken siblings? " )
        ;         (display (first-broken-spanner? grob ) )
        ;         (newline)
        ;         (display "middle-broken-spanner??? " )
        ;         (display (middle-broken-spanner? grob ) )
        ;         (newline)
        ;
        ;         (display "Is spanner broken and not the first of
        ;its broken siblings? " )
        ;         (display (not-first-broken-spanner? grob ) )
        ;         (newline)
        ;
        ;         (display "Is spanner broken and not the last of
        ;its broken siblings? " )
        ;         (display (not-last-broken-spanner? grob ) )
        ;         (newline)
        ;
        ;         (display "unbroken-or-first-broken-spanner??? " )
        ;         (display (unbroken-or-first-broken-spanner? grob ) )
        ;         (newline)
        ;
        ;         (display "unbroken-or-first-broken-spanner??? " )
        ;         (display (unbroken-or-last-broken-spanner? grob ) )
        ;         (newline)
        ;         (display "unbroken spanner?? " )
        ;         (display (unbroken-spanner? grob ) )
        ;         (newline)
        ;         (newline)
        ;         (display "distance of xex " )
        ;         (display lenx )
        ;         (newline)
        ;         (newline)
        (ly:make-stencil (ly:stencil-expr stil) xex stil-y-extent))
       ;; return empty, if no Hairpin.stencil present.
       '())))

#(define-public flared-hairpin-new
  (elbowed-hairpin-revised '((0 . 0) (1 . 0.5))
                           #t))

#(define-public o
  (make-music 'AbsoluteDynamicEvent
              'text
              (markup
               #:pad-x -inf.0
               #:concat (
                         #:pad-to-box '(0 . 0.1) '(-0.75 . 1.75)
                         #:translate '(0 . 0.6)
                         #:musicglyph "scripts.flageolet"
                         ))
              ))

nCrescTweak =
#(define-music-function (num dyn) ((number? 0) ly:event? )
  (let* ((hOffset num))

   #{ \tweak Hairpin.shorten-pair
      #(lambda (grob)
        (let* (
               ;; have we been split?
               (orig (ly:grob-original grob))

               ;; if yes, get the split pieces (our siblings)
               (siblings (if (ly:grob? orig)
                             (ly:spanner-broken-into orig)
                             '())))

         (if   (or (= (length siblings) 0)
                   (and (>= (length siblings) 0)
                        (eq? (first siblings) grob))

                   )
               (cons -0.6 num)))
        )
      \tweak Hairpin.after-line-breaking
      #(lambda (grob)
        (let* (
               ;; have we been split?
               (orig (ly:grob-original grob))

               ;; if yes, get the split pieces (our siblings)
               (siblings (if (ly:grob? orig)
                             (ly:spanner-broken-into orig)
                             '()))
               (toBarline? (ly:grob-property grob 'to-barline))

               )

         (if  (and (>= (length siblings) 2)
                   (eq? (car (last-pair siblings)) grob))
              (if toBarline?
                  (ly:grob-set-property!
                   grob 'shorten-pair
                   (cons 0 (+ (* 0.6 -1) hOffset)))
                  (ly:grob-set-property!
                   grob 'shorten-pair
                   (cons (+ -0.6 hOffset)  -0.6))
                  )
              )

         )
        ) #dyn  #}))

nDecrescTweak =
#(define-music-function (num dyn) ((number? 0) ly:event? )
  (let* ((hOffset num))
   #{
    \tweak Hairpin.shorten-pair
    #(lambda (grob)
      (let* (
             ;; have we been split?
             (orig (ly:grob-original grob))

             ;; if yes, get the split pieces (our siblings)
             (siblings (if (ly:grob? orig)
                           (ly:spanner-broken-into orig)
                           '())))

       (if   (= (length siblings) 0)
             (cons 0  (+ -0.6 (* hOffset -1)))))
      )
    \tweak Hairpin.after-line-breaking
    #(lambda (grob)
      (let* (
             ;; have we been split?
             (orig (ly:grob-original grob))

             ;; if yes, get the split pieces (our siblings)
             (siblings (if (ly:grob? orig)
                           (ly:spanner-broken-into orig)
                           '())))

       (if  (and (>= (length siblings) 1)
                 (eq? (car (last-pair siblings)) grob))

            (ly:grob-set-property! grob 'shorten-pair '(-0.6 . -0.6))))
      ) #dyn #}))

\layout {
 indent = #0
 line-width = #100
 ragged-last = ##t
}


{
 % \override Hairpin.height = #0.5
 \override Hairpin.stencil = #flared-hairpin-new
 \override Hairpin.to-barline = ##f
 \override Hairpin.after-line-breaking = ##f

 c' \o \nCrescTweak   \< c' c' c' \f \nDecrescTweak \>
 c' c'\o\nCrescTweak #-0.75 \< c' c' \break
 \repeat unfold 3  {c' c' c' c'} \break
 c'\ff \nDecrescTweak \> c' c' c'
 c' \p \nCrescTweak \< c' c' \nDecrescTweak #-0.6 \> c'
 c' \p \< c' c' c'\ff \nDecrescTweak \> \break
 \repeat unfold 3  {c' c' c' c'} \break
 c' \f  \nDecrescTweak \> c' c' c'\o \nCrescTweak \<
 c' c' c' c' \!
}