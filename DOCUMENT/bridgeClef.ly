\version "2.24.4"

\pointAndClickOff

strPosClefDesign = #(ly:make-stencil (list 'embedded-ps
                                           "gsave
currentpoint translate
/fingboardpath
{

newpath 

-0.55 7.5 moveto
0 -3 rlineto
1 -6.5 rlineto
-1 -1 rlineto
0 -3 rlineto
4.1 0 rlineto
0 3 rlineto
-1 1 rlineto
1 6.5 rlineto
0 3 rlineto
closepath

} def

fingboardpath clip
newpath 
0.15 setlinewidth
0.5 4.75 moveto
0 -6.8 rlineto
-0.75 5 rlineto
3.5 0 rlineto
-0.75 -5 rlineto
0. 6.8 rlineto
stroke
0.35 setlinewidth
-0.4 2.75 moveto
3.75 0 rlineto
stroke

%inner two line
newpath
0.15 setlinewidth
1.16 4.75 moveto
0. -6.8 rlineto
1.8 4.75 moveto
0. -6.8 rlineto
stroke

%bridge
newpath
-0.4 3.6 moveto
0.3 0.4 rlineto
3.2 0 rlineto
0.3 -0.4 rlineto
stroke

%tailpiece
0.15 4.75 moveto 
1 setlinecap
1 setlinejoin
2.75 0 rlineto
-0.65 1.75 rlineto
-0 -0  -0.6 0.55 -1.45 0  rcurveto
closepath
stroke

newpath
0.2 setlinewidth
1 setlinecap
1.5 -2.25 moveto
0 -2.5 rlineto
0.25 -3.5 moveto
2.5 0 rlineto
stroke
newpath
1.5 -3.5 0.85 0 360 arc
stroke
grestore")
                                     (cons 0 3)
                                     (cons 0 1))

strPosClefSize =
#(lambda (grob)
   (let* ((sPCS (ly:grob-property grob 'font-size 0.0))
          (mult (magstep sPCS)))
     (ly:stencil-scale
      strPosClef
      mult mult)))

strPosClef = {
  \override Staff.Clef.stencil = \strPosClefDesign
}

normalClef = {
  \revert Staff.Clef.stencil
}

{
  \override Staff.StaffSymbol.line-positions = #'(6  -6)
  \override Staff.LedgerLineSpanner.stencil = ##f
  \override Staff.TimeSignature.stencil = ##f
  \override Staff.BarLine.stencil = ##f
  \bridgeClef c'4^\markup {
    \translate #'(-3 . 2)
    \musicglyph "space"
  }
  _\markup {
    \translate #'(-3 . -3)
    \musicglyph "space"
  }
  e' g' b' d'' f'' a''
}
