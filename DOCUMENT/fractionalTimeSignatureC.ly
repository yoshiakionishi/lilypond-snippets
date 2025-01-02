\version "2.24.4"
\language "english"

% Revised Jan 2 2025 for improving the appearance of fractions

suppressWarning =
#(define-void-function (amount message)(number? string?)
      (for-each
       (lambda (warning)
            (ly:expect-warning message))
       (iota amount 1 1)))

\suppressWarning 2 "strange time signature found"

incompleteTupletBracket =  {
     \once \override Voice.TupletBracket.edge-height = #'(0.7 . 0)
     \once \override Voice.TupletBracket.bracket-visibility = ##t

}
incompleteSmallTupletBracket =  {
     \once \override Voice.TupletBracket.edge-height = #'(0.7 . 0)
     \once \override Voice.TupletBracket.bracket-visibility = ##t
     \once \override Voice.TupletNumber.X-offset =
     #(lambda (grob)
           (if (= UP (ly:grob-property grob 'direction))
               2.2
               1.2))

     \once \override Voice.TupletBracket.shorten-pair =
     #(lambda (grob)
           (if (= UP (ly:grob-property grob 'direction))
               '(-0.7 . 0.15)
               '(-0.3 . 0.8)))
     \once \override Voice.TupletBracket.X-positions =
     #(lambda (grob)
           (if (= UP (ly:grob-property grob 'direction))
               '(1.8 . 3)
               '(0.3 . 2.7)))
}

fractionalTimeSignatureC =
#(define-music-function
  (timeSignatureToShow underlyingMeter beatStructure)
  (list? fraction? number-list?)
  #{

       \time $underlyingMeter
       \set beatStructure = $beatStructure

       \override Staff.TimeSignature.stencil =
       #ly:text-interface::print
       \override Staff.TimeSignature.text =

       #(if (= (length timeSignatureToShow) 4)

            (markup
             (make-override-markup
              (cons 'baseline-skip 0)
              (make-center-column-markup
               (list
                (make-line-markup
                 (list
                  (make-number-markup
                   (number->string
                    (car timeSignatureToShow)))
                  (make-fontsize-markup
                   -12
                   (make-simple-markup " "))


                  (make-hspace-markup -1.25)
                  (make-translate-markup
                   (cons 0 0.4)
                   (make-bold-markup
                    (make-simple-markup "+")))

                  (make-hspace-markup -0.25)

                  (make-hspace-markup -0.5)
                  (make-right-align-markup
                   (make-number-markup
                    (number->string
                     (cadr timeSignatureToShow))))

                  (make-hspace-markup -0.6)

                  (make-override-markup
                   (list (cons 'alignment 0)
                         (cons 'thickness 2))
                   (make-draw-line-markup (cons 0.5 2)))

                  (make-hspace-markup -0.6)

                  (make-number-markup
                   (make-left-align-markup
                    (number->string
                     (caddr timeSignatureToShow))))))

                (make-number-markup
                 (number->string
                  (cadddr timeSignatureToShow)))))))


            (markup
             (make-override-markup
              (cons 'baseline-skip 0)
              (make-center-column-markup
               (list
                (make-line-markup
                 (list

                  (make-right-align-markup
                   (make-number-markup
                    (number->string
                     (car timeSignatureToShow))))

                  (make-hspace-markup -0.6)

                  (make-override-markup
                   (list (cons 'alignment 0)
                         (cons 'thickness 2))
                   (make-draw-line-markup
                    (cons 0.5 2)))

                  (make-hspace-markup -0.6)

                  (make-number-markup
                   (make-left-align-markup
                    (number->string
                     (cadr timeSignatureToShow))))))

                (make-number-markup
                 (number->string
                  (caddr timeSignatureToShow))))))
             ))
  #})


{
     \fractionalTimeSignatureC #'(3 2 3 4) 11/12 3,3,3,2
     \tuplet 3/2 { c'8 c' c'} \tuplet 3/2 {c' c' c'}
     \tuplet 3/2 {c' c' c'}
     \incompleteTupletBracket \tuplet 3/2 {c' c'}
}


{
     \fractionalTimeSignatureC #'(1 3 4) 11/12 3,3,3,2
     \tuplet 3/2 { c'8 c' c'} \tuplet 3/2 {c' c' c'}
     \tuplet 3/2 {c' c' c'}
     \incompleteTupletBracket \tuplet 3/2 {c' c'}
}
