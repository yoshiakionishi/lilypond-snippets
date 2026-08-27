\version "2.26.0"

\pointAndClickOff

slashBeam = {
 \once \override Stem.stencil =
 #(grob-transformer
   'stencil
   (lambda (grob original)
    (let* ((added-markup
            #{
             #(case (ly:grob-property grob 'direction)
               ( (1) #{ \markup \general-align #X #-0.5
                        {
                         \path #0.1
                         #'((rmoveto 0 0)
                            (rlineto 2 2.75))
                     } #}
                     )
               ( (-1) #{ \markup \general-align #X #-0.5
                         {
                          \path #0.1
                          #'((rmoveto 0 0)
                             (rlineto 2 -2.75))
                      } #}
                      )
               )
            #}
            )
           (added-stencil (grob-interpret-markup grob added-markup)))

     (if (ly:stencil? original)
         (case  (ly:grob-property grob 'direction)
          ((1) (ly:stencil-combine-at-edge
                original 1 1 added-stencil -1.75))
          ((-1) (ly:stencil-combine-at-edge
                 original 1 -1 added-stencil -1.75))
          )
         added-stencil))))
}

{
 \slashBeam c'8 e' g' e'
 \slashBeam c''' g'' e'' g''
}

