\version "2.24.4"
\pointAndClickOff
stringPositionClefDesign_two = #(ly:make-stencil (list 'embedded-ps
                                                       "gsave
currentpoint translate
/fingboardpath
{

newpath 
-0.45 4.75 moveto
0 -5 rlineto
0.5 -2.75 rlineto
2.9 0 rlineto
0.5 2.75 rlineto
0 5 rlineto
closepath
} def

fingboardpath clip
newpath 
0.15 setlinewidth
0.5 8 moveto
0 -13.8 rlineto
-0.75 5 rlineto
3.5 0 rlineto
-0.75 -5 rlineto
0 11 rlineto
stroke
0.35 setlinewidth
-0.4 -1 moveto
3.75 0 rlineto
stroke

%inner two line
newpath
0.15 setlinewidth
1.16 4.75 moveto
0. -7.75 rlineto
1.8 4.75 moveto
0. -7.75 rlineto
stroke

%bridge
newpath
-0.4 3.6 moveto
0.3 0.4 rlineto
3.2 0 rlineto
0.3 -0.4 rlineto
stroke

grestore")
                                                 (cons 0 3)
                                                 (cons 0 1))

stringPositionClef_two = {
 \override Staff.Clef.stencil = \stringPositionClefDesign_two
}

normalClef = {
 \revert Staff.Clef.stencil
}

{
 \override Staff.StaffSymbol.line-positions = #'(6  -6)
 \override Staff.LedgerLineSpanner.stencil = ##f
 \override Staff.TimeSignature.stencil = ##f
 \override Staff.BarLine.stencil = ##f
 \stringPositionClef_two c'4^\markup {
  \translate #'(-3 . 2)
  \musicglyph "space"
 }
 _\markup {
  \translate #'(-3 . -3)
  \musicglyph "space"
 }
 e' g' b' d'' f'' a''
}
