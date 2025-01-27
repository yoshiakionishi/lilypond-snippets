\version "2.24.4"
\pointAndClickOff

wiggleBeamOne =
#(define-music-function (vOffset howMany howWide howTilted)
   (number? number? number? number?) #{
     \once \override Voice.Beam.stencil = #ly:text-interface::print
     \once \override Voice.Beam.text = \markup {
       \translate #(cons 0 vOffset)
       \postscript #(string-append
                     "newpath 
              1 setlinejoin 
              1 setlinecap 
              0.35 setlinewidth
              0.13 0 moveto "
                     (number->string howMany)
                     " {" (number->string (* 0.6 howWide))  " "
                     (number->string (+ 0.5 howTilted)) " rlineto "
                     (number->string (* 0.6 howWide))
                     " -0.5 rlineto} repeat
              stroke"
                     )

     }
   #})


wiggleBeamTwo =
#(define-music-function (vOffset howMany howWide howTilted )
   (number? number? number? number?) #{
     \once \override Voice.Beam.stencil = #ly:text-interface::print
     \once \override Voice.Beam.text = \markup {
       \translate #(cons 0 vOffset)
       \postscript #(string-append
                     "newpath 
              1 setlinejoin 
              1 setlinecap 
              0.35 setlinewidth 
              0.13 0 moveto "
                     (number->string howMany)
                     " {" (number->string (* 0.6 howWide)) " "
                     (number->string (+ 0.5 howTilted)) " rlineto "
                     (number->string (* 0.6 howWide))
                     " -0.5 rlineto} repeat
              stroke newpath 
              0.35 setlinewidth 
              1 setlinejoin 
              0.13 -0.75 moveto "
                     (number->string howMany)
                     " {" (number->string (* 0.6 howWide))  " "
                     (number->string (+ 0.5 howTilted)) " rlineto "
                     (number->string (* 0.6 howWide))
                     " -0.5 rlineto} repeat
              stroke"
                     )
     }
   #})


wiggleBeamThree =
#(define-music-function (vOffset howMany howWide howTilted )
   (number? number? number? number?)
   #{
     \once \override Voice.Beam.stencil = #ly:text-interface::print
     \once \override Voice.Beam.text = \markup 	{
       \translate #(cons 0 vOffset)
       \postscript #(string-append
                     "newpath 
              1 setlinejoin 
              1 setlinecap 
              0.35 setlinewidth 
              0.13 0 moveto "
                     (number->string howMany) " {"
                     (number->string (* 0.6 howWide))  " "
                     (number->string (+ 0.5 howTilted)) " rlineto "
                     (number->string (* 0.6 howWide))
                     " -0.5 rlineto} repeat 
              stroke 
              newpath 
              0.35 setlinewidth 
              1 setlinejoin 
              0.13 -0.75 moveto "
                     (number->string howMany) " {"
                     (number->string (* 0.6 howWide))  " "
                     (number->string (+ 0.5 howTilted)) " rlineto "
                     (number->string (* 0.6 howWide))
                     " -0.5 rlineto} repeat 
              stroke 
              newpath 
              0.35 setlinewidth 
              1 setlinejoin 
              0.13 -1.5 moveto "
                     (number->string howMany) " {"
                     (number->string (* 0.6 howWide)) " "
                     (number->string (+ 0.5 howTilted)) " rlineto "
                     (number->string (* 0.6 howWide))
                     " -0.5 rlineto} repeat 
              stroke"
                     )
     }
   #})


wiggleBeam_markup =
#(define-music-function (hOffset vOffset howMany howWide howTilted )
   (number? number? number? number? number?)
   #{
     ^\markup 	{
       \translate #(cons hOffset vOffset)
       \postscript #(string-append
                     "newpath 
              1 setlinejoin 
              1 setlinecap 
              0.35 setlinewidth 
              0.17 0 moveto "
                     (number->string howMany) " {"
                     (number->string (* 0.6 howWide))  " "
                     (number->string (+ 0.5 howTilted)) " rlineto "
                     (number->string (* 0.6 howWide))
                     " -0.5 rlineto} repeat 
              stroke"
                     )

     }
   #})

wiggleBeamStemAdjust =
#(define-music-function (fromMiddleLine howFar)
   (number? number?)
   #{
     \once \override Stem.stencil = #ly:text-interface::print
     \once \override Stem.text = \markup {
       \postscript #(string-append
                     "newpath 
              0.12 setlinewidth 
              0 " (number->string fromMiddleLine) " moveto 
              0 " (number->string howFar) " rlineto 
              stroke"
                     )
     }
   #})


{
  \wiggleBeamTwo #0 #9 #1.01 #0 c'16 c'
  \wiggleBeamStemAdjust #-3 #3.4 c' c'
  \wiggleBeamTwo #0 #5 #1.82 #0 g''
  \wiggleBeamStemAdjust #2.5 #-3 g''
  \wiggleBeamStemAdjust #2.5 #-3 g'' g''
  \wiggleBeamTwo #-1 #9 #1.01 #-0.15 f''
  \wiggleBeamStemAdjust #1.5  #-3.5 e''
  \wiggleBeamStemAdjust #1 #-3.5 d''
  \wiggleBeamStemAdjust #0.5 #-3.5 c''
  \wiggleBeamOne #-3.5 #5 #1.4 #0.15 b'8
  c''16 \wiggleBeam_markup #0 #-4.8 #2 #1.4 #0.15 d''
  \wiggleBeamThree #-1.3 #19 #0.73 #0  g''32
  \wiggleBeamStemAdjust #1.5  #-4 e''
  \wiggleBeamStemAdjust #0.5  #-3 c'' g'' e''
  \wiggleBeamStemAdjust #0.5  #-3  c''
  \wiggleBeamStemAdjust #2.5  #-5 g'' e''
  \bar ".."
}