\version "2.24.4"
\pointAndClickOff
noteheadless = \once \override Voice.NoteHead.stencil = ##f
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


\score {
  {
    \omit Staff.Clef
    \dashedLineNotehead g'4 a' #6
    \modularLineNotehead a' d'' #15 #150 #6
    \override TupletNumber.text = #tuplet-number::calc-fraction-text

    \stemUp  \tuplet 5/4 {
      \modularLineNotehead d''8 b' #150 #50 #2.5
      \modularLineNotehead b' f'' #50 #175 #2.5
      \modularLineNotehead f'' a' #175 #70 #2.5
      \modularLineNotehead a' c'' #70 #120 #2.5
      \modularLineNotehead c'' c' #120 #15 #3.5
    }
    |
    \modularLineNotehead c'4 c' #15 #15 #12
    \noteheadless c'
    \dashedLineNotehead c' c' #5
  }

  \layout {
    \context {
      \Score proportionalNotationDuration = #(ly:make-moment 1/10)
      \override SpacingSpanner.uniform-stretching = ##t
    }
  }
}