\version "2.24.4"
\pointAndClickOff



#(append! default-script-alist
          (list
           `(accentTenutoUp
             . (
                (stencil . ,ly:text-interface::print)
                (text . ,#{ \markup


                            \center-align
                            \combine \musicglyph "scripts.sforzato"
                            \translate #'(0 . -0.75) \musicglyph "scripts.tenuto" #})
                ; any other properties
                (toward-stem-shift-in-column . 1.0)
                (outside-staff-priority . #t)
                (padding . 0.5)
                (avoid-slur . around)
                (direction . ,UP))))

          (list
           `(accentTenutoDown
             . (
                (stencil . ,ly:text-interface::print)
                (text . ,#{ \markup \center-align
                            \combine \musicglyph "scripts.tenuto"
                            \translate #'(0 . -0.75) \musicglyph "scripts.sforzato" #})
                ; any other properties
                (toward-stem-shift-in-column . 1.0)
                (outside-staff-priority . #t)
                (padding . 0.5)
                (avoid-slur . around)
                (direction . ,DOWN)))))

accentTenuto =  #(make-articulation 'accentTenutoUp)
accentTenutoUp = #(make-articulation 'accentTenutoUp)
accentTenutoDown = #(make-articulation 'accentTenutoDown)


{
 \override Staff.TimeSignature.stencil = ##f
 \time 5/4

 c'4\accentTenuto c'4 \accentTenutoDown c''\accentTenutoUp
 \stopStaff
 \override Staff.StaffSymbol.line-positions = #'(4 -4)
 \startStaff

 \stemUp g'' \tweak Y-offset #1.5 \accentTenutoDown
 \stemDown d' \tweak Y-offset #-0.5 \accentTenutoUp
}