\version "2.24.4"

% Stem attachment function inspired by:
% https://lsr.di.unimi.it/LSR/Snippet?id=518


cirX = #(define-music-function (note) (ly:music?)
          #{
            \temporary \override NoteHead.stencil =
            #ly:text-interface::print
            \temporary \override NoteHead.text =
            \markup
            \translate #'(0.6 . 0)
            \pad-x #-0.22
            \rotate #35
            \scale #'(1 . 0.65)
            \combine \combine \combine \combine
            \override #'(thickness . 2)
            \draw-line #'(0.05 . 0.6)
            \override #'(thickness . 2)
            \draw-line #'(-0.05 . -0.6)
            \override #'(thickness . 2)
            \draw-line #'(0.6 . 0.1 )
            \override #'(thickness . 2)
            \draw-line #'(-0.6 . -0.1 )
            \draw-circle #0.65 #0.175 ##f

            \temporary \override NoteHead.stem-attachment =
            #(lambda (grob)
               (let* ((stem (ly:grob-object grob 'stem))
                      (dir (ly:grob-property stem 'direction UP))
                      (is-up (eqv? dir UP)))
                 (cons dir (if is-up -0 -0.2))))
            #note
            \revert NoteHead.stencil
            \revert NoteHead.text
            \revert NoteHead.stem-attachment
          #})


{
  \cirX c'4 \cirX d' \cirX e' \cirX f'
  \cirX a''4 \cirX g'' \cirX f'' \cirX  e''
}