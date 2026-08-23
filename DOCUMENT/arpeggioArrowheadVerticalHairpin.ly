\version "2.26.0"

\pointAndClickOff

\language "english"

arpeggioWithVerticalHairpinSingleStaff =
#(define-music-function
  (arpeggioDirection hairpinType dynamicUP dynamicDOWN hairpinOffset )
  (ly:dir? ly:dir? string? string? number? )
  #{
   \once \override Staff.Arpeggio.X-extent =
   #'(-2 . 0.75)
   % NB: Override this value if you wish to adjust
   % the general placement of arpeggio and hairpin
   % as a pair
   \once \override Staff.Arpeggio.stencil =
   #(grob-transformer
     'stencil
     (lambda (grob original)
      (let* ((pos (ly:grob-property grob 'positions))
             (arpeggioArrowStencil
              (if  (eq? arpeggioDirection UP )
                   ;FOR UPWARD ARROW
                   (cons 0.4 (+ (cdr pos) 1.45))
                   ;FOR DOWNWARD ARROW
                   (cons 0.4 (- (car pos) 1.75))
                   )
              )
             (added-markup-one
              (markup
               #:overlay
               (
                #:translate  arpeggioArrowStencil
                #:scale  (cons 1.25 1.25)
                #:arrow-head 1 (if (eq? arpeggioDirection UP ) 1 -1) #t
                )
               ))
             (hairpinStencil
              (if (eq? hairpinType UP )
                  ; UNCOMMENT THIS FOR UPWARD CRESCENDO
                  (list (list 'moveto -1  (car pos))
                        (list 'rlineto -0.5   (- (cdr pos) (car pos)))
                        (list 'moveto -1 (car pos))
                        (list 'rlineto 0.5   (- (cdr pos) (car pos)))
                        )
                  ; UNCOMMENT THIS FOR DOWNWARD CRESCENDO
                  (list (list 'moveto -0.5 (car pos))
                        (list 'rlineto -0.5   (- (cdr pos) (car pos)))
                        (list 'moveto -1.5 (car pos))
                        (list 'rlineto 0.5   (- (cdr pos) (car pos)))
                        )
                  ))
             (added-markup-two
              (markup
               #:overlay
               (
                #:general-align X CENTER
                #:translate-scaled (cons -1.5  (+ (cdr pos) 1))
                #:whiteout
                #:dynamic
                dynamicUP

                #:general-align X CENTER
                #:path 0.15 hairpinStencil

                #:general-align X CENTER
                #:translate-scaled (cons  -1.5  (- (car pos) 1.5))

                #:whiteout
                #:dynamic
                dynamicDOWN
                )
               )
              )
             (added-stencil-one
              (ly:stencil-add original
                              (grob-interpret-markup
                               grob added-markup-one)))
             (added-stencil-two
              (grob-interpret-markup grob added-markup-two))
             )

       (if (ly:stencil? original)
           (ly:stencil-combine-at-edge added-stencil-one
                                       X -1
                                       added-stencil-two
                                       hairpinOffset)
           added-stencil
           ))))
  #})

arpeggioWithVerticalHairpinMultipleStaves =
#(define-music-function
  (arpeggioDirection hairpinType dynamicUP dynamicDOWN hairpinOffset )
  (ly:dir? ly:dir? string? string? number? )
  #{
   \once \override Score.Arpeggio.X-extent =
   #'(-2 . 0.75)
   \once \override Score.Arpeggio.stencil =
   #(grob-transformer
     'stencil
     (lambda (grob original)
      (let* ((pos (ly:grob-property grob 'positions))
             (arpeggioArrowStencil
              (if  (eq? arpeggioDirection UP )
                   ;FOR UPWARD ARROW
                   (cons 0.4 (+ (cdr pos) 1.45))
                   ;FOR DOWNWARD ARROW
                   (cons 0.4 (- (car pos) 1.75))
                   )
              )
             (added-markup-one
              (markup
               #:overlay
               (
                #:translate  arpeggioArrowStencil
                #:scale  (cons 1.25 1.25)
                #:arrow-head 1 (if (eq? arpeggioDirection UP ) 1 -1) #t
                )
               ))
             (hairpinStencil
              (if (eq? hairpinType UP )
                  ; UNCOMMENT THIS FOR UPWARD CRESCENDO
                  (list (list 'moveto -1  (car pos))
                        (list 'rlineto -0.5   (- (cdr pos) (car pos)))
                        (list 'moveto -1 (car pos))
                        (list 'rlineto 0.5   (- (cdr pos) (car pos)))
                        )
                  ; UNCOMMENT THIS FOR DOWNWARD CRESCENDO
                  (list (list 'moveto -0.5 (car pos))
                        (list 'rlineto -0.5   (- (cdr pos) (car pos)))
                        (list 'moveto -1.5 (car pos))
                        (list 'rlineto 0.5   (- (cdr pos) (car pos)))
                        )
                  ))
             (added-markup-two
              (markup
               #:overlay
               (
                #:general-align X CENTER
                #:translate-scaled (cons -1.5  (+ (cdr pos) 1))
                #:whiteout
                #:dynamic
                dynamicUP

                #:general-align X CENTER
                #:path 0.15 hairpinStencil

                #:general-align X CENTER
                #:translate-scaled (cons  -1.5  (- (car pos) 1.5))

                #:whiteout
                #:dynamic
                dynamicDOWN
                )
               )
              )
             (added-stencil-one
              (ly:stencil-add original
                              (grob-interpret-markup
                               grob added-markup-one)))
             (added-stencil-two
              (grob-interpret-markup grob added-markup-two))
             )

       (if (ly:stencil? original)
           (ly:stencil-combine-at-edge added-stencil-one
                                       X -1
                                       added-stencil-two
                                       hairpinOffset)
           added-stencil
           ))))
  #})




{
 \arpeggioWithVerticalHairpinSingleStaff #UP #UP "f" "p" #0
 <c e g cs' e'>2 \arpeggio \laissezVibrer
}
{
 \arpeggioWithVerticalHairpinSingleStaff #DOWN #DOWN "pp" "ff" #0
 \transpose c' c'' { <c! e! g! cs' e' g' c'' e'' g''>8. }
 \arpeggio \laissezVibrer
}

\score {
 \new PianoStaff \with {

 } <<
  \new Staff = "right" \with {  }
  {
   \arpeggioWithVerticalHairpinMultipleStaves #DOWN #UP "ff" "p" #0.25
   \once \set Score.connectArpeggios = ##t
   <c' e' g' bf' d'' fs'' a''>1 \arpeggio |
   \arpeggioWithVerticalHairpinSingleStaff #UP #UP "f" " " #0
   % NB: When you wish to place no dynamic,
   % make sure you include an empty space between quotation marks,
   % otherwise 'warning: Found infinity or nan in output.  Substituting 0.0'
   % message will result.
   <c' e' g' bf' d'' fs'' a''>1 \arpeggio
   \tweak extra-offset #'(-5.25 . -0.75) \p
  }

  \new Staff = "left" \with {
  } {
   \clef bass <c, c g >1 \arpeggio
   \arpeggioWithVerticalHairpinSingleStaff #DOWN #DOWN " " "f" #0.5
   \once \override Staff.Arpeggio.extra-offset = #'(-1.75 . 1)
   % NB: in order to align the hairpin applied to the right hand staff,
   % extra-offset has been applied to offset the arpeggio and hairpin.
   <c, c g >1 \arpeggio
  }
 >>
}
