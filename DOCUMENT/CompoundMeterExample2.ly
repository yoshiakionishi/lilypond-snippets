\version "2.24.4"

{
  \clef "G"
  \time 9/8
  \set beatStructure = #'(2 2 2 3)
  \once \override Timing.TimeSignature.stencil = #ly:text-interface::print
  \once \override Timing.TimeSignature.text = \markup
  {
    \override #'(baseline-skip . 0)
    \center-column \number {9 8}
    \center-column {\fontsize #6 \musicglyph "accidentals.leftparen"}
    \hspace #-0.75
    \override #'(baseline-skip . 0)
    \center-column \number {{2+2+2+3} 8}
    \hspace #-0.75
    \center-column {\fontsize #6 \musicglyph "accidentals.rightparen"}
    \hspace #-1
  }
  \repeat unfold 9 {<e' g'>8}

  \time 11/8
  \set beatStructure = #'(2 2 2 3 2)
  \once \override Timing.TimeSignature.stencil = #ly:text-interface::print
  \once \override Timing.TimeSignature.text = \markup
  {
    \override #'(baseline-skip . 0)
    \center-column \number {11 8}
    \center-column {\fontsize #6 \musicglyph "accidentals.leftparen"}
    \hspace #-0.75
    \override #'(baseline-skip . 0)
    \center-column \number {{2+2+2+3+2} 8}
    \hspace #-0.75
    \center-column {\fontsize #6 \musicglyph "accidentals.rightparen"}
    \hspace #-1
  }
  \repeat unfold 11 {<e' g'>8 }

  \time 7/8
  \set beatStructure = #'(2 3 2)
  \once \override Timing.TimeSignature.stencil = #ly:text-interface::print
  \once \override Timing.TimeSignature.text = \markup
  {
    \override #'(baseline-skip . 0)
    \center-column \number {7 8}
    \center-column {\fontsize #6 \musicglyph "accidentals.leftparen"}
    \hspace #-0.75
    \override #'(baseline-skip . 0)
    \center-column \number {{2+3+2} 8}
    \hspace #-0.75
    \center-column {\fontsize #6 \musicglyph "accidentals.rightparen"}
    \hspace #-1
  }
  \repeat unfold 7 {<e' g'>8 }

}


