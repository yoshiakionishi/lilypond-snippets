\version "2.24.4"
\language "english"


\layout {
  \context{
    \Score   proportionalNotationDuration = #(ly:make-moment 1/6)
  }
}

shrinkin =
#(define-music-function
  (staffDist)
  (number?)

  #{
    \stopStaff
    \once  \override Staff.StaffSymbol.stencil = #ly:text-interface::print
    \once  \override Staff.StaffSymbol.text = \markup {
      \postscript #(string-append "newpath "
                                  "0 " "4 " "moveto "
                                  "0 " "4 " "6 " "2 " (number->string staffDist) " " "2 " "curveto "
                                  "0 " "2 " "moveto "
                                  "0 " "2 " "6 " "1 " (number->string staffDist) " " "1 " "curveto "
                                  "0 " "0 " "moveto "
                                  (number->string staffDist) " " "0 " "lineto "
                                  "0 " "-2 " "moveto "
                                  "0 " "-2 " "6 " "-1 " (number->string staffDist) " " "-1 " "curveto "
                                  "0 " "-4 " "moveto "
                                  "0 " "-4 " "6 " "-2 " (number->string staffDist) " " "-2 " "curveto "
                                  "stroke ")


    }    \override Staff.StaffSymbol.line-positions = #'(-4 -2 0 2 4 )
    \startStaff
  #})

normalin = {\stopStaff \revert Staff.StaffSymbol.line-positions \revert Staff.StaffSymbol.stencil \startStaff}

expandin =
#(define-music-function
  (staffDist)
  (number?)

  #{

    \stopStaff
    \once  \override Staff.StaffSymbol.stencil = #ly:text-interface::print
    \once  \override Staff.StaffSymbol.text = \markup {
      \postscript #(string-append "newpath "
                                  "0 " "2 " "moveto "
                                  "0 " "2 " "6 " "2 " (number->string staffDist) " " "4 " "curveto "
                                  "0 " "1 " "moveto "
                                  "0 " "1 " "6 " "1 " (number->string staffDist) " " "2 " "curveto "
                                  "0 " "0 " "moveto "
                                  (number->string staffDist) " " "0 " "lineto "
                                  "0 " "-1 " "moveto "
                                  "0 " "-1 " "6 " "-1 " (number->string staffDist) " " "-2 " "curveto "
                                  "0 " "-2 " "moveto "
                                  "0 " "-2 " "6 " "-2 " (number->string staffDist) " " "-4 " "curveto "
                                  "stroke ")


    }

    \startStaff
    \override Staff.StaffSymbol.line-positions = #'(-8 -4 0 4 8 )
  #})

bloatin = {\stopStaff  \override Staff.StaffSymbol.line-positions = #'(-8 -4 0 4 8 )   \override Staff.LedgerLineSpanner.stencil = ##f \startStaff}






{

  \override Staff.LedgerLineSpanner.transparent = ##t
  \numericTimeSignature
  \time 3/4
  \normalin

  d''4 g'8 a' b' c'' |
  \expandin #22.5
  d''4 g' g' |
  \bloatin

  e''4 c''8 d'' e'' fs''
  \shrinkin #15

  g''4 g' g'
  \bar ".."

}



