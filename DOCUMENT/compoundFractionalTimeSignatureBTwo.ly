\version "2.24.4"
\language "english"

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

compoundFractionalTimeSignatureBTwo =
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
               (make-number-markup
                (make-concat-markup
                 (list
                  (make-combine-markup
                   (make-halign-markup
                    0.5
                    (make-translate-markup
                     (cons 0 1.6)
                     (make-fontsize-markup
                      -3
                      (make-number-markup
                       (number->string
                        (car (car timeSignatureToShow)))))))
                   (make-combine-markup
                    (make-halign-markup
                     -0.4
                     (make-translate-markup
                      (cons 0 0.85)
                      (make-draw-line-markup (cons 1.5 1.35))))
                    (make-translate-markup
                     (cons 0.25 0)
                     (make-fontsize-markup
                      -3
                      (make-number-markup
                       (number->string
                        (cadr (car timeSignatureToShow)))))))))))
               (make-number-markup
                (number->string
                 (caddr (car timeSignatureToShow))))))))


           ((= (length (car timeSignatureToShow)) 4)

            (make-override-markup
             (cons 'baseline-skip 0)
             (make-center-column-markup
              (list
               (make-concat-markup
                (list
                 (make-number-markup
                  (number->string
                   (car (car timeSignatureToShow))))
                 (make-concat-markup
                  (list
                   (make-combine-markup

                    (make-halign-markup
                     0.4
                     (make-translate-markup
                      (cons 0 1.35)
                      (make-fontsize-markup
                       -3
                       (make-number-markup
                        (number->string
                         (cadr (car timeSignatureToShow)))))))
                    (make-combine-markup

                     (make-halign-markup
                      -0.4
                      (make-translate-markup
                       (cons 0 0.75)
                       (make-draw-line-markup (cons 1.5 1.35))))
                     (make-translate-markup
                      (cons 0.25 0)
                      (make-fontsize-markup
                       -3
                       (make-number-markup
                        (number->string
                         (caddr (car timeSignatureToShow))))))))))))
               (make-number-markup
                (number->string
                 (cadddr (car timeSignatureToShow)))))))))


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
               (make-number-markup
                (make-concat-markup
                 (list
                  (make-combine-markup
                   (make-halign-markup
                    0.5
                    (make-translate-markup
                     (cons 0 1.6)
                     (make-fontsize-markup
                      -3
                      (make-number-markup
                       (number->string
                        (car (cadr timeSignatureToShow)))))))
                   (make-combine-markup
                    (make-halign-markup
                     -0.4
                     (make-translate-markup
                      (cons 0 0.85)
                      (make-draw-line-markup (cons 1.5 1.35))))
                    (make-translate-markup
                     (cons 0.25 0)
                     (make-fontsize-markup
                      -3
                      (make-number-markup
                       (number->string
                        (cadr (cadr timeSignatureToShow)))))))))))
               (make-number-markup
                (number->string
                 (caddr (cadr timeSignatureToShow))))))))


           ((= (length (cadr timeSignatureToShow)) 4)

            (make-override-markup
             (cons 'baseline-skip 0)
             (make-center-column-markup
              (list
               (make-concat-markup
                (list
                 (make-number-markup
                  (number->string
                   (car (cadr timeSignatureToShow))))
                 (make-concat-markup
                  (list
                   (make-combine-markup

                    (make-halign-markup
                     0.4
                     (make-translate-markup
                      (cons 0 1.35)
                      (make-fontsize-markup
                       -3
                       (make-number-markup
                        (number->string
                         (cadr (cadr timeSignatureToShow)))))))
                    (make-combine-markup

                     (make-halign-markup
                      -0.4
                      (make-translate-markup
                       (cons 0 0.75)
                       (make-draw-line-markup (cons 1.5 1.35))))
                     (make-translate-markup
                      (cons 0.25 0)
                      (make-fontsize-markup
                       -3
                       (make-number-markup
                        (number->string
                         (caddr (cadr timeSignatureToShow))))))))))))
               (make-number-markup
                (number->string
                 (cadddr (cadr timeSignatureToShow)))))))))
     )))

  #{
   \time $underlyingMeter
   \set beatStructure = $beatStructure

   \override Timing.TimeSignature.stencil =
   #ly:text-interface::print
   \override Timing.TimeSignature.text =
   #mkup
  #})


{

 \compoundFractionalTimeSignatureBTwo #'((3 4)(2 3 4)) 11/12 3,3,3,2
 \tuplet 3/2 { c'8 c' c'} \tuplet 3/2 {c' c' c'}
 \tuplet 3/2 {c' c' c'}
 \incompleteTupletBracket \tuplet 3/2 {c' c'}
}