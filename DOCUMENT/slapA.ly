\version "2.24.4"
\pointAndClickOff

slapA = #(define-music-function (note)   (ly:music?)
           #{ \once \override Voice.NoteHead.stencil =
              #ly:text-interface::print
              \once \override Voice.NoteHead.text =
              \markup {
                \concat {
                  \musicglyph "noteheads.s2"
                  \postscript "newpath -0.675 0.025 0.75 0 360 arc closepath stroke"
                }
              }
              $note #})


{
  \slapA c'4 \slapA d' \slapA e' \slapA f'
  \slapA f'' \slapA e'' \slapA d'' \slapA c''
}
