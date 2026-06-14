% !TEX TS-program = LilyPond
\pointAndClickOff
% Inspired by:
% https://lists.gnu.org/archive/html/lilypond-user/2014-06/msg00209.html

% Revised Aug 10 2025 to include the function to revert to a
% regular time signature

\version "2.24.4"
\language "english"

suppressWarning =
#(define-void-function (amount message)(number? string?)
  (for-each
   (lambda (warning)
    (ly:expect-warning message))
   (iota amount 1 1)))

\suppressWarning 3 "strange time signature found"

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

fractionalTimeSignatureA =
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
             #:halign -1.5
             (#:center-column
              ((#:translate
                (cons 0 1)
                (#:fontsize -6
                            (number->string
                             (cadr timeSignatureToShow))))
               (#:translate
                (cons 0 0)
                (#:fontsize -6
                            (number->string
                             (caddr timeSignatureToShow))))))))
           #:number
           (number->string (cadddr timeSignatureToShow)))))

        (markup
         #:override
         (cons 'baseline-skip 0)
         (#:center-column
          (#:number
           (#:translate
            (cons 0 1)
            (#:fontsize -6 (number->string
                            (car timeSignatureToShow))))
           #:number
           (#:translate
            (cons 0 0)
            (#:fontsize -6 (number->string
                            (cadr timeSignatureToShow))))
           #:number
           (number->string (caddr timeSignatureToShow)))))

        )
  #})

fractionalTimeSignatureAPlus =
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

             #:center-column
             ((#:translate
               (cons 0 1)
               (#:fontsize -6
                           (number->string
                            (cadr timeSignatureToShow))))
              (#:translate
               (cons 0 0)
               (#:fontsize -6
                           (number->string
                            (caddr timeSignatureToShow)))))))
           #:number
           (number->string (cadddr timeSignatureToShow)))))

        (markup
         #:override
         (cons 'baseline-skip 0)
         (#:center-column
          (#:number
           (#:translate
            (cons 0 1)
            (#:fontsize -6 (number->string
                            (car timeSignatureToShow))))
           #:number
           (#:translate
            (cons 0 0)
            (#:fontsize -6 (number->string
                            (cadr timeSignatureToShow))))
           #:number
           (number->string (caddr timeSignatureToShow)))))

        )
  #})


backToNormalTimeSignature =
{
 \unset beatStructure
 \revert Timing.TimeSignature.stencil
 \revert Timing.TimeSignature.text
 \revert Staff.TimeSignature.stencil
 \revert Staff.TimeSignature.text
}


\new Staff \with { instrumentName = \markup {\fontsize #4 \box "A"}} {
 \fractionalTimeSignatureA #'(3 2 3 4) 11/12 3,3,3,2
 \tuplet 3/2 { c'8 c' c'} \tuplet 3/2 {c' c' c'}
 \tuplet 3/2 {c' c' c'}
 \incompleteTupletBracket \tuplet 3/2 {c' c'}
 \backToNormalTimeSignature
 \time 3/4
 c'2.
}
\new Staff \with { instrumentName = \markup {\fontsize #4 \box "B"}} {
 \fractionalTimeSignatureAPlus #'(3 2 3 4) 11/12 3,3,3,2
 \tuplet 3/2 { c'8 c' c'} \tuplet 3/2 {c' c' c'}
 \tuplet 3/2 {c' c' c'}
 \incompleteTupletBracket \tuplet 3/2 {c' c'}
 \backToNormalTimeSignature
 \time 3/4
 c'2.
}
\new Staff \with { instrumentName = \markup {\fontsize #4 \box "C"}} {
 \fractionalTimeSignatureA #'(11 3 4) 11/12 3,3,3,2
 \tuplet 3/2 { c'8 c' c'} \tuplet 3/2 {c' c' c'}
 \tuplet 3/2 {c' c' c'}
 \incompleteTupletBracket \tuplet 3/2 {c' c'}
 \backToNormalTimeSignature
 \time 3/4
 c'2.
}