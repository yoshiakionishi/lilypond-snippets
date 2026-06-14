\version "2.24.4"
\pointAndClickOff



#(append! default-script-alist
          (list
           `(accentStaccatoUp
             . (
                (stencil . ,ly:text-interface::print)
                (text . ,#{ \markup


                            \center-align
                            \combine \musicglyph "scripts.sforzato"
                            \translate #'(0 . -0.75) \musicglyph "scripts.staccato" #})
                ; any other properties
                (toward-stem-shift-in-column . 1.0)
                (outside-staff-priority . #t)
                (padding . 0.5)
                (avoid-slur . around)
                (direction . ,UP))))

          (list
           `(accentStaccatoDown
             . (
                (stencil . ,ly:text-interface::print)
                (text . ,#{ \markup \center-align
                            \combine \musicglyph "scripts.staccato"
                            \translate #'(0 . -0.75) \musicglyph "scripts.sforzato" #})
                ; any other properties
                (toward-stem-shift-in-column . 1.0)
                (outside-staff-priority . #t)
                (padding . 0.5)
                (avoid-slur . around)
                (direction . ,DOWN)))))

accentStaccato =  #(make-articulation 'accentStaccatoUp)
accentStaccatoUp = #(make-articulation 'accentStaccatoUp)
accentStaccatoDown = #(make-articulation 'accentStaccatoDown)


{
 \override Staff.TimeSignature.stencil = ##f
 \time 5/4

 c'4\accentStaccato c'4 \accentStaccatoDown c''\accentStaccatoUp
 \stopStaff
 \override Staff.StaffSymbol.line-positions = #'(4 -4)
 \startStaff

 \stemUp g'' \tweak Y-offset #1.5 \accentStaccatoDown
 \stemDown d' \tweak Y-offset #-0.5 \accentStaccatoUp
}