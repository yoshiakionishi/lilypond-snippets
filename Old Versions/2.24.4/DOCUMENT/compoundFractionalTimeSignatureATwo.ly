\version "2.24.4"
\pointAndClickOff
\language "english"

% Revised Aug 10 2025 to include the function to revert to a
% regular time signature

suppressWarning =
#(define-void-function (amount message)(number? string?)
  (for-each
   (lambda (warning)
    (ly:expect-warning message))
   (iota amount 1 1)))

\suppressWarning 1 "strange time signature found"

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

compoundFractionalTimeSignatureATwo =
#(define-music-function
  (timeSignatureToShow underlyingMeter beatStructure)
  (list? fraction? number-list?)
  (define mkup
   (markup
    #:concat
    (
     #:override
     (cons 'baseline-skip 0)
     (cond ((= (length (car timeSignatureToShow)) 2)
            (make-center-column-markup
             (list (make-number-markup
                    (number->string
                     (car (car timeSignatureToShow))))
                   (make-number-markup
                    (number->string
                     (cadr (car timeSignatureToShow)))))))

           ((= (length (car timeSignatureToShow)) 3)
            (make-override-markup
             (cons 'baseline-skip 0)
             (make-center-column-markup
              (list


               (make-center-column-markup
                (list
                 (make-translate-markup
                  (cons 0 1)
                  (make-fontsize-markup
                   -6
                   (make-number-markup
                    (number->string
                     (car (car timeSignatureToShow))))))
                 (make-translate-markup
                  (cons 0 0)
                  (make-fontsize-markup
                   -6
                   (make-number-markup
                    (number->string
                     (cadr (car timeSignatureToShow))))))))
               (make-number-markup
                (number->string
                 (caddr (car timeSignatureToShow))))))
             ))


           ((= (length (car timeSignatureToShow)) 4)

            (make-override-markup
             (cons 'baseline-skip 0)
             (make-center-column-markup
              (list

               (make-concat-markup
                (list (make-number-markup
                       (number->string
                        (car (car timeSignatureToShow))))
                      (make-halign-markup
                       -1.5
                       (make-center-column-markup
                        (list
                         (make-translate-markup
                          (cons 0 1)
                          (make-fontsize-markup
                           -6
                           (make-number-markup
                            (number->string
                             (cadr (car timeSignatureToShow))))))
                         (make-translate-markup
                          (cons 0 0)
                          (make-fontsize-markup
                           -6
                           (make-number-markup
                            (number->string
                             (caddr (car timeSignatureToShow)))))))))))
               (make-number-markup
                (number->string
                 (cadddr (car timeSignatureToShow))))))
             ))
           )


     #:translate
     (cons 0 -0.5)
     (#:fontsize -12 " ")
     #:translate
     (cons 0 -0.5)
     (#:bold "+")
     #:translate
     (cons 0 -0.5)
     (#:fontsize -12 " ")

     #:override
     (cons 'baseline-skip 0)
     (cond ((= (length (cadr timeSignatureToShow)) 2)
            (make-center-column-markup
             (list (make-number-markup
                    (number->string
                     (car (cadr timeSignatureToShow))))
                   (make-number-markup
                    (number->string
                     (cadr (cadr timeSignatureToShow)))))))

           ((= (length (cadr timeSignatureToShow)) 3)

            (make-override-markup
             (cons 'baseline-skip 0)
             (make-center-column-markup
              (list


               (make-center-column-markup
                (list
                 (make-translate-markup
                  (cons 0 1)
                  (make-fontsize-markup
                   -6
                   (make-number-markup
                    (number->string
                     (car (cadr timeSignatureToShow))))))
                 (make-translate-markup
                  (cons 0 0)
                  (make-fontsize-markup
                   -6
                   (make-number-markup
                    (number->string
                     (cadr (cadr timeSignatureToShow))))))))
               (make-number-markup
                (number->string
                 (caddr (cadr timeSignatureToShow))))))
             ))


           ((= (length (cadr timeSignatureToShow)) 4)

            (make-override-markup
             (cons 'baseline-skip 0)
             (make-center-column-markup
              (list

               (make-concat-markup
                (list (make-number-markup
                       (number->string
                        (car (cadr timeSignatureToShow))))
                      (make-halign-markup
                       -1.5
                       (make-center-column-markup
                        (list
                         (make-translate-markup
                          (cons 0 1)
                          (make-fontsize-markup
                           -6
                           (make-number-markup
                            (number->string
                             (cadr (cadr timeSignatureToShow))))))
                         (make-translate-markup
                          (cons 0 0)
                          (make-fontsize-markup
                           -6
                           (make-number-markup
                            (number->string
                             (caddr (cadr timeSignatureToShow)))))))))))
               (make-number-markup
                (number->string
                 (cadddr (cadr timeSignatureToShow))))))
             ))
           )
     )))

  #{
   \time $underlyingMeter
   \set beatStructure = $beatStructure

   \override Timing.TimeSignature.stencil =
   #ly:text-interface::print
   \override Timing.TimeSignature.text =
   #mkup
  #})


backToNormalTimeSignature =
{
 \unset beatStructure
 \revert Timing.TimeSignature.stencil
 \revert Timing.TimeSignature.text
 \revert Staff.TimeSignature.stencil
 \revert Staff.TimeSignature.text
}


{
 \compoundFractionalTimeSignatureATwo #'((3 4)(2 3 4)) 11/12 3,3,3,2
 \tuplet 3/2 { c'8 c' c'} \tuplet 3/2 {c' c' c'}
 \tuplet 3/2 {c' c' c'}
 \incompleteTupletBracket \tuplet 3/2 {c' c'}
 \backToNormalTimeSignature
 \time 3/4
 c'2.
}