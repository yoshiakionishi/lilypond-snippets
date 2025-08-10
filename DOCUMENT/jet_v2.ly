\version "2.24.4"
\pointAndClickOff
jet =  #(define-music-function (pitchthing height width) (ly:music? number? number?)
         (define p1 (ly:music-property pitchthing 'pitch))
         (define steps (+ -6 (ly:pitch-steps p1)))
         (define radToDeg (* 180 (/ 1 3.141592653589793)))


         #{ #pitchthing ^\markup {
          \postscript #(string-append
                        "gsave 
newpath 
0.2 setlinewidth 
1.15 " (number->string (+ -2.5 (* 0.5 steps))) " moveto "

                        (number->string (* 0.5 width)) " "
                        (number->string height) " rlineto "
                        (number->string (* 0.5 width)) " "
                        (number->string (* height -1))
                        " rlineto
stroke
newpath
0.1 setlinewidth 
 "
                        (number->string (+ 1.15 width))
                        " " (number->string (+ -2.55 (* 0.5 steps)))
                        " moveto "
                        (number->string
                         (* radToDeg (atan (/ (* width 0.5) height))))
                        " rotate
0 -1 rlineto
-0.35 1 rlineto
0.7 0 rlineto
-0.35 -1 rlineto
closepath
fill
grestore
")
         } #})


\score {
 {
  \jet e'2^\markup {\fontsize #-5 {[jet]}} #5 #8
  \jet c'4 #1 #2
  \stemDown
  \jet b'8  #4 #1.5
  \jet d'8  #6 #1.5
 }

 \layout {
  \context {
   \Score proportionalNotationDuration = #(ly:make-moment 1/10)
   \override SpacingSpanner.uniform-stretching = ##t
  }
 }
}
