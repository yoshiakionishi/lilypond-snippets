\version "2.26.0"

\pointAndClickOff

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
                                 #:teeny #:sans
                                 #:musicglyph "scripts.uupbow"))
         -3.5))))
}

VOnStemUpsideDownOn = {
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
                                 #:teeny #:sans
                                 #:rotate 180
                                 #:musicglyph "scripts.uupbow"))
         -3.5))))
}

VOnStemOff = {
 \revert Stem.length
 \revert Stem.stencil
 \revert Flag.stencil
}


{
 \VOnStemOn c'4 g' \VOnStemOff
 \VOnStemUpsideDownOn d'' a'' \VOnStemOff
 \VOnStemOn a'' d'' \VOnStemOff
 \VOnStemUpsideDownOn g' c' \VOnStemOff
}