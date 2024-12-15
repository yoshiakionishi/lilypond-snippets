\version "2.24.4"
\language "english"

staone = {
  \stopStaff
  \override Staff.StaffSymbol.line-positions =
  #'(0 2 4 6 8)
  \startStaff
}
statwo = {
  \stopStaff
  \override Staff.StaffSymbol.line-positions =
  #'(1 3 5 7 9)
  \startStaff
}
stathree = {
  \stopStaff
  \override Staff.StaffSymbol.line-positions =
  #'(-1 1 3 5 7)
  \startStaff
}
stafour = {
  \stopStaff
  \override Staff.StaffSymbol.line-positions =
  #'(-2 0 2 4 6)
  \startStaff
}
stafive = {
  \stopStaff
  \override Staff.StaffSymbol.line-positions =
  #'(-3 -1 1 3 5)
  \startStaff
}
stanorm = {
  \stopStaff
  \revert Staff.StaffSymbol.line-positions
  \startStaff
}
{
  \numericTimeSignature
  \time 4/4

  c'4 c' \staone g' g' \statwo a' a' \staone g'2
  \stathree f'4 f' \stafour e' e' \stafive d' d' \stanorm
  \override TextScript.outside-staff-priority = ##f
  \once \override TextScript.extra-offset = #'(0 . -4.5)
  c'2 ^\markup \concat {
    {
      \hspace #3 \rotate #180
      {\compound-meter #'(4 4)}
    }
    {
      \translate-scaled #'(1 . 0.5)
      \rotate #180 \musicglyph "clefs.F"
    }
  }
  \bar ""

}

\layout {
  \context{
    \Score   proportionalNotationDuration = #(ly:make-moment 1/7)
  }
}


