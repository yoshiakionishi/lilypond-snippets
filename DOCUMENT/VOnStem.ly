\version "2.24.4"


VOnStemOn = {
  \override Stem.no-stem-extend = ##f
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
                                    #:teeny #:sans #:musicglyph "scripts.upbow"))
            -3.5))))
}

VOnStemOff = {
  \revert Stem.length
  \revert Stem.stencil
  \revert Flag.stencil
}


{
  \VOnStemOn c'4 g' \VOnStemOff d'' a''
  \VOnStemOn a'' d'' \VOnStemOff g' c'
}