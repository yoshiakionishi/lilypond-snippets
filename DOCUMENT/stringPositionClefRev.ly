\version "2.24.4"

\pointAndClickOff

% revision june 24 2025

stringPositionClefDesignRev = #(ly:make-stencil (list 'embedded-ps
                                                      "gsave
currentpoint translate
/fingboardpath
{

newpath 
%0 1 .7 0 setcmykcolor 
-0.5 7.5 moveto
0 -3 rlineto
1 -6.5 rlineto
-1 -1 rlineto
0 -3 rlineto
4.05 0 rlineto
0 3 rlineto
-1 1 rlineto
1 6.5 rlineto
0 3 rlineto
closepath

} def

% fingboardpath
 fingboardpath clip

newpath 
0.15 setlinewidth
0.75 5.25 moveto
0 -7.3 rlineto
-0.2 0 rmoveto
-0.75 5 rlineto
3.45 0 rlineto
-0.75 -5 rlineto
-0.2 0 rmoveto
0. 7.3 rlineto
stroke
0.35 setlinewidth
-0.4 2.75 moveto
3.75 0 rlineto
stroke

%inner two lines
newpath
0.15 setlinewidth
1.25 5.5 moveto
0. -7.5 rlineto
1.8 5.5 moveto
0. -7.5 rlineto
stroke


%finetuner pins
0.75 5.4 0.14 0 360 arc
fill
1.25 5.65 0.14 0 360 arc
fill
1.8 5.65 0.14 0 360 arc
fill
2.3 5.4 0.14 0 360 arc
fill



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

%mute sign, delete if not needed
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

stringPositionClefDesignRev = {
 \override Staff.Clef.stencil = \stringPositionClefDesignRev
}

normalClef = {
 \revert Staff.Clef.stencil
}

{
 \override Staff.StaffSymbol.line-positions = #'(6  -6)
 \override Staff.LedgerLineSpanner.stencil = ##f
 \override Staff.TimeSignature.stencil = ##f
 \override Staff.BarLine.stencil = ##f
 \stringPositionClefDesignRev c'4^\markup {
  \translate #'(-3 . 2)
  \musicglyph "space"
 }
 _\markup {
  \translate #'(-3 . -3)
  \musicglyph "space"
 }
 e' g' b' d'' f'' a''
}
