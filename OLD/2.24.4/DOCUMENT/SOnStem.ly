\version "2.24.4"
\pointAndClickOff

SOnStemOn = {
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
                                    #:teeny #:sans #:bold "S"))
            -3.5))))
}

SOnStemOff = {
  \revert Stem.length
  \revert Stem.details.beamed-lengths
  \revert Stem.stencil
  \revert Flag.stencil
}

{
  \SOnStemOn c'4 g' \SOnStemOff d'' a''
  \SOnStemOn a'' d'' \SOnStemOff g' c'
}