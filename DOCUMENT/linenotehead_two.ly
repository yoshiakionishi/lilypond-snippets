\version "2.24.4"
\pointAndClickOff
% revised on January 25 2025

lineNotehead =
#(define-music-function (thickness note) (number? ly:music? )
  #{
   \once \override NoteHead.stencil = #ly:text-interface::print
   \once \override NoteHead.text = \markup{  \char ##x200A }
   \once \override Dots.stencil = ##f
   \once \override Glissando.breakable = ##t
   \once \override Glissando.after-line-breaking = ##t
   \once \override Glissando.thickness = #thickness
   \once \override Glissando.bound-details =
   #'(
      (left (padding . 0))
      (right (padding . 0))
      )
   #note
   \glissando

  #})

lineNoteheadOn =
#(define-music-function (thickness note) (number? ly:music?)
  #{
   \override Stem.stencil = ##f
   \override Flag.stencil = ##f
   \override TupletBracket.stencil = ##f
   \override TupletNumber.stencil = ##f
   \override Beam.stencil = ##f
   \override NoteHead.stencil = #ly:text-interface::print
   \override NoteHead.text = \markup{  \char ##x200A }
   \override Dots.stencil = ##f
   \override Glissando.breakable = ##t
   \override Glissando.after-line-breaking = ##t
   \override Glissando.thickness = #thickness
   \override Glissando.bound-details =
   #'(
      (left (padding . 0))
      (right (padding . 0))
      )
   #note
   \glissando
   \override NoteColumn.glissando-skip = ##t
  #})


lineNoteheadWithRhythm =
#(define-music-function (thickness note) (number? ly:music?)
  #{
   \once \override NoteHead.stencil = #ly:text-interface::print
   \once \override NoteHead.text = \markup{  \char ##x200A }
   \once \override Glissando.breakable = ##t
   \once \override Glissando.after-line-breaking = ##t
   \once \override Glissando.thickness = #thickness
   \once \override Glissando.bound-details =
   #'(
      (left (padding . 0))
      (right (padding . 0))
      )
   #note
   \glissando

  #})

lineNoteheadWithRhythmOn =
#(define-music-function (thickness note) (number? ly:music?)
  #{
   \override NoteHead.stencil = #ly:text-interface::print
   \override NoteHead.text = \markup{  \char ##x200A }
   \override Glissando.breakable = ##t
   \override Glissando.after-line-breaking = ##t
   \override Glissando.thickness = #thickness
   \override Glissando.bound-details =
   #'(
      (left (padding . 0))
      (right (padding . 0))
      )
   #note
   \glissando
   \override NoteColumn.glissando-skip = ##t
  #})


lineNoteheadOff =
{
 \revert Stem.stencil
 \revert Flag.stencil
 \revert Beam.stencil
 \revert NoteHead.stencil
 \revert Dots.stencil
 \revert Glissando.breakable
 \revert Glissando.after-line-breaking
 \revert Glissando.thickness
 \revert Glissando.bound-details
 \revert NoteColumn.glissando-skip
 \revert TupletBracket.stencil
 \revert TupletNumber.stencil
 \revert Beam.stencil
}


{

 \lineNotehead #1  e'1
 \lineNoteheadOn #3
 e''1
 b'1
 \lineNoteheadOff
 \lineNotehead #5
 e'1
 \lineNotehead #7
 e''1
 \lineNoteheadOn #9 e'4
 e''4.   e'8
 \lineNoteheadOff
 \omit Stem
 e''4

}

\score {
 {
  \time 3/4
  \once \override Voice.Dots.extra-offset = #'(0 . -1)
  \lineNoteheadWithRhythm #5  e'4.
  \stemDown
  \lineNoteheadWithRhythmOn #5

  g'8
  b'4
  \lineNoteheadOff
  \lineNoteheadWithRhythmOn #5
  g''4
  f''4
  e''4
  d''4
  c''4
  \lineNoteheadOff
  \once \override NoteHead.font-size = #-30
  b'4
 }
 \layout {
  \context{
   \Score   proportionalNotationDuration = #(ly:make-moment 1/8)
  }
 }
}
