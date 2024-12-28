\version "2.24.4"


jeteDesign =
\markup
\center-align
\combine \combine \combine
\override #'(filled . #t)
\path  #0.1
#'((moveto    -0.25 0.5)
   (curveto   0.35 1.1 0.85 1.1 1.45 0.5)
   (curveto   0.85 0.8 0.35 0.8 -0.25 0.5)
   (closepath))
\draw-circle #0.2 #0 ##t
\translate #'(0.6 . 0) \draw-circle #0.2 #0 ##t
\translate #'(1.2 . 0)\draw-circle #0.2 #0 ##t
#(append! default-script-alist
          (list
           `(jetelistUp
             . (
                 (stencil . ,ly:text-interface::print)
                 (text . ,#{ \markup \jeteDesign #})
                 ; any other properties
                 (toward-stem-shift-in-column . 1.0)
                 (outside-staff-priority . #t)
                 (padding . 0.5)
                 (avoid-slur . around)
                 (direction . ,UP))))

          (list
           `(jetelistDown
             . (
                 (stencil . ,ly:text-interface::print)
                 (text . ,#{ \markup \rotate #180 \jeteDesign #})
                 ; any other properties
                 (toward-stem-shift-in-column . 1.0)
                 (outside-staff-priority . #t)
                 (padding . 0.5)
                 (avoid-slur . around)
                 (direction . ,DOWN)))))

jete =  #(make-articulation 'jetelistUp)
jeteUp = #(make-articulation 'jetelistUp)
jeteDown = #(make-articulation 'jetelistDown)


{c'4\jete c'4 \jeteDown c''\jeteUp }