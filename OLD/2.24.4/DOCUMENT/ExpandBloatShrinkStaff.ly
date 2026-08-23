\version "2.24.4"
\pointAndClickOff
\language "english"

shrinkingStaff =
#(define-music-function
  (staffDist)
  (number?)

  #{
    \stopStaff
    \once  \override Staff.StaffSymbol.stencil = #ly:text-interface::print
    \once  \override Staff.StaffSymbol.text = \markup {
      \postscript #(string-append
                    "newpath 
          0 4 moveto 
          0 4 6 2 " (number->string staffDist) " 2 curveto 
          0 2 moveto 
          0 2 6 1 " (number->string staffDist) " 1 curveto
          0 0 moveto "
                    (number->string staffDist) " 0 lineto
          0 -2 moveto 
          0 -2 6 -1 " (number->string staffDist) " -1 curveto
          0 -4 moveto
          0 -4 6 -2 " (number->string staffDist) " -2 curveto
          stroke")


    }
    \override Staff.StaffSymbol.line-positions = #'(-4 -2 0 2 4 )
    \startStaff
  #})

normalStaff = {
  \stopStaff
  \revert Staff.StaffSymbol.line-positions
  \revert Staff.StaffSymbol.stencil
  \startStaff
}

expandingStaff =
#(define-music-function
  (staffDist)
  (number?)

  #{

    \stopStaff
    \once  \override Staff.StaffSymbol.stencil = #ly:text-interface::print
    \once  \override Staff.StaffSymbol.text = \markup {
      \postscript #(string-append
                    "newpath 
          0 2 moveto 
          0 2 6 2 " (number->string staffDist) " 4 curveto 
          0 1 moveto
          0 1 6 1 " (number->string staffDist) " 2 curveto 
          0 0 moveto "
                    (number->string staffDist) " 0 lineto
          0 -1 moveto 
          0 -1 6 -1 " (number->string staffDist) " -2 curveto 
          0 -2 moveto
          0 -2 6 -2 " (number->string staffDist) " -4 curveto
          stroke ")
    }

    \startStaff
    \override Staff.StaffSymbol.line-positions = #'(-8 -4 0 4 8 )
  #})

bloatedStaff = {
  \stopStaff
  \override Staff.StaffSymbol.line-positions = #'(-8 -4 0 4 8 )
  \override Staff.LedgerLineSpanner.stencil = ##f
  \startStaff
}



% to adjust the length of the individual barlines, see:
% https://lilypond.org/doc/v2.24/Documentation/internals/barline

{

  \override Staff.LedgerLineSpanner.transparent = ##t
  \numericTimeSignature
  \time 3/4
  \once \override Staff.BarLine.bar-extent = #'(-2 . 2)
  d''4 \expandingStaff #8.5

  g'8 a' b' c''
  \once \override Staff.BarLine.bar-extent = #'(-4 . 4)
  \shrinkingStaff #8.5
  d''4 g' \expandingStaff #9.5 g'
  \once \override Staff.BarLine.bar-extent = #'(-2.5 . 2.5)


  e''4 \bloatedStaff c''8 d'' e'' fs''
  \once \override Staff.BarLine.bar-extent = #'(-4 . 4)

  \shrinkingStaff #13.5

  g''4 g' g'
  \bar ".."

}

\layout {
  \context{
    \Score   proportionalNotationDuration = #(ly:make-moment 1/6)
  }
}


