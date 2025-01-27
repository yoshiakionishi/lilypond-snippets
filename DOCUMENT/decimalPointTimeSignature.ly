\version "2.24.4"
\pointAndClickOff
\language "english"


decimalPointTimeSignature =
#(define-music-function
  (timeSignatureToShow underlyingMeter beatStructure)
  (list? fraction? number-list?)

  (define (is-float? x)
    (and (number? x) (inexact? x)))

  #{
    \time $underlyingMeter
    \set beatStructure = $beatStructure
    \override Staff.TimeSignature.stencil =
    #ly:text-interface::print
    \override Staff.TimeSignature.text =
    #(markup
      (make-override-markup
       (cons 'baseline-skip 0)
       (make-center-column-markup
        (list
         (if (= (length (car  timeSignatureToShow)) 1)
             (make-number-markup
              (number->string

               (car (car timeSignatureToShow))))
             (make-line-markup
              (list
               (make-number-markup
                (number->string
                 (car (car timeSignatureToShow))))
               (make-hspace-markup -0.5)
               (make-translate-markup
                '(0 . 0.15)
                (make-musicglyph-markup "period"))
               (make-hspace-markup -0.5)
               (if (not (is-float? (cadr (car timeSignatureToShow))))
                   (make-number-markup
                    (number->string
                     (inexact->exact (cadr (car timeSignatureToShow)))
                     ))
                   (make-line-markup
                    (list (make-number-markup
                           (number->string
                            (inexact->exact
                             (cadr (car timeSignatureToShow)))
                            ))
                          (make-hspace-markup -0.5)
                          (make-translate-markup
                           '(0 . 0.15)
                           (make-musicglyph-markup "period"))
                          (make-hspace-markup -0.5)
                          (make-translate-markup
                           '(0 . 0.15)
                           (make-musicglyph-markup "period"))
                          (make-hspace-markup -0.5)
                          (make-translate-markup
                           '(0 . 0.15)
                           (make-musicglyph-markup "period"))))
                   )
               )
              )
             )
         (if (= (length (cadr  timeSignatureToShow)) 1)
             (make-number-markup
              (number->string
               (car (cadr timeSignatureToShow))))
             (make-line-markup
              (list
               (make-number-markup
                (number->string
                 (car (cadr timeSignatureToShow))))
               (make-hspace-markup -0.5)
               (make-translate-markup
                '(0 . 0.15)
                (make-musicglyph-markup "period"))
               (make-hspace-markup -0.5)
               (if (not (is-float? (cadr (cadr timeSignatureToShow))))
                   (make-number-markup
                    (number->string
                     (inexact->exact (cadr (cadr timeSignatureToShow)))
                     ))
                   (make-line-markup
                    (list (make-number-markup
                           (number->string
                            (inexact->exact
                             (cadr (cadr timeSignatureToShow)))
                            ))
                          (make-hspace-markup -0.5)
                          (make-translate-markup
                           '(0 . 0.15)
                           (make-musicglyph-markup "period"))
                          (make-hspace-markup -0.5)
                          (make-translate-markup
                           '(0 . 0.15)
                           (make-musicglyph-markup "period"))
                          (make-hspace-markup -0.5)
                          (make-translate-markup
                           '(0 . 0.15)
                           (make-musicglyph-markup "period"))))
                   )
               )
              )
             )
         )
        ))
      (make-hspace-markup -1))
  #})


{
  \decimalPointTimeSignature #'((2 5)(4)) 5/8 2,3
  c'8 c' c' c' c'
}


{
  \decimalPointTimeSignature #'((9)(3 1415.)) 9/4 3,3,3
  \tuplet 9/9 {c'4 4 4 4 4 4 4 4 4}
}
