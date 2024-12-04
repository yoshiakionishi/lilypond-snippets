\version "2.24.4"


toneClusterBar =
#(define-music-function (note1 note2 yOffset yLengthAdjust)
   (ly:music? ly:music? number? number?)
   (let* (
           (note1p (ly:music-property note1 'pitch))
           (note2p (ly:music-property note2 'pitch))
           (note1pnumber (+ (* 7 (ly:pitch-octave note1p))
                            (ly:pitch-notename note1p)))
           (note2pnumber (+ (* 7 (ly:pitch-octave note2p))
                            (ly:pitch-notename note2p)))
           (pitchDistance (abs (- note1pnumber note2pnumber)))
           )
     #{
       < #note1
       #note2 > ^\markup {
         \postscript
         #(string-append
           "gsave
            newpath
            0.3 " (number->string (- yOffset 0.5)) " moveto
            0.7 0 rlineto
            0 " (number->string (- (* -0.5 pitchDistance)
                                   (- yLengthAdjust 1))) " rlineto
            -0.7 0 rlineto
            closepath
            fill
            grestore")
       }
     #}
     )
   )


toneClusterBarHollow =
#(define-music-function (note1 note2 yOffset yLengthAdjust)
   (ly:music? ly:music? number? number?)
   (let* (
           (note1p (ly:music-property note1 'pitch))
           (note2p (ly:music-property note2 'pitch))
           (note1pnumber (+ (* 7 (ly:pitch-octave note1p))
                            (ly:pitch-notename note1p)))
           (note2pnumber (+ (* 7 (ly:pitch-octave note2p))
                            (ly:pitch-notename note2p)))
           (pitchDistance (abs (- note1pnumber note2pnumber)))
           )
     #{
       < #note1
       #note2 > ^\markup {
         \postscript
         #(string-append
           "gsave
            newpath
            0.1 " (number->string (- yOffset 0.5)) " moveto
            0 " (number->string (- (* -0.5 pitchDistance)
                                   (+ 0.5 yLengthAdjust))) " rlineto
            0.125 setlinewidth
            1.3 "(number->string (+ 0.75 (- yOffset 0.5))) " moveto
            0 " (number->string (- (* -0.5 pitchDistance)
           (+ 0.75 yLengthAdjust))) " rlineto
            stroke
            grestore")
       }
     #}
     )
   )


toneClusterBarWhole =
#(define-music-function (note1 note2 yOffset yLengthAdjust)
   (ly:music? ly:music? number? number?)
   (let* (
           (note1p (ly:music-property note1 'pitch))
           (note2p (ly:music-property note2 'pitch))
           (note1pnumber (+ (* 7 (ly:pitch-octave note1p))
                            (ly:pitch-notename note1p)))
           (note2pnumber (+ (* 7 (ly:pitch-octave note2p))
                            (ly:pitch-notename note2p)))
           (pitchDistance (abs (- note1pnumber note2pnumber)))
           )
     #{
       < #note1
       #note2 > ^\markup {
         \postscript
         #(string-append
           "gsave
            newpath
            0.125 setlinewidth
            0.55 " (number->string (- yOffset 0.5)) " moveto
            0 " (number->string (- (* -0.5 pitchDistance)
                                   (- yLengthAdjust 1))) " rlineto
            0.75 0 rlineto
            0 " (number->string (abs (- (* -0.5 pitchDistance)
                (- yLengthAdjust 1)))) " rlineto
            closepath fill
            grestore")
       }
     #}
     )
   )


{
  \time 4/4
  \partial 2
  \clef "F"
  \stemUp \toneClusterBar c'4~ e,~ #1 #1
  \stemDown \toneClusterBar e,~ c'4~ #0.5 #0
  \stemUp \toneClusterBarHollow c'2~ e,~ #0.5 #-0.5
  \stemDown \toneClusterBarHollow c'2~ e,~ #0.5 #-0.5
  \toneClusterBarWhole c'1~ e,~ #0.5 #0
  \toneClusterBar c'1~\harmonic e,~\harmonic #0.5 #0
}

