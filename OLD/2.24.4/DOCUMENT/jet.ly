\version "2.24.4"
\pointAndClickOff
jet = #(define-music-function (pitchthing width) (ly:music? number?)
         (define p1 (ly:music-property pitchthing 'pitch))
         (define steps (+ -6 (ly:pitch-steps p1)))
         (define radToDeg (* 180 (/ 1 3.141592653589793)))


         #{ #pitchthing ^\markup {
           \postscript
           #(string-append
             "gsave newpath 
              0.25 setlinewidth 
              1.05 " (number->string
                      (+ -2.65 (* 0.5 steps))) " moveto "
             (number->string (* 0.5 width)) " 4 rlineto "
             (number->string (* 0.5 width)) " -4 rlineto
                stroke
                newpath
                0.1 setlinewidth 
                 "
             (number->string (+ 1.15 width)) " "
             (number->string
              (+ -2.55 (* 0.5 steps))) " moveto "
             (number->string
              (* radToDeg (atan (/ (* width 0.5) 4))))
             " rotate
                -0.125 -0.75 rlineto
                -0.35 1 rlineto
                0.7 0 rlineto
                -0.35 -1 rlineto
                closepath              
                fill
                grestore ")
         } #})


\score {
  {
    \jet e'2^\markup {\fontsize #-5 {[jet]}} #8
    \jet c'4 #3
    \stemDown  \jet b'8 #1.5
    \jet d'8 #1.5
  }

  \layout {
    \context {
      \Score proportionalNotationDuration = #(ly:make-moment 1/10)
      \override SpacingSpanner.uniform-stretching = ##t
    }
  }
}
