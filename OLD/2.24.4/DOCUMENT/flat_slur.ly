\version "2.24.4"

\language "english"

\pointAndClickOff

flatSlur =
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
    (if (= (ly:grob-property grob 'direction) 1)
        ;this is if the slur/tie direction is up...
        (list 'moveto a b
              'curveto a b a (- d 0.2) c (- d 0.2)
              'lineto e (- f 0.2)
              'curveto e (- f 0.2) g (- f 0.2) g h

              'curveto g h (+ g 0.1) (- f 0.5) e (- f 0.4)
              'lineto c (- d 0.4)
              'curveto c (- d 0.4) (+ a 0.1) (- d 0.3) a b
              'closepath
              )
        ;if the direction is down...
        (list 'moveto a b
              'curveto a b a (+ d 0.2) c (+ d 0.2)
              'lineto e (+ f 0.2)

              'curveto e (+ f 0.2) g (+ f 0.2) g h

              'curveto g h (- g 0.1) (+ f 0.5) e (+ f 0.4)
              'lineto c (+ d 0.4)
              'curveto c (+ d 0.4) (+ a 0.3) (+ d 0.3) a b
              'closepath
              ))

    0.01
    1
    1
    #t
    )
   )
  )
\layout {
 indent = 0
 line-width = 80
}
{
 \time 2/4
 \override Slur.stencil = \flatSlur

 \override Slur.details =
 #'(
    (max-slope . 0)
    (max-slope-factor . 100)
    (free-head-distance . 0.2)
    (free-slur-distance . 0)
    (extra-encompass-free-distance . 0.3)
    (extra-encompass-collision-distance . 0.8)
    (head-slur-distance-max-ratio . 3)
    (head-slur-distance-factor . 10)
    )

 \shape #'(
           (0 . 1)
           (0 . 0.5)
           (0 . 0.5)
           (0 . 0.25)
           ) Slur

 e'16 ( d' c' d' e' d' c'8 )

 \shape #'(
           (0 . 0)
           (0 . -0.5)
           (0 . -0.5)
           (0 . -1)
           ) Slur
 g''16 ( f'' e'' f'' g'' f'' e''8 ) \break



 c''4 ( b' a' g' ~ | \break

 g'8 )

 \shape #'(
           (0 . 0)
           (0 . 0.2)
           (0.75 . 2.5)
           (0 . 3)
           ) Slur


 a ( c' e' g' b' ) r4 |


}