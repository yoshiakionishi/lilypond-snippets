\version "2.24.4"
\pointAndClickOff

stringPositionClef_three_longer_Design = #(ly:make-stencil (list 'embedded-ps
                                                                 "gsave
currentpoint translate
/fingboardpath
{
newpath 
0 1 .7 0 setcmykcolor 
0.3 5.75 moveto
0 -6.5 rlineto
-0.2 -0.5 rlineto
0.5 -2.15 rlineto
-0.5 0 rlineto 
0 -2.5 rlineto
2.75 0 rlineto
0 2.5 rlineto
-0.5 0 rlineto
0.45 2.15 rlineto
-0.15 0.5 rlineto
0 6.5 rlineto
closepath
%stroke
.1 .4 .5 .9 setcmykcolor
} def

%fingboardpath 

fingboardpath clip
newpath 
0.15 setlinewidth
0.8 4.5 moveto
0 -7.85 rlineto
-0.2 0 rmoveto
-0.25 1.3 rlineto
2.2 0 rlineto
-0.2 -1.3 rlineto
-0.2 0 rmoveto
0. 7.85 rlineto
stroke
0.35 setlinewidth
0.15 -2 moveto
3.2 0 rlineto
stroke

%inner two line
newpath
0.15 setlinewidth
1.25 4.6 moveto
0. -7.95 rlineto
1.7 4.6 moveto
0. -7.95 rlineto
stroke

0.8 4.5 0.14 0 360 arc
fill
2.1525 4.5 0.14 0 360 arc
fill
1.25 4.7 0.14 0 360 arc
fill
1.7 4.7 0.14 0 360 arc
fill



%bridge
newpath
0.25 0.6 moveto
0.3 0.4 rlineto
1.85 0 rlineto
0.3 -0.4 rlineto
stroke

%tailpiece
0.425 4 moveto 
1 setlinecap
1 setlinejoin
2.15 0 rlineto
-0.35 1.25 rlineto
-0 -0  -0.65 0.75 -1.55 0  rcurveto
closepath
stroke

%%% mute sign; commentify if not needed %%%
newpath
0.2 setlinewidth
1 setlinecap
1.5 -3.25 moveto
0 -2.5 rlineto
0.25 -4.5 moveto
2.5 0 rlineto
stroke
newpath
1.5 -4.5 0.85 0 360 arc
stroke
%%% end of mute sign for commenting/uncommenting %%%

grestore

")
                                                           (cons 0 3)
                                                           (cons 0 1))

stringPositionClefSize =
#(lambda (grob)
  (let* ((bCS (ly:grob-property grob 'font-size 0.0))
         (mult (magstep bCS)))
   (ly:stencil-scale
    stringPositionClef
    mult mult)))

stringPositionClef_three_longer = {
 \override Staff.Clef.stencil = \stringPositionClef_three_longer_Design
}

{
 \override Staff.StaffSymbol.line-positions = #'(6 0  -6)
 \stringPositionClef_three_longer
 c'4^\markup {
  \translate #'(-3 . 2)
  \musicglyph "space"
 }
 _\markup {
  \translate #'(-3 . -3)
  \musicglyph "space"
 }
 e' g' b' d'' f'' a''
}


