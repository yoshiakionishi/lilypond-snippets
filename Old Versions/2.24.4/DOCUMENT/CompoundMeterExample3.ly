\version "2.24.4"
\pointAndClickOff
compoundTimeWithBeatStructure =
#(define-music-function (timesig beatstruct) (fraction? list?)
   #{
     \time #timesig
     \set beatStructure = #(cadr beatstruct)
     \once \override Timing.TimeSignature.stencil = #ly:text-interface::print
     \once \override Timing.TimeSignature.text = \markup
     {
       \override #'(baseline-skip . 0)
       \center-column \number
       {
         #(number->string (car (car beatstruct)))
         #(number->string (cadr (car beatstruct)))
       }
       \center-column {\fontsize #6 \musicglyph "accidentals.leftparen"}
       \hspace #-0.75
       \override #'(baseline-skip . 0)
       \center-column \number
       {
         {#(string-join (map number->string (cadr beatstruct)) "+")}
         #(number->string (car (caddr beatstruct)))
       }
       \hspace #-0.75
       \center-column {\fontsize #6 \musicglyph "accidentals.rightparen"}
       \hspace #-1
     }
   #}

   )

{
  \compoundTimeWithBeatStructure 9/8 #'((9 8)(2 2 2 3)(8))
  \repeat unfold 9 {<e' g'>8}
  \compoundTimeWithBeatStructure 11/8 #'((11 8)(2 2 2 3 2)(8))
  \repeat unfold 11 {<e' g'>8}
  \compoundTimeWithBeatStructure 7/8 #'((7 8)(2 3 2)(8))
  \repeat unfold 7 {<e' g'>8}
}