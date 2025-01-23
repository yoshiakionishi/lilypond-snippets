\version "2.24.4"

dashedArrowLineOn =
#(define-music-function (note)(ly:music?)
  (define paddingvalue (if (music-is-of-type? note 'event-chord)
                           (ly:duration-log
                            (ly:music-property
                             (first
                              (ly:music-property note 'elements))
                             'duration))
                           (ly:duration-log
                            (ly:music-property note 'duration))))

  #{

   \override Glissando.breakable = ##t
   \override Glissando.after-line-breaking = ##t
   \override Glissando.thickness = #2.35
   \override Glissando.style = #'dashed-line
   \override Glissando.bound-details.right.arrow = ##t
   \override Glissando.bound-details.right-broken.arrow = ##f
   \override Glissando.bound-details.right-broken.padding = #-1
   \override Glissando.bound-details.left.padding =
   #(cond ((= paddingvalue 0) 0.85)
          ((= paddingvalue 1) 0.65)
          ((>= paddingvalue 2) 0.65))

   \override Glissando.bound-details.right.padding = #0.25
   #note
   \glissando  \override NoteColumn.glissando-skip = ##t
  #})


dashedArrowLineOff =
{
 \revert Glissando.breakable
 \revert Glissando.after-line-breaking
 \revert Glissando.thickness
 \revert Glissando.style
 \revert Glissando.bound-details.right.arrow
 \revert Glissando.bound-details.right-broken.arrow
 \revert Glissando.bound-details.right-broken.padding
 \revert Glissando.bound-details.left.padding
 \revert Glissando.bound-details.right.padding
 \revert NoteColumn.glissando-skip
}



\score {

 {
  \override Score.TimeSignature.stencil = ##f

  \dashedArrowLineOn
  c'1
  \dashedArrowLineOff

  \dashedArrowLineOn
  g'2
  \dashedArrowLineOff

  \dashedArrowLineOn
  c'4
  \dashedArrowLineOff

  \dashedArrowLineOn
  g'8 \noBeam
  \dashedArrowLineOff
  \dashedArrowLineOn
  c'16 s16 |

  \break
  \dashedArrowLineOff
  \dashedArrowLineOn
  c''8
  \override Voice.NoteHead.transparent = ##t
  8 8 8 8
  \revert Voice.NoteHead.transparent
  \dashedArrowLineOff

  \dashedArrowLineOn
  8 \harmonic
  \override Voice.NoteHead.transparent = ##t
  \once \override Voice.Dots.extra-offset = #'(-1 . -0.75)

  8.
  \revert Voice.NoteHead.transparent
  \dashedArrowLineOff

  \dashedArrowLineOn
  16

  \override Voice.NoteHead.transparent = ##t
  8 8 8 8
  \revert Voice.NoteHead.transparent
  \dashedArrowLineOff
  \easyHeadsOn
  \dashedArrowLineOn
  8
  \dashedArrowLineOff
  \easyHeadsOff
  4.
  \break
  \dashedArrowLineOn
  <c' a''>1

  \dashedArrowLineOff
  <aes'' c'>1

  <<
   { \dashedArrowLineOn a''1 \dashedArrowLineOff c'1} \\
   {\dashedArrowLineOn c'1 \dashedArrowLineOff aes''1}
  >>
  \break
  \override Voice.Stem.stencil = ##f
  \override Voice.NoteHead.stencil = #ly:text-interface::print
  \override Voice.NoteHead.text =\markup{\musicglyph "noteheads.s1"}
  \set glissandoMap = #'((1 . 1) (1 . 1))
  \dashedArrowLineOn
  <c' e' g' bes' d'' fis'' a''>2
  s4
  \dashedArrowLineOff
  <c'
  \single \override NoteHead.text =
  \markup{\musicglyph "noteheads.s2"}  es'
  g' bes' d'' fis'' a''>4

 }

 \layout {

  indent = #0
  line-width = #125

  ragged-last = ##f

  \context {
   \Score
   proportionalNotationDuration = #(ly:make-moment 1/7)
  }
 }
}

