\version "2.24.4"
\pointAndClickOff

schleiferMarkup = \markup {
  \large \halign #.2 \raise #0.0
  \combine
  \halign #.8 \musicglyph "scripts.prall"
  \rotate #140 \normalsize \raise #2.4 \musicglyph "flags.u3"
}

schleiferGrace =
#(define-music-function (note schleiferColor rotate) (ly:music? color? list?)
   #{
     \grace {
       \once\override NoteHead.stencil = #ly:text-interface::print
       \once\override NoteHead.X-extent = #'(0 . -1)
       \once\override NoteHead.color = #schleiferColor
       \once\override NoteHead.rotation = #rotate
       \once\override NoteHead.text = \schleiferMarkup
       \once\omit Stem
       \once\omit Flag
       $note
     }
   #})
\relative {
  \time 3/8
  \partial 8
  \clef bass
  \key c \minor
  g8
  \schleiferGrace c #red #'(90 -1 -1) es8. d16 c8
  c4
}
\addlyrics {
  Ich ha -- be ge -- nug
}