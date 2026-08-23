\version "2.26.0"
\pointAndClickOff
pianoStrings = #(ly:make-stencil (list
                                  'embedded-ps
                                  "gsave

/groove {
0.1 setlinewidth
0 0 0.5 -0.125 0 -0.25 rcurveto
closepath
fill
} def

/reversegroove {
0.1 setlinewidth
0 0 -0.5 -0.125 0 -0.25 rcurveto
closepath
fill

} def

/stringshape {
currentpoint translate
newpath
0.15 setlinewidth
0.5 5 moveto
0 -10.5 rlineto
stroke


5 -0.25 -5.25 { /i exch def
newpath
0.5 i moveto 
groove } for

5 -0.25 -5.25 { /i exch def
newpath
0.5 i moveto
reversegroove
 } for

newpath
0 3 translate
0 -5 moveto
0	-2.5 rlineto
1 0 rlineto
0 2.5 rlineto
closepath 
fill
} def

stringshape
0 0 moveto
1.25 -3 rmoveto
stringshape



grestore
")
                                 (cons 2 0)
                                 (cons 7.5 -7.5))

clefSpace = #(ly:make-stencil "" (cons -0 0 ) (cons 0 3) )

pianoStringMutingChartClefDesign =
#(ly:stencil-add
  (ly:stencil-translate pianoStrings (cons 0 0))
  (ly:stencil-translate clefSpace (cons 2 5))
  (ly:stencil-translate clefSpace (cons 0 -5)
                        ;adjust the second numbers for two
                        ;'clefSpaces' to
                        ;vertically adjust the alignment
                        )
  )




pianoStringMutingChartClefStaff = {
 \override Staff.Clef.stencil = \pianoStringMutingChartClefDesign
 \override Staff.StaffSymbol.line-positions = #'(6 0  -6)
 % \override Staff.Clef.show-horizontal-skylines = ##t
 % \override Staff.Clef.show-vertical-skylines = ##t
 \override Staff.NoteHead.no-ledgers = ##t
}

pianoStaffRevert = {
 \revert Staff.Clef.stencil
 \revert Staff.StaffSymbol.line-positions
 % \override Staff.Clef.show-horizontal-skylines = ##t
 % \override Staff.Clef.show-vertical-skylines = ##t
 \revert Staff.NoteHead.no-ledgers
}



\new Staff {

 \stopStaff
 \pianoStringMutingChartClefStaff
 \startStaff
 s1

}



\new PianoStaff <<
 \new Staff {
  \stopStaff
  \pianoStringMutingChartClefStaff
  \startStaff
  s1
 }
 \new Staff {
  \clef "F" s1
 }
>>
