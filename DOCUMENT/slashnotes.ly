\version "2.24.4"

% Inspired by the code provided by Jean Abou Samra
% https://lists.gnu.org/archive/html/lilypond-user/2022-11/msg00333.html

slashNote =
\once \override Voice.NoteHead.stencil =
#(grob-transformer
  'stencil
  (lambda (grob original)
    (let* ((added-markup
            #{
              \markup \general-align #Y #CENTER
              #(case (ly:grob-property grob 'duration-log)
                 ((0) #{ \markup \concat {
                   \musicglyph "noteheads.s0"
                   \postscript
                   "gsave 
                    0.17 setlinewidth 
                    -2.3 0.6 moveto 
                    0.3 -0.6 lineto
                    stroke 
                    grestore"
                      } #})

                 ((1) #{ \markup \concat {
                   \musicglyph "noteheads.s1"
                   \postscript
                   "gsave 
                    0.17 setlinewidth 
                    -1.5 0.6 moveto 
                    0.3 -0.6 lineto
                    stroke 
                    grestore"
                      } #})

                 ((2) #{ \markup \concat {
                   \musicglyph "noteheads.s2"
                   \postscript
                   "gsave 
                    0.17 setlinewidth 
                    -1.5 0.6 moveto 
                    0.3 -0.6 lineto
                    stroke 
                    grestore"
                      } #}))
            #})
           (added-stencil (grob-interpret-markup grob added-markup)))
      (if (ly:stencil? original)
          (ly:stencil-add original added-stencil)
          added-stencil))))



slashNoteOn =
\override Voice.NoteHead.stencil =
#(grob-transformer
  'stencil
  (lambda (grob original)
    (let* ((added-markup
            #{
              \markup \general-align #Y #CENTER
              #(case (ly:grob-property grob 'duration-log)
                 ((0) #{ \markup \concat {
                   \musicglyph "noteheads.s0"
                   \postscript
                   "gsave 
                    0.17 setlinewidth 
                    -2.3 0.6 moveto 
                    0.3 -0.6 lineto
                    stroke 
                    grestore"
                      } #})
                 ((1) #{ \markup \concat {
                   \musicglyph "noteheads.s1"
                   \postscript
                   "gsave 
                    0.17 setlinewidth 
                    -1.5 0.6 moveto 
                    0.3 -0.6 lineto
                    stroke 
                    grestore"
                      } #})
                 ((2) #{ \markup \concat {
                   \musicglyph "noteheads.s2"
                   \postscript
                   "gsave 
                    0.17 setlinewidth 
                    -1.5 0.6 moveto 
                    0.3 -0.6 lineto
                    stroke 
                    grestore"
                      } #}))
            #})
           (added-stencil (grob-interpret-markup grob added-markup)))
      (if (ly:stencil? original)
          (ly:stencil-add original added-stencil)
          added-stencil))))


slashNoteOff = \revert Voice.NoteHead.stencil


{
  \time 7/4
  \slashNote c'4
  \slashNote d'2
  \slashNote e'1
  \slashNoteOn g''4 f''2 d''1
  \slashNoteOff c''1 \bar "||"
}