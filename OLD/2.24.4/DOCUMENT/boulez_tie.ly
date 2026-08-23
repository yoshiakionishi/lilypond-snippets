\version "2.24.4"

\language "english"

\pointAndClickOff

boulezTie =
#(lambda (grob)

  (let (
        ;defines four control points, each of which containing
        ;x and y, defined from a to h...
        (a (caar (ly:grob-property grob 'control-points)) )
        (b  (cdar (ly:grob-property grob 'control-points)) )
        (c (car (cadr (ly:grob-property grob 'control-points))))
        (d (cdr (cadr (ly:grob-property grob 'control-points))))
        (e (car (caddr (ly:grob-property grob 'control-points))))
        (f (cdr (caddr (ly:grob-property grob 'control-points))))
        (g (car (cadddr (ly:grob-property grob 'control-points))))
        (h (cdr (cadddr (ly:grob-property grob 'control-points))))
        )
   (make-path-stencil

    (list 'moveto a b
          'curveto a b (* (+ a (+ c 0.5)) 0.5) d (+ c 0.5) b
          'lineto (- e 0.5) b
          'curveto (- e 0.5) b (+ (- e 0.5) (* (- g (- e 0.5)) 0.5)) f g h

          'curveto g h (+ (- e 0.5) (* (- g (- e 0.5)) 0.6))
          (+ f 0.1) (- e 0.5) (+ b 0.15)
          'lineto (+ c 0.5) (+ b 0.15)
          'curveto (+ c 0.5) (+ b 0.15) (* (+ a (+ c 0.5)) 0.5) (+ d 0.1) a b
          'closepath
          )

    0.01
    1
    1
    #t
    )
   )
  )

{

 \override Tie.stencil = \boulezTie

 c'1 ~ c'1
 c''' ~ c'''
 <a' d'' g''> ~ <a' d'' g''>
}