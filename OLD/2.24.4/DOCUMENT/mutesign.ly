\version "2.24.4"
\pointAndClickOff
mutesign = \markup {
  \translate #'(0.5 . 0)
  \postscript

  "newpath
0.2 setlinewidth
1 setlinecap
0 0 moveto
0 2.5 rlineto
-1.25 1.25 moveto
2.5 0 rlineto
stroke
newpath
0 1.25 0.85 0 360 arc
stroke"

}

{
  c'2. r4^\mutesign^\markup {
    \translate #'(-3 . 2)
    \musicglyph "space"
  }

}
