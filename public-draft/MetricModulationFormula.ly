%%%Draft version of the metric modulation formula, version aug 9 2025%%%

\version "2.25.4"

MModEquation =
#(define-music-function (notevalue1 ratio1 notevalue2 ratio2 verticaloffset horizontaloffset) 
(ly:duration? list? ly:duration? list? number? number?)
  (let* (
         (noteone notevalue1)
         (notetwo notevalue2)
         (ratioone ratio1)
         (ratiotwo ratio2)
         )
   #{
    \tweak self-alignment-X #RIGHT
    \tweak X-offset #horizontaloffset
    \tweak Y-offset #verticaloffset
    \textEndMark \markup {
     \hspace #-4.8
     \fontsize #-4.5
     \concat {
      {
       \combine
       \musicglyph "arrowheads.open.0M1"
       \draw-line #'(2 . 0)  \musicglyph "space"
      }
      {
       \note { $noteone   } #(if (=  (ly:duration-log noteone) 4) 1.35 1.2 )

       \hspace #(if (> (ly:duration-log notetwo) 2) -4.5 -5)
       \raise #(if (< (ly:duration-log noteone) 8) 2 (ly:duration-log noteone))
       \fontsize #1
       \rhythm {
        \override TupletBracket.bracket-visibility = ##t
        \override TupletNumber.text = #tuplet-number::calc-fraction-text
        \override TupletBracket.shorten-pair = #(cons -3 -3)
        \override TupletBracket.edge-height = #'(0 . 0.7)
        \override TupletBracket.X-offset = #0
        \override NoteHead.stencil = ##f
        \override Stem.stencil = ##f
        #(if (= (length ratioone) 2) #{
         \tuplet #(cadr ratioone) { \tuplet #(car ratioone) { 4 } }
             #} )
        #(if (= (length ratioone) 1) #{
         \tuplet #(car ratioone) { 4 }
             #} )
       }
      }
     }
    }

    \tweak self-alignment-X #CENTER
    \tweak Y-offset #(- verticaloffset 0.4)
    \tweak X-offset #horizontaloffset
    \textEndMark \markup {          \fontsize #-3 "="}

    \tweak Y-offset #verticaloffset
    \tweak self-alignment-X #LEFT
    \tweak X-offset #horizontaloffset
    \tweak self-alignment-Y -1
    \textEndMark \markup {

     \hspace  #1.5
     \fontsize #-4.5
     \concat {
      \note { $notetwo   } #(if (=  (ly:duration-log notetwo) 4) 1.35 1.2 )
      {
       \hspace #0.5
       \combine
       \draw-line #'(-2 . 0)
       \musicglyph "arrowheads.open.01"
      }

      \hspace #(if (> (ly:duration-log notetwo) 2) -4 -3.5)
      \raise #(if (< (ly:duration-log notetwo) 8) 2 (ly:duration-log notetwo))
      \fontsize #1
      \rhythm {
       \override TupletBracket.bracket-visibility = ##t
       \override TupletNumber.text = #tuplet-number::calc-fraction-text
       \override TupletBracket.shorten-pair = #(cons -3 -3)
       \override TupletBracket.edge-height = #'(0.7 . 0)
       \override TupletBracket.X-offset = #0
       \override NoteHead.stencil = ##f
       \override Stem.stencil = ##f
       #(cond ((= (length ratiotwo) 2) #{
        \tuplet #(cadr ratiotwo) { \tuplet #(car ratiotwo) { 4 } }
                                       #} )
              ((= (length ratiotwo) 1) #{
               \tuplet #(car ratiotwo) { 4 }
                                       #} )
              ((= (length ratiotwo) 0) #{
               { 4 }
                                       #} ))
      }
     }
    }
   #})
  )


MModEquationBegin =
#(define-music-function (notevalue1 ratio1 notevalue2 ratio2 verticaloffset) (ly:duration? list? ly:duration? list? number? )
  (let* (
         (noteone notevalue1)
         (notetwo notevalue2)
         (ratioone ratio1)
         (ratiotwo ratio2)
         )
   #{
    \tweak self-alignment-X #RIGHT
    \tweak Y-offset #verticaloffset
    \textMark \markup {
     \hspace #-4.8
     \fontsize #-4.5
     \concat {
      {
       \combine
       \musicglyph "arrowheads.open.0M1"
       \draw-line #'(2 . 0)  \musicglyph "space"
      }
      {
       \note { $noteone   } #(if (=  (ly:duration-log noteone) 4) 1.35 1.2 )
       \hspace #(if (> (ly:duration-log notetwo) 2) -4.5 -5)
       \raise #(if (< (ly:duration-log noteone) 8) 2 (ly:duration-log noteone))
       \fontsize #1
       \rhythm {
        \override TupletBracket.bracket-visibility = ##t
        \override TupletNumber.text = #tuplet-number::calc-fraction-text
        \override TupletBracket.shorten-pair = #(cons -3 -3)
        \override TupletBracket.edge-height = #'(0 . 0.7)
        \override TupletBracket.X-offset = #0
        \override NoteHead.stencil = ##f
        \override Stem.stencil = ##f
        #(if (= (length ratioone) 2) #{
         \tuplet #(cadr ratioone) { \tuplet #(car ratioone) { 4 } }
             #} )
        #(if (= (length ratioone) 1) #{
         \tuplet #(car ratioone) { 4 }
             #} )
       }
      }
     }
    }

    \tweak self-alignment-X #CENTER
    \tweak Y-offset #(- verticaloffset 0.4)
    \textMark \markup {    \hspace  #0.5    \fontsize #-3 "="}

    \tweak Y-offset #verticaloffset
    \tweak self-alignment-X #LEFT
    \tweak self-alignment-Y -1
    \textMark \markup {
     \hspace  #1.5
     \fontsize #-4.5
     \concat {
      \note { $notetwo   } #(if (=  (ly:duration-log notetwo) 4) 1.35 1.2 )
      {
       \hspace #0.5
       \combine
       \draw-line #'(-2 . 0)
       \musicglyph "arrowheads.open.01"
      }

      \hspace #(if (> (ly:duration-log notetwo) 2) -4 -3.5)
      \raise #(if (< (ly:duration-log notetwo) 8) 2 (ly:duration-log notetwo))
      \fontsize #1
      \rhythm {
       \override TupletBracket.bracket-visibility = ##t
       \override TupletNumber.text = #tuplet-number::calc-fraction-text
       \override TupletBracket.shorten-pair = #(cons -3 -3)
       \override TupletBracket.edge-height = #'(0.7 . 0)
       \override TupletBracket.X-offset = #0
       \override NoteHead.stencil = ##f
       \override Stem.stencil = ##f
       #(cond ((= (length ratiotwo) 2) #{
        \tuplet #(cadr ratiotwo) { \tuplet #(car ratiotwo) { 4 } }
                                       #} )
              ((= (length ratiotwo) 1) #{
               \tuplet #(car ratiotwo) { 4 }
                                       #} )
              ((= (length ratiotwo) 0) #{
               { 4 }
                                       #} ))
      }
     }
    }
   #})
  )

{
 c'2
 c'2  \MModEquation 2. #'((6 . 4) (3 . 4)) 2 #'((3 . 4)) 7 #0
 \tempo 4 = 120 c'2
 c'2
 c'2
 c'2 \MModEquation 16. #'((44 . 4) (3 . 4)) 16. #'((2 . 3)) 3 #-5  \break
 \MModEquationBegin 16. #'((44 . 4) (3 . 4)) 16. #'((2 . 3)) 7
 \tempo 8 = 300
 c'2
 c'2
 c'2
 c'2
 c'2
 c'2
}
