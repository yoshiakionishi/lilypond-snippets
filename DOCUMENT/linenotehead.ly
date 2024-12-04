\version "2.24.4"

\include "YO_Snippets.ly"




\score {
  {

    \dashedLineNotehead g'4 a' #6
    \modularLineNotehead a' d'' #15 #150 #6
    \override TupletNumber.text = #tuplet-number::calc-fraction-text

    \stemUp  \tuplet 5/4 {
      \modularLineNotehead d''8 b' #150 #50 #2.5
      \modularLineNotehead b' f'' #50 #175 #2.5
      \modularLineNotehead f'' a' #175 #70 #2.5
      \modularLineNotehead a' c'' #70 #120 #2.5
      \modularLineNotehead c'' c' #120 #15 #3.5
    }
    |
    \modularLineNotehead c'4 c' #15 #15 #12
    \noteheadless c'
    \dashedLineNotehead c' c' #5
  }

  \layout {
    \context {
      \Score proportionalNotationDuration = #(ly:make-moment 1/10)
      \override SpacingSpanner.uniform-stretching = ##t
    }
  }
}