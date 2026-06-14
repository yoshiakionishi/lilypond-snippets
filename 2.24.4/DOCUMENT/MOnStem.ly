\version "2.24.4"
\pointAndClickOff

MOnStemOn = {
  \override Stem.length = #12
  \override Stem.details.beamed-lengths = #'(5.5)
  \override Stem.stencil =
  #(lambda (grob)
     (let* ((x-parent (ly:grob-parent grob X))
            (is-rest? (ly:grob? (ly:grob-object x-parent 'rest))))
       (if is-rest?
           empty-stencil
           (ly:stencil-combine-at-edge
            (ly:stem::print grob)
            Y
            (- (ly:grob-property grob 'direction))
            (grob-interpret-markup grob
                                   (markup
                                    #:center-align
                                    #:teeny #:sans #:bold "M"))
            -3.5))))
}

MOnStemOff = {
  \revert Stem.length
  \revert Stem.details.beamed-lengths
  \revert Stem.stencil
  \revert Flag.stencil
}

{
  \MOnStemOn c'4 g' \MOnStemOff d'' a''
  \MOnStemOn a'' d'' \MOnStemOff g' c'
}