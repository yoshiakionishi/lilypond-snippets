\version "2.24.4"
\language "english"

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
         #:override
         (cons 'baseline-skip 0)
         (#:center-column
          (#:number
           (#:concat
            (#:simple
             (number->string (car timeSignatureToShow))

             (#:fontsize -12 (string-append " "))
             (string-append "+")
             (#:fontsize -12 (string-append " "))


             #:concat
             (#:combine
              (#:halign 1.5
                        (#:translate
                         (cons 0 0)
                         (#:fontsize 0
                                     (number->string
                                      (cadr timeSignatureToShow)))))
              (#:combine
               (#:halign
                -0.15
                (#:translate
                 (cons 0 0)
                 (#:override
                  (cons 'thickness 2)
                  #:draw-line (cons 0.5 2))))
               (#:translate
                (cons 0.5 0)
                (#:fontsize 0
                            (number->string
                             (caddr timeSignatureToShow))))))))
           #:number
           (number->string
            (cadddr timeSignatureToShow)))))


        (markup
         #:override
         (cons 'baseline-skip 0)
         (#:center-column
          (#:number
           (#:concat
            (#:combine
             (#:halign 1.5
                       (#:translate
                        (cons 0 0)
                        (#:fontsize 0
                                    (number->string
                                     (car timeSignatureToShow)))))
             (#:combine
              (#:halign
               -0.15
               (#:translate
                (cons 0 0)
                (#:override
                 (cons 'thickness 2)
                 #:draw-line  (cons 0.5 2))))
              (#:translate
               (cons 0.5 0)
               (#:fontsize 0
                           (number->string
                            (cadr timeSignatureToShow)))))))
           #:number
           (number->string
            (caddr timeSignatureToShow)))))

        )
  #})


{
 \fractionalTimeSignatureC #'(3 2 3 4) 11/12 3,3,3,2
 \tuplet 3/2 { c'8 c' c'} \tuplet 3/2 {c' c' c'}
 \tuplet 3/2 {c' c' c'}
 \incompleteTupletBracket \tuplet 3/2 {c' c'}
}


{
 \fractionalTimeSignatureC #'(11 3 4) 11/12 3,3,3,2
 \tuplet 3/2 { c'8 c' c'} \tuplet 3/2 {c' c' c'}
 \tuplet 3/2 {c' c' c'}
 \incompleteTupletBracket \tuplet 3/2 {c' c'}
}
