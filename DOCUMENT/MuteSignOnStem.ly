\version "2.24.4"
\pointAndClickOff

muteSignOnStemOn = {

 %  \override Stem.length =
 % #(lambda (grob)
 %           (if (= UP (ly:grob-property grob 'direction ))
 %
 %  7.5
 %  7.5))


 %  \override Stem.details.beamed-lengths = #'(5.5)


 \override Stem.stencil =
 #(lambda (grob)
   (let* ((x-parent (ly:grob-parent grob X))
          (is-rest? (ly:grob? (ly:grob-object x-parent 'rest))))
    (if is-rest?
        empty-stencil

        (if (= UP (ly:grob-property grob 'direction))

            (ly:stencil-combine-at-edge
             (ly:stem::print grob)
             Y
             (+ (ly:grob-property grob 'direction))
             (grob-interpret-markup
              grob
              (markup

               #:postscript
               "newpath
            0.2 setlinewidth
            1 setlinecap
            0 0 moveto
            0 2.5 rlineto
            -1.25 1.25 moveto
            2.5 0 rlineto
            stroke
            newpath
            0 1.25 0.85 0 360 arc
            stroke"
               ))
             0.5)

            (ly:stencil-combine-at-edge
             (ly:stem::print grob)
             Y
             (+ (ly:grob-property grob 'direction))
             (grob-interpret-markup
              grob
              (markup
               #:rotate 180
               #:postscript
               "newpath
            0.2 setlinewidth
            1 setlinecap
            0 0 moveto
            0 2.5 rlineto
            -1.25 1.25 moveto
            2.5 0 rlineto
            stroke
            newpath
            0 1.25 0.85 0 360 arc
            stroke"
               ))
             0.5)
            ))))
}

muteSignOnStemOff = {
 \revert Stem.length
 \revert Stem.details.beamed-lengths
 \revert Stem.stencil
 \revert Flag.stencil
}

{
 \muteSignOnStemOn c'1^\markup {\translate #'(0 . 3) \musicglyph "space"}

 g'4 \muteSignOnStemOff d'' a''
 \muteSignOnStemOn a''8 \noBeam d'' _\markup {\translate #'(0 . -3) \musicglyph "space" } g' c'  d' e' f' g'
}