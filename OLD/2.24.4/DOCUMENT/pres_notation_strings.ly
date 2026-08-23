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
   (let* ((bCS (ly:grob-property grob 'font-size 0.0))
          (mult (magstep bCS)))
     (ly:stencil-scale
      strPosClef
      mult mult)))

strPosClef = {
  \override Staff.Clef.stencil = \strPosClefDesign
}


dashedLineNotehead =
#(define-music-function
  (beginning end x-distance) (ly:music? ly:music? number?)
  (let*
   (
     (p1 (ly:music-property beginning 'pitch))
     (p2 (ly:music-property end 'pitch))
     (steps
      (-
       (+ (* 7 (ly:pitch-octave p2)) (ly:pitch-notename p2))
       (+ (* 7 (ly:pitch-octave p1)) (ly:pitch-notename p1))
       )
      )
     )
   #{
     {

       \once \override Voice.NoteHead.stencil = #ly:text-interface::print
       \once \override Voice.NoteHead.stem-attachment = #'(0 . 0)
       \once \override Staff.LedgerLineSpanner.stencil = ##f
       \once \override Voice.NoteHead.text = \markup 	{
         % \translate #(cons 0 0)
         \postscript
         #(string-append
           "newpath 1 setlinecap 
              0.15 setlinewidth 
              0 0 moveto 
              [.4 .4 .4 .4] 3 setdash "
           (number->string x-distance)  " " (number->string (* steps 0.5))
           " rlineto stroke"
           )
       }
       #beginning
       \revert Voice.NoteHead.stencil
       \revert Staff.LedgerLineSpanner.stencil
     }
   #})
  )

modularLineNotehead =
#(define-music-function
  (beginning end beginningThickness endingThickness x-distance)
  (ly:music? ly:music? number? number? number?)
  (let*
   (
     (p1 (ly:music-property beginning 'pitch))
     (p2 (ly:music-property end 'pitch))
     (steps
      (-
       (+ (* 7 (ly:pitch-octave p2)) (ly:pitch-notename p2))
       (+ (* 7 (ly:pitch-octave p1)) (ly:pitch-notename p1))
       )
      )
     )
   #{
     {

       \once \override Voice.NoteHead.stencil = #ly:text-interface::print
       \once \override Voice.NoteHead.stem-attachment = #'(0 . 0)
       \once \override Voice.LedgerLineSpanner.transparent = ##t
       \once \override Voice.NoteHead.text = \markup 	{
         \postscript
         #(string-append
           "newpath 1 setlinecap 0.1 setlinewidth -0.05 0 moveto 0 "
           (number->string (* beginningThickness 0.005)) " rlineto "
           (number->string x-distance) " "
           (number->string (+ (- (* endingThickness 0.005)
                                 (* beginningThickness 0.005) )
                              (* steps 0.5)))
           " rlineto 0 "
           (number->string  (* endingThickness -0.01))  " rlineto "
           (number->string (* -1 x-distance))  " "
           (number->string (- (* endingThickness 0.005)
                              (* beginningThickness 0.005)
                              (* steps 0.5)))
           " rlineto 
              closepath 
              fill"
           )
       }
       #beginning
       \revert Voice.NoteHead.stencil
       \revert Staff.LedgerLineSpanner.stencil
     }
   #})
  )

noteheadless = \once \override Voice.NoteHead.stencil = ##f

#(define-public ((tuplet-number::append-note-wrapper function note) grob)
   (let ((txt (function grob)))
     (markup txt #:fontsize -5 #:note note UP)))



\score {
  {
    \override Staff.StaffSymbol.line-positions = #'(6  -6)
    \strPosClef \dashedLineNotehead g'4^\markup {\fontsize #-4 \italic flaut.}^\markup \translate #'(-2.5 . -0) \center-column {\translate #'(0 . -1.5) \fontsize #-4 II \fontsize #-4 III} a' #6
    \modularLineNotehead a'^\markup \column {\translate #'(0 . -1.5)\fontsize #-4 \italic apply \fontsize #-4 \italic pressure} d'' #15 #150 #6
    \override TupletNumber.text = #tuplet-number::calc-fraction-text
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