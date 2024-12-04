\version "2.24.4"

\include "YO_Snippets.ly"


#(define-public ((tuplet-number::append-note-wrapper function note) grob)
   (let ((txt (function grob)))
     (markup txt #:fontsize -5 #:note note UP)))



\score {
  {
    \override Staff.StaffSymbol.line-positions = #'(6  -6)
    \strPosClef \dashedLineNotehead g'4^\markup {\fontsize #-4 \italic flaut.}^\markup \translate #'(-2.5 . -0) \center-column {\translate #'(0 . -1.5) \fontsize #-4 II \fontsize #-4 III} a' #6
    \modularLineNotehead a'^\markup \column {\translate #'(0 . -1.5)\fontsize #-4 \italic apply \fontsize #-4 \italic pressure} d'' #15 #150 #6
    \override TupletNumber.text = #tuplet-number::calc-fraction-text
    %      \override TupletNumber.text = #(tuplet-number::append-note-wrapper tuplet-number::calc-fraction-text (ly:make-duration 3 0))
    \stemUp  \tuplet 5/4 {
      \modularLineNotehead d''8 b' #150 #50 #2.5
      \modularLineNotehead b' f'' #50 #175 #2.5
      \modularLineNotehead f'' a' #175 #70 #2.5
      \modularLineNotehead a' c'' #70 #120 #2.5
      \modularLineNotehead c'' e' #120 #15 #3.5
    }
    |
    \modularLineNotehead e'4^\markup {\fontsize #-4 \italic ord.} e' #15 #15 #12
    \noteheadless e'
    \dashedLineNotehead e'^\markup {\fontsize #-4 \italic (flaut.)} e' #5
  }

  \layout {
    \context {
      \Score proportionalNotationDuration = #(ly:make-moment 1/10)    \override SpacingSpanner.uniform-stretching = ##t
    }
  }
}