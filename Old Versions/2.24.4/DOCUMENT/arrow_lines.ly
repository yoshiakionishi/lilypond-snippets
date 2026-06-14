\version "2.24.4"
\pointAndClickOff
arrowLineOn =
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


arrowLineOff =
{
 \revert Glissando.breakable
 \revert Glissando.after-line-breaking
 \revert Glissando.thickness
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

  \arrowLineOn
  c'1
  \arrowLineOff

  \arrowLineOn
  g'2
  \arrowLineOff

  \arrowLineOn
  c'4
  \arrowLineOff

  \arrowLineOn
  g'8 \noBeam
  \arrowLineOff
  \arrowLineOn
  c'16 s16 |

  \break
  \arrowLineOff
  \arrowLineOn
  c''8
  \override Voice.NoteHead.transparent = ##t
  8 8 8 8
  \revert Voice.NoteHead.transparent
  \arrowLineOff

  \arrowLineOn
  8 \harmonic
  \override Voice.NoteHead.transparent = ##t
  \once \override Voice.Dots.extra-offset = #'(-1 . -0.75)

  8.
  \revert Voice.NoteHead.transparent
  \arrowLineOff

  \arrowLineOn
  16

  \override Voice.NoteHead.transparent = ##t
  8 8 8 8
  \revert Voice.NoteHead.transparent
  \arrowLineOff
  \easyHeadsOn
  \arrowLineOn
  8
  \arrowLineOff
  \easyHeadsOff
  4.
  \break
  \arrowLineOn
  <c' a''>1

  \arrowLineOff
  <aes'' c'>1

  <<
   { \arrowLineOn a''1 \arrowLineOff c'1} \\
   {\arrowLineOn c'1 \arrowLineOff aes''1}
  >>

  \break
  \override Voice.Stem.stencil = ##f
  \override Voice.NoteHead.stencil = #ly:text-interface::print
  \override Voice.NoteHead.text =\markup{\musicglyph "noteheads.s1"}
  \set glissandoMap = #'((1 . 1) (1 . 1))
  \arrowLineOn
  <c' e' g' bes' d'' fis'' a''>2
  s4
  \arrowLineOff
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

