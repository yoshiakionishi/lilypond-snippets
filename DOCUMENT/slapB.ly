\version "2.24.4"


slapB = #(define-music-function (note)   (ly:music?)
           #{ \once \override Voice.NoteHead.stencil =
              #ly:text-interface::print
              \once \override Voice.NoteHead.text =
              \markup {
                \concat {
                  \musicglyph "noteheads.s1"
                  \postscript "newpath -0.675 0.025 0.75 0 360 arc closepath stroke"
                }
              }
              $note #})

{
  \slapB c'4 \slapB d' \slapB e' \slapB f'
  \slapB f'' \slapB e'' \slapB d'' \slapB c''
}
