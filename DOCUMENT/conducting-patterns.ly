\version "2.24.4"


condOnePattern =
#'((moveto 0.25 1.75)
   (rlineto 0 -1.75))

condTwoPatternA =
#'((moveto 0.25 1.75)
   (rlineto 0 -1.75)
   (rlineto 2 0)
   (rlineto 0 1.75))

condDoubleTwoPatternA =
#'((moveto 0.25 1.75)
   (rlineto 0 -1.75)
   (rlineto 2 0)
   (rlineto 0 1.75)
   (moveto 0.65 1.75)
   (rlineto 0 -1.35)
   (rlineto 1.2 0)
   (rlineto 0 1.35))

condTwoPatternB =
#'((moveto 0.25 1.75)
   (rlineto 0 -1.75)
   (rlineto 1.25 1.75))

condDoubleTwoPatternB =
#'((moveto 0.25 1.75)
   (rlineto 0 -1.75)
   (rlineto 1.25 1.75)
   (moveto 0.6 1.75)
   (rlineto 0 -0.7)
   (rlineto 0.5 0.7))

condThreePattern =
#'((moveto 1.15 1.75)
   (rlineto -1 -1.75)
   (rlineto 2 0)
   (closepath))

condDoubleThreePattern =
#'((moveto 1.15 1.75)
   (rlineto -1 -1.75)
   (rlineto 2 0)
   (closepath)
   (moveto 1.15 1.05)
   (rlineto -0.385 -0.7)
   (rlineto 0.75 0)
   (closepath))


condOne = ^\markup {
  \override #'(line-join-style . round)
  \path #0.25 #condOnePattern
}

condTwoA = ^\markup {
  \override #'(line-join-style . round)
  \path #0.25 #condTwoPatternA
}
condTwoB = ^\markup {
  \override #'(line-join-style . round)
  \path #0.25 #condTwoPatternB
}
condDoubleTwoA = ^\markup {
  \override #'(line-join-style . round)
  \path #0.25 #condDoubleTwoPatternA
}

condDoubleTwoB = ^\markup {
  \override #'(line-join-style . round)
  \path #0.25 #condDoubleTwoPatternB
}

condThree = ^\markup {
  \override #'(line-join-style . round)
  \path #0.25 #condThreePattern
}

condDoubleThree = ^\markup {
  \override #'(line-join-style . round)
  \path #0.25 #condDoubleThreePattern
}

%% Source inspired by
%% and adapted from: http://lsr.di.unimi.it/LSR/Item?id=629
spacerVoice = \new Voice {
  \override MultiMeasureRest.transparent = ##t
  \override MultiMeasureRest.minimum-length = #14
  R16*5
}


\score {
  {
    \time 5/8
    b'4 \condTwoA b'4. \condThree \bar "||"
    b'4 \condTwoB b'4. \condThree \bar "||"
    b'8 \condOne b'4 \condTwoA b'4 \condTwoA \bar "||"
    \time 5/16
    << {b'8 \condDoubleTwoA b'8. \condDoubleThree} \spacerVoice >> \bar "||"
    << {b'8 \condDoubleTwoB b'8. \condDoubleThree} \spacerVoice >> \bar "||"
  }

}

