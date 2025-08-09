%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Yoshiaki Onishi
%
% Metric Modulation Equation Indicators
% DRAFT VERSION
% Aug 9 2025
% this draft includes four different functions:
% The first two are the metric modulation equation indicators, using traditional flags. 
% The other two utilize the so-called modern straight flags.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\version "2.25.4"
MModEquation =
#(define-music-function (notevalue1 ratio1 notevalue2 ratio2 verticaloffset horizontaloffset) (ly:duration? list? ly:duration? list? number? number?)
  (let* (
         (noteone notevalue1)
         (notetwo notevalue2)
         (ratioone ratio1)
         (ratiotwo ratio2)
         )
   #{

    \tweak self-alignment-X #LEFT
    \tweak X-offset #(- horizontaloffset 0.35)
    \tweak Y-offset #verticaloffset

    \textEndMark \markup {
     \hspace #-4.25
     \raise #0
     \fontsize #-4.5
     \concat {
      {
       \combine
       \musicglyph "arrowheads.open.0M1"
       \draw-line #'(2 . 0)  \musicglyph "space"
      }

      {
       \note { $noteone   } #(if (=  (ly:duration-log noteone) 4) 1.35 1.2 )
      }

      {
       \hspace #(if (> (ly:duration-log noteone) 2) -4.5 -4.5)
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

        #(cond ((= (length ratioone) 2) #{
         \tuplet #(cadr ratioone) { \tuplet #(car ratioone) { 4 } }
                                        #} )
               ((= (length ratioone) 1) #{
                \tuplet #(car ratioone) { 4 }
                                        #} )
               ((= (length ratioone) 0) #{
                \override TupletBracket.transparent = ##t
                \override TupletNumber.transparent = ##t
                \tuplet 4/4 { 4 }
                                        #} ))
       }

      }

     }
    }


    \tweak self-alignment-X #CENTER
    \tweak Y-offset #(- verticaloffset 0.4)
    \tweak X-offset #(- horizontaloffset 0.35)
    \textEndMark \markup {          \fontsize #-3 "="}

    \tweak Y-offset #verticaloffset
    \tweak self-alignment-X #RIGHT
    \tweak X-offset #(- horizontaloffset 0.35)
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
    \tweak self-alignment-X #LEFT
    \tweak Y-offset #verticaloffset
    \textMark \markup {
     \hspace #-4.25
     \raise #0
     \fontsize #-4.5
     \concat {
      {
       \combine
       \musicglyph "arrowheads.open.0M1"
       \draw-line #'(2 . 0)  \musicglyph "space"
      }
      {
       \note { $noteone } #(if (=  (ly:duration-log noteone) 4) 1.35 1.2 )
      }
      {
       \hspace #(if (> (ly:duration-log noteone) 2) -4.5 -4.5)
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
        #(cond ((= (length ratioone) 2) #{
         \tuplet #(cadr ratioone) { \tuplet #(car ratioone) { 4 } }
                                        #} )
               ((= (length ratioone) 1) #{
                \tuplet #(car ratioone) { 4 }
                                        #} )
               ((= (length ratioone) 0) #{
                \override TupletBracket.transparent = ##t
                \override TupletNumber.transparent = ##t
                \tuplet 4/4 { 4 }
                                        #} ))
       }

      }
     }
    }

    \tweak self-alignment-X #CENTER
    \tweak Y-offset #(- verticaloffset 0.4)

    \textMark \markup {  \hspace  #1.5 \fontsize #-3 "="}

    \tweak Y-offset #verticaloffset
    \tweak self-alignment-X #RIGHT
    \tweak X-offset #3.5
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


MModEquationSTR =
#(define-music-function (notevalue1 ratio1 notevalue2 ratio2 verticaloffset horizontaloffset) (ly:duration? list? ly:duration? list? number? number?)
  (let* (
         (noteone notevalue1)
         (notetwo notevalue2)
         (ratioone ratio1)
         (ratiotwo ratio2)
         )
   #{

    \tweak self-alignment-X #LEFT
    \tweak X-offset #(- horizontaloffset 0.35)
    \tweak Y-offset #verticaloffset

    \textEndMark \markup {
     \hspace #-4.25
     \raise #0
     \fontsize #-4.5 \override #'(flag-style . modern-straight-flag)
     \concat {
      {
       \combine
       \musicglyph "arrowheads.open.0M1"
       \draw-line #'(2 . 0)  \musicglyph "space"
      }

      {
      \override #'(flag-style . modern-straight-flag)
      \note {  $noteone } #(if (=  (ly:duration-log noteone) 4) 1.25 1.25 )
      }

      {
       \hspace #(if (> (ly:duration-log noteone) 2) -4.5 -4.5)
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

        #(cond ((= (length ratioone) 2) #{
         \tuplet #(cadr ratioone) { \tuplet #(car ratioone) { 4 } }
                                        #} )
               ((= (length ratioone) 1) #{
                \tuplet #(car ratioone) { 4 }
                                        #} )
               ((= (length ratioone) 0) #{
                \override TupletBracket.transparent = ##t
                \override TupletNumber.transparent = ##t
                \tuplet 4/4 { 4 }
                                        #} ))
       }

      }

     }
    }


    \tweak self-alignment-X #CENTER
    \tweak Y-offset #(- verticaloffset 0.4)
    \tweak X-offset #(- horizontaloffset 0.35)
    \textEndMark \markup {          \fontsize #-3 "="}

    \tweak Y-offset #verticaloffset
    \tweak self-alignment-X #RIGHT
    \tweak X-offset #(- horizontaloffset 0.35)
    \tweak self-alignment-Y -1
    \textEndMark \markup {

     \hspace  #1.5
     \fontsize #-4.5
     \concat {
      \override #'(flag-style . modern-straight-flag)
      \note {  $notetwo } #(if (=  (ly:duration-log notetwo) 4) 1.25 1.25 )
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

MModEquationBeginSTR =
#(define-music-function (notevalue1 ratio1 notevalue2 ratio2 verticaloffset) (ly:duration? list? ly:duration? list? number? )
  (let* (
         (noteone notevalue1)
         (notetwo notevalue2)
         (ratioone ratio1)
         (ratiotwo ratio2)
         )
   #{
    \tweak self-alignment-X #LEFT
    \tweak Y-offset #verticaloffset
    \textMark \markup {

     \hspace #-4.25
     \raise #0
     \fontsize #-4.5

     \concat {
      {
       \combine
       \musicglyph "arrowheads.open.0M1"
       \draw-line #'(2 . 0)  \musicglyph "space"
      }
      {
      \override #'(flag-style . modern-straight-flag)
      \note {  $noteone } #(if (=  (ly:duration-log noteone) 4) 1.25 1.25 )
      }
      {
       \hspace #(if (> (ly:duration-log noteone) 2) -4.5 -4.5)
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
        #(cond ((= (length ratioone) 2) #{
         \tuplet #(cadr ratioone) { \tuplet #(car ratioone) { 4 } }
                                        #} )
               ((= (length ratioone) 1) #{
                \tuplet #(car ratioone) { 4 }
                                        #} )
               ((= (length ratioone) 0) #{
                \override TupletBracket.transparent = ##t
                \override TupletNumber.transparent = ##t
                \tuplet 4/4 { 4 }
                                        #} ))
       }

      }
     }
    }

    \tweak self-alignment-X #CENTER
    \tweak Y-offset #(- verticaloffset 0.4)

    \textMark \markup {  \hspace  #1.5 \fontsize #-3 "="}

    \tweak Y-offset #verticaloffset
    \tweak self-alignment-X #RIGHT
    \tweak X-offset #3.5
    \tweak self-alignment-Y -1
    \textMark \markup {

     \hspace  #1.5
     \fontsize #-4.5
     \concat {
        \override #'(flag-style . modern-straight-flag)
      \note {  $notetwo } #(if (=  (ly:duration-log notetwo) 4) 1.25 1.25 )
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
 c'2  \MModEquation 2 #'((6 . 4) (3 . 4)) 2 #'((3 . 4)) 7 #0
 \tempo 4 = 120 c'2
 c'2
 c'2
 c'2 \MModEquation 16. #'((44 . 4) (3 . 4)) 16. #'((2 . 3)) 3 #-5  \break
 \MModEquationBegin 16. #'((44 . 4) (3 . 4)) 16. #'((2 . 3)) 7
 \tempo 8 = 300
 c'2
 c'2
 c'2
 c'2  \MModEquation 4 #'() 16. #'( ) 0 #0
 c'2
 c'2 \break
 c'2
 c'2  \MModEquationSTR 2 #'((6 . 4) (3 . 4)) 2 #'((3 . 4)) 7 #0
 \tempo 4 = 120 c'2
 c'2
 c'2
 c'2 \MModEquationSTR 16. #'((44 . 4) (3 . 4)) 16. #'((2 . 3)) 3 #-5  \break
 \MModEquationBeginSTR 16. #'((44 . 4) (3 . 4)) 16. #'((2 . 3)) 7
 \tempo 8 = 300
 c'2
 c'2
 c'2
 c'2  \MModEquationSTR 4 #'() 16. #'( ) 0 #0
 c'2
 c'2 \break
}

\layout {
 indent = 3.5\cm
 \context{
  \Score
  harmonicDots = ##t
  \override Flag.stencil = #modern-straight-flag
  \override MetronomeMark.flag-style = #'modern-straight-flag
  \override StemTremolo.shape = #'beam-like
  \override StemTremolo.slope = #0.4

 }
}
