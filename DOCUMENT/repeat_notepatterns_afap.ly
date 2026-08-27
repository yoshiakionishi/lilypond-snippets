\version "2.26.0"

\pointAndClickOff

parenthesisBeginWithArrows =
#(define-music-function
  (width height arcAngle offset parenthesis? pitchthing)
  (number? number? number? (pair? (cons 0 0)) (boolean? #t) ly:music?)
  (define p1 (ly:music-property pitchthing 'pitch))
  (define steps (+ -6 (ly:pitch-steps p1)))
  (define radToDeg (* 180 (/ 1 3.141592653589793)))
  #{
   \once \override Parentheses.font-size = #2
   \once \override Parentheses.stencils =
   #(lambda (grob)
     (let ((par-list
            (parentheses-interface::calc-parenthesis-stencils grob)))
      (if parenthesis?
          (list (car par-list) point-stencil)
          (list point-stencil point-stencil)
          )
      )
     )
   \parenthesize
   #pitchthing
   -\tweak ignore-collision ##t
   -\tweak TextScript.outside-staff-priority ##f
   -\tweak TextScript.parent-alignment-X #1
   -\tweak TextScript.extra-offset
   #(cons  (+ -0.5 (car offset)) (+ -1.25 (* steps 0.5) (cdr offset)))
   -\tweak TextScript.rotation #`(,arcAngle -1 -1)
   ^\markup {
    \rotate #3.5
    \concat {
     \path #0.15
     #`((curveto ,(* width 0.25) ,height ,(* width 0.75)
                 ,height ,width 0))
     \hspace #-0.1 \vcenter \postscript
     #(string-append
       "
/arrowhead {
gsave
"  (number->string
       (+ (* radToDeg (atan (/ (* height -1)  (* width 0.25)))) -90))
       " rotate 
0 0.5 rlineto
-0.35 -1 rlineto
0.7 0 rlineto
-0.35 1 rlineto
 closepath
fill 
grestore } def

0 0 moveto
arrowhead
")
    }
  } #})



parenthesisEndWithArrows =
#(define-music-function
  (width height arcAngle offset parenthesis? pitchthing)
  (number? number? number? (pair? (cons 0 0)) (boolean? #t) ly:music?)
  (define p1 (ly:music-property pitchthing 'pitch))
  (define steps (+ -6 (ly:pitch-steps p1)))
  (define radToDeg (* 180 (/ 1 3.141592653589793)))
  #{
   \once  \override Parentheses.font-size = #2
   \once \override Parentheses.stencils =
   #(lambda (grob)
     (let ((par-list
            (parentheses-interface::calc-parenthesis-stencils grob)))
      (if parenthesis?
          (list  point-stencil (cadr par-list))
          (list point-stencil point-stencil)
          )
      )
     )
   \parenthesize
   #pitchthing
   -\tweak ignore-collision ##t
   -\tweak TextScript.outside-staff-priority ##f
   -\tweak TextScript.parent-alignment-X #-1
   -\tweak TextScript.extra-offset
   #(cons  (+ 0.75 (car offset)) (+ 1.75 (* steps 0.5) (cdr offset)))
   -\tweak TextScript.rotation #`(,arcAngle -1 0)
   _\markup \right-align {
    \rotate #3.5
    \concat  {

     \postscript
     #(string-append
       "
/arrowhead {
gsave
"  (number->string
       (+ (* radToDeg (atan (/ (* height -1)  (* width 0.25)))) 270))
       " rotate 
" (if (< height 0) (number->string 0.1) (number->string -0.1)) "
 -0.3 rmoveto
-0.35 1 rlineto
0.7 0 rlineto
-0.35 -1 rlineto
closepath
fill 
grestore } def

0 0 moveto
arrowhead
")
     \center-align
     \path #0.15
     #`((curveto ,(* width 0.25) ,(* height -1) ,(* width 0.75)
                 ,(* height -1) ,width 0))

    }
  } #})


slashBeam = {
 \once \override Stem.stencil =
 #(grob-transformer
   'stencil
   (lambda (grob original)
    (let* ((added-markup
            #{
             #(case (ly:grob-property grob 'direction)
               ( (1) #{ \markup \general-align #X #-0.5
                        {
                         \path #0.1
                         #'((rmoveto 0 0)
                            (rlineto 2 2.75))
                     } #}
                     )
               ( (-1) #{ \markup \general-align #X #-0.5
                         {
                          \path #0.1
                          #'((rmoveto 0 0)
                             (rlineto 2 -2.75))
                      } #}
                      )
               )
            #}
            )
           (added-stencil (grob-interpret-markup grob added-markup)))

     (if (ly:stencil? original)
         (case  (ly:grob-property grob 'direction)
          ((1) (ly:stencil-combine-at-edge
                original 1 1 added-stencil -1.75))
          ((-1) (ly:stencil-combine-at-edge
                 original 1 -1 added-stencil -1.75))
          )
         added-stencil))))
}



{
 \new Staff
 \once \override Staff.TimeSignature.stencil = ##f
 {
  \set Score.proportionalNotationDuration = #1/5

  <<
   {
    \omit Stem
    \omit Beam
    \omit Flag
    \tiny
    \parenthesisBeginWithArrows #7.25 #2 #-10 #'(0 . -1) ##f c''64
    a' b' g' e'
    \parenthesisEndWithArrows #7.75 #3 #-10 #'(0 . 1)##f a'
   }
   \new Voice {
    \stemDown
    \override NoteHead.stencil = #point-stencil
    % \once \override Beam.beam-thickness = #0.2
    \override Beam.length-fraction = #0.225
    s16  s32 [ \slashBeam  \autoBeamOn
    \repeat unfold 4 {   c''  a' b' g' e' a' }
    c''  a' b' g' e' ]
   }
  >>
 }
}