\version "2.24.4"


qf = #(make-dynamic-script
       (markup
        #:pad-x -1
        ( #:combine
          #:combine
          #:translate '(-0.75 . 0)
          #:normal-text (#:italic #:fontsize 0.75 "\"")
          #:dynamic "f"
          #:translate '(1.65 . 0)
          #:normal-text (#:italic #:fontsize 0.75 "\""))))

qmp = #(make-dynamic-script
        (markup
         #:pad-x -1
         ( #:combine
           #:combine
           #:translate '(-0.85 . -0.1)
           #:normal-text (#:italic #:fontsize 0.75 "\"")
           #:dynamic "mp"
           #:translate '(3.25 . -0.1)
           #:normal-text (#:italic #:fontsize 0.75 "\""))))


constante =
#(define-music-function ( vOff cautionary dyn) ( (ly:dir? CENTER)  (boolean? #t) ly:event?   )
  (define-public
   ((constante-hairpin-revised coords mirrored?) grob)
   "This scheme code was originally the scheme code 'elbowed-hairpin
taken from output-lib.scm, and was revised to suit the need."
   (define (scale-coords coords-list x y)
    (map
     (lambda (coord) (cons (* x (car coord)) (* y (cdr coord))))
     coords-list))

   (define (hairpin::print-part points decresc? me)
    (let ((stil (make-connected-line points me)))
     (ly:stencil-scale stil 1 1)))

   ;; outer let to trigger suicide
   (let ((sten (ly:hairpin::print grob)))
    (if (grob::is-live? grob)
        (let*
         (
          ;I've left decresc? function but removed all the if clause
          ;associated with it, to simplify the code a little bit
          (verticalOffset vOff)
          (useCautionary? cautionary)
          (hairpinHeight (ly:grob-property grob 'height))
          (decresc? (eqv? (ly:grob-property grob 'grow-direction) LEFT))
          (toBarline? (ly:grob-property grob 'to-barline))
          ;    (circled-tip? (ly:grob-property grob 'circled-tip))
          (hairpinTypeA?
           (and (eqv? (end-broken-spanner? grob )               #f)
                (eqv? (first-broken-spanner? grob )             #f)
                (eqv? (middle-broken-spanner? grob )            #f)
                (eqv? (not-first-broken-spanner? grob )         #f)
                (eqv? (not-last-broken-spanner? grob )          #f)
                (eqv? (unbroken-or-first-broken-spanner? grob ) #t)
                (eqv? (unbroken-or-last-broken-spanner? grob )  #t)
                (eqv? (unbroken-spanner? grob )                 #t)
                )) ;Hairpins that end within one line without
          ;reaching to the end of the system
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
          (xex
           (cons (car (ly:stencil-extent sten X))
                 (- (cdr (ly:stencil-extent sten X)) 1.25))
           )
          (lenx (interval-length xex))
          (yex (ly:stencil-extent sten Y))
          (leny (interval-length yex))
          (xtrans (+ (car xex)  0))
          (ytrans (car yex))
          (uplist (scale-coords coords lenx (/ leny 2)))

          (crescStencil

           (if toBarline?
               ;I added here to make it default to stretch
               ;the hairpin immediately to the dynamics

               (ly:stencil-translate
                (hairpin::print-part
                 (scale-coords coords
                               (+ lenx 2.35) (/ leny 2))
                 decresc? grob)

                '(-0.5 . 0))
               ;if not to barline
               (ly:stencil-translate
                (hairpin::print-part
                 (scale-coords coords
                               (+ lenx 2.35)  (/ leny 2))
                 decresc? grob)

                '(-0.5 . 0))

               )
           )
          (crescStencilBrokenBeginning
           (hairpin::print-part (scale-coords
                                 '((0 . 0) (1 . 0))
                                 (+ lenx 2) (/ leny 2))
                                decresc? grob)
           )
          (crescStencilBrokenContinuation
           (ly:stencil-combine-at-edge
            ;if the cautionary accidentals are turned on
            (if cautionary
                (if (list? (ly:music-property dyn 'text))
                    ;this means, when the custom-made dynamics
                    ;(e.g. \qmp) are used
                    (grob-interpret-markup
                     grob
                     (markup
                      #:hspace 2
                      #:whiteout
                      #:center-align
                      (
                       #:concat
                       (#:normal-text
                        (#:translate '(0 . -0.25)
                                     #:italic (#:fontsize -0.5 "( "
                                                          ))
                        #:pad-x
                        0.35
                        #:dynamic (ly:music-property dyn 'text)
                        #:normal-text
                        (#:translate '(0.5 . -0.25)
                                     #:italic (#:fontsize -0.5 ")")))
                       )
                      )
                     )
                    ;when in-house dynamics (e.g. \p) are used
                    (grob-interpret-markup
                     grob
                     (markup
                      #:hspace 2
                      #:center-align
                      #:whiteout
                      #:concat
                      (#:normal-text
                       (#:translate '(0 . -0.25)
                                    #:italic (#:fontsize 0.5 "("
                                                         ))
                       (#:translate '(0 . -0.25)
                                    #:italic (#:fontsize -10 " "
                                                         ))
                       #:pad-x
                       0
                       #:dynamic (ly:music-property dyn 'text)
                       #:normal-text
                       (#:translate '(0 . -0.25)
                                    #:italic (#:fontsize 0.5 ")")))
                      )
                     ))
                empty-stencil)
            1
            1
            (hairpin::print-part (scale-coords
                                  '((0.01 . 0.15) (1 . 0.15))
                                  (+ lenx 2)  (/ leny 2))
                                 decresc? grob)
            -1.5
            )
           )
          (crescStencilBrokenEnding
           ;if the flare end is applied
           ;on the dynamic at the beginning
           ;of the system, meaning lenx is super low

           (cond
            ((< lenx 1)
             (ly:stencil-combine-at-edge
              ;if the cautionary accidentals are turned on
              (if cautionary
                  (if (list? (ly:music-property dyn 'text))
                      ;this means, when the custom-made dynamics
                      ;(e.g. \qmp) are used
                      (grob-interpret-markup
                       grob
                       (markup
                        #:hspace -1
                        #:whiteout
                        #:center-align
                        #:concat
                        (#:normal-text
                         (#:translate '(0 . -0.25)
                                      #:italic (#:fontsize -0.5 "( "
                                                           ))
                         #:pad-x
                         0.25
                         #:dynamic (ly:music-property dyn 'text)
                         #:normal-text
                         (#:translate '(0.5 . -0.25)
                                      #:italic (#:fontsize -0.5 ")")))
                        )
                       )
                      ;when in-house dynamics (e.g. \p) are used
                      (grob-interpret-markup
                       grob
                       (markup
                        #:hspace -1
                        #:whiteout
                        #:center-align(
                                       #:concat
                                       (#:normal-text
                                        (#:translate '(0 . -0.25)
                                                     #:italic (#:fontsize 0.5 "("
                                                                          ))
                                        (#:translate '(0 . -0.25)
                                                     #:italic (#:fontsize -10 " "
                                                                          ))
                                        #:pad-x
                                        0
                                        #:dynamic (ly:music-property dyn 'text)
                                        #:normal-text
                                        (#:translate '(0 . -0.25)
                                                     #:italic (#:fontsize 0.5 ")")))
                                       ))
                       ))
                  empty-stencil
                  )
              1
              1
              (hairpin::print-part
               (scale-coords  coords
                              (+ lenx 1.85) (/ leny 2) )
               decresc? grob)
              ;vertical alignment (to be refined possibly...?)
              -1.75
              )
             )
            ((>= lenx 1)
             ;if the normal ending flare crescendo
             ;is applied...
             (ly:stencil-combine-at-edge
              ;if the cautionary accidentals are turned on
              (if cautionary
                  (if (list? (ly:music-property dyn 'text))
                      ;this means, when the custom-made dynamics
                      ;(e.g. \qmp) are used
                      (grob-interpret-markup
                       grob
                       (markup
                        #:hspace 2
                        #:whiteout
                        #:center-align
                        #:concat
                        (#:normal-text
                         (#:translate '(0 . -0.25)
                                      #:italic (#:fontsize -0.5 "( "
                                                           ))
                         #:pad-x 0.25
                         #:dynamic (ly:music-property dyn 'text)
                         #:normal-text
                         (#:translate '(0.5 . -0.25)
                                      #:italic (#:fontsize -0.5 ")")))
                        )
                       )
                      ;if the in-house dynmamics are used

                      (grob-interpret-markup
                       grob
                       (markup
                        #:hspace 2
                        #:whiteout
                        #:center-align
                        #:concat
                        (#:normal-text
                         (#:translate '(0 . -0.25)
                                      #:italic (#:fontsize 0.5 "("
                                                           ))
                         (#:translate '(0 . -0.25)
                                      #:italic (#:fontsize -10 " "
                                                           ))
                         #:pad-x
                         0
                         #:dynamic (ly:music-property dyn 'text)
                         #:normal-text
                         (#:translate '(0 . -0.25)
                                      #:italic (#:fontsize 0.5 ")")))
                        )
                       ))
                  empty-stencil
                  )
              1
              1
              (hairpin::print-part
               (scale-coords  coords
                              (+ lenx 1.85) (/ leny 2) )
               decresc? grob)
              ;vertical alignment (to be refined possibly...?)
              (- (* -2.75 (* -1 vOff) (* vOff 0.666) ))
              )
             )
            )
           )


          (cresc
           (cond (hairpinTypeA? crescStencil)
                 (hairpinTypeB? crescStencilBrokenBeginning)
                 (hairpinTypeC? crescStencilBrokenContinuation)
                 (hairpinTypeD? crescStencilBrokenEnding)
                 )
           )

          (stil
           (ly:stencil-aligned-to
            (ly:stencil-translate
             cresc
             (cons xtrans ytrans))
            Y CENTER))
          (stil-y-extent (ly:stencil-extent stil Y)))
         ; FOR DEBUG ONLY
         ; (display (list? (ly:music-property dyn 'text)))
         ; (newline)
         ; (display dyn)
         ; (newline)
         ; (newline)
         ; (display "Is this type A Hairpin? " )
         ; (display hairpinTypeA?)
         ; (newline)
         ; (display "Is this type B Hairpin? " )
         ; (display hairpinTypeB?)
         ; (newline)
         ; (display "Is this type C Hairpin? " )
         ; (display hairpinTypeC?)
         ; (newline)
         ; (display "Is this type D Hairpin? " )
         ; (display hairpinTypeD?)
         ;
         ; (newline)
         ; (display "Is it decrescendo? " )
         ; (display decresc?)
         ; (newline)
         ; (display "end-broken-spanner???  " )
         ; (display (end-broken-spanner? grob ))
         ; (newline)
         ; (display "(first-broken-spanner?) Is spanner broken
         ;         and the first of its broken siblings? " )
         ; (display (first-broken-spanner? grob ) )
         ; (newline)
         ; (display "middle-broken-spanner??? " )
         ; (display (middle-broken-spanner? grob ) )
         ; (newline)
         ;
         ; (display "Is spanner broken and not the first of
         ;         its broken siblings? " )
         ; (display (not-first-broken-spanner? grob ) )
         ; (newline)
         ;
         ; (display "Is spanner broken and not the last of
         ;         its broken siblings? " )
         ; (display (not-last-broken-spanner? grob ) )
         ; (newline)
         ;
         ; (display "unbroken-or-first-broken-spanner??? " )
         ; (display (unbroken-or-first-broken-spanner? grob ) )
         ; (newline)
         ;
         ; (display "unbroken-or-first-broken-spanner??? " )
         ; (display (unbroken-or-last-broken-spanner? grob ) )
         ; (newline)
         ; (display "unbroken spanner?? " )
         ; (display (unbroken-spanner? grob ) )
         ; (newline)
         ; (newline)
         ; (display "distance of xex " )
         ; (display lenx )
         ; (newline)
         ; (newline)
         (ly:make-stencil (ly:stencil-expr stil) xex stil-y-extent))
        ;; return empty, if no Hairpin.stencil present.
        '())))

  #{
   #dyn
   \tweak Hairpin.stencil
   #(lambda (grob)
     ;depending on the hairpin opening width,
     ;you can adjust the value here vvv
     (constante-hairpin-revised '((0 . 0) (1.0 . 0) (1.0 . 0.9)) #f)
     )
   % This calculates the tweak value for the value of the constante V-offset
   \tweak Y-offset #(lambda (grob)
                     (+ (* vOff (ly:grob-property grob 'height))
                        (* (ly:grob-property grob 'height) -0.5 vOff ))
                     )
   \<
  #}
  )
\layout {
 indent = #0
 line-width = #100
 ragged-last = ##t
}
{
 \override Hairpin.height = #0.5
 \override Hairpin.to-barline = ##f
 % \override Hairpin.stencil = #constante-hairpin
 \override Hairpin.after-line-breaking = ##t
 c'2  \constante #UP \mf  c'2 c'2 \>  c'2
 c'2 \constante #DOWN \f c'2
 \break  c'4 4 4 4 c'4 4 4 4 \break  c''2 \<
 c'2 \! \constante #DOWN \qf \break
 c'2 c'2\< c'2 c'2 c'2 c'2\! \break c'1
}