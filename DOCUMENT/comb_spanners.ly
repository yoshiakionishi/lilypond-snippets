\version "2.24.4"



accelArrow =
#(define-music-function (line_angle) (number?)

   (define x_value (cos (* (/ 3.14159265358979 180) (- 90 line_angle))))
   (define y_value (sin (* (/ 3.14159265358979 180) (- 90 line_angle))))
   #{
     \tweak direction #up
     \tweak style  #'line
     \tweak thickness  #1
     \tweak to-barline ##t
     \tweak rotation #(list line_angle -1 0 )
     \tweak bound-details.left.stencil #ly:text-interface::print
     \tweak bound-details.left.text \markup \postscript
     #(string-append
       "gsave newpath 
0 0 moveto "
       (number->string x_value) " "
       (number->string y_value)
       " rlineto 
stroke 
grestore")
     \tweak bound-details.left-broken.stencil #ly:text-interface::print
     \tweak bound-details.left-broken.text ##f

     \tweak bound-details.right.stencil #ly:text-interface::print
     \tweak bound-details.right.text \markup \postscript
     "newpath 
0 0 moveto 
-1 -0.3 rlineto 
stroke"
     \tweak bound-details.right-broken.stencil #ly:text-interface::print
     \tweak bound-details.right-broken.text ##f
     \tweak font-shape  #'upright
     \tweak bound-details.left.padding  #0
     \tweak bound-details.right.padding  #0
     \tweak breakable ##t
     \tweak after-line-breaking ##t

     \startTextSpan
   #})

rallArrow =
#(define-music-function (line_angle) (number?)

   (define x_value (cos (* (/ 3.14159265358979 180) (- 90 line_angle))))
   (define y_value (sin (* (/ 3.14159265358979 180) (- 90 line_angle))))
   #{
     \tweak direction #up
     \tweak style  #'line
     \tweak thickness  #1
     \tweak to-barline ##t
     \tweak rotation #(list (* -1 line_angle) 1 0 )

     \tweak bound-details.left.stencil #ly:text-interface::print
     \tweak bound-details.left.text \markup \postscript
     #(string-append
       "gsave 
newpath 
0 0 moveto "
       (number->string x_value) " "
       (number->string (* -1 y_value))
       " rlineto 
stroke 
grestore")
     \tweak bound-details.left-broken.stencil #ly:text-interface::print
     \tweak bound-details.left-broken.text ##f

     \tweak bound-details.right.stencil #ly:text-interface::print
     \tweak bound-details.right.text \markup \postscript
     "newpath 
0 0 moveto 
-1 -0.3 rlineto 
stroke"
     \tweak bound-details.right-broken.stencil #ly:text-interface::print
     \tweak bound-details.right-broken.text ##f
     \tweak font-shape  #'upright
     \tweak bound-details.left.padding  #0
     \tweak bound-details.right.padding  #0
     \tweak breakable ##t
     \tweak after-line-breaking ##t
     \startTextSpan
   #})


graceNoteBeforeBeatOn =
#(define-music-function (starting_note) (ly:music?)
   #{
     \once \override TextSpanner.style = #'line
     \once \override TextSpanner.bound-details.left.text =
     \markup { \draw-line #'(0 . -1) }
     \once \override TextSpanner.bound-details.right.text =
     \markup {
       \postscript
       "newpath 0 0 moveto 
0 -2.5 rlineto 
stroke 
newpath 
-0.275 -2 moveto 
0.275 -0.75 rlineto 
0.275 0.75 rlineto 
-0.275 -0.2 rlineto 
closepath 
fill"
     }
     \once \override TextSpanner.Y-offset = #5
     \once \override TextSpanner.bound-details.left.padding = #0.5
     \once \override TextSpanner.bound-details.right.padding = #-0.25
     #starting_note
     \startTextSpan
   #})


graceNoteBeforeBeatOff =
#(define-music-function (ending_note) (ly:music?)
   #{
     #ending_note
     \stopTextSpan
   #})


graceNoteAfterBeatOn =
#(define-music-function (starting_note) (ly:music?)
   #{
     \once \override TextSpanner.style = #'line
     \once \override TextSpanner.bound-details.right.text =
     \markup {
       \combine \draw-line #'(0 . -1)
       \postscript "newpath 
0 -1 moveto 
0 -1 rlineto 
stroke"
     }
     \once \override TextSpanner.bound-details.left.text =
     \markup {
       \postscript
       "newpath 0 0 moveto 
0 -1 rlineto 
stroke 
newpath 
-0.275 -0.75 moveto 
0.275 -0.75 rlineto 
0.275 0.75 rlineto 
-0.275 -0.2 rlineto 
closepath 
fill"
     }
     \once \override TextSpanner.Y-offset = #2
     \once \override TextSpanner.bound-details.left.padding = #0.5
     \once \override TextSpanner.bound-details.right.padding = #-0.25

     #starting_note
     \startTextSpan
   #})


graceNoteAfterBeatOff =
#(define-music-function (ending_note) (ly:music?)
   #{
     #ending_note
     \stopTextSpan
   #})

%%%%%%%%%%%%%%%%%%%LSR SNIPPET START%%%%%%%%%%%%%%%%%%

#(define (degrees->radians deg)
   (* PI (/ deg 180.0)))


slash =
#(define-music-function (ang stem-fraction protrusion)
   (number? number? number?)
   (remove-grace-property 'Voice 'Stem 'direction)
   #{
     \once \override Stem.stencil =
     #(lambda (grob)
        (let* ((x-parent (ly:grob-parent grob X))
               (is-rest? (ly:grob?
                          (ly:grob-object x-parent 'rest)))
               (beam (ly:grob-object grob 'beam))
               (stil (ly:stem::print grob)))
          (cond
           (is-rest? empty-stencil)
           ((ly:grob? beam)
            (let* ((refp (ly:grob-system grob))
                   (stem-y-ext (ly:grob-extent grob grob Y))
                   (stem-length
                    (- (cdr stem-y-ext) (car stem-y-ext)))
                   (beam-X-pos (ly:grob-property beam 'X-positions))
                   (beam-Y-pos (ly:grob-property beam 'positions))
                   (beam-slope (/ (- (cdr beam-Y-pos) (car beam-Y-pos))
                                  (- (cdr beam-X-pos) (car beam-X-pos))))
                   (beam-angle (atan beam-slope))
                   (dir (ly:grob-property grob 'direction))
                   (line-dy (* stem-length stem-fraction))
                   (line-dy-with-protrusions (if (= dir 1)
                                                 (+ (* 4 protrusion) beam-angle)
                                                 (- (* 4 protrusion) beam-angle)))
                   (ang (if (> beam-slope 0)
                            (if (= dir 1)
                                (+ (degrees->radians ang) (* beam-angle 0.7))
                                (degrees->radians ang))
                            (if (= dir 1)
                                (degrees->radians ang)
                                (- (degrees->radians ang) (* beam-angle 0.7)))))
                   (line-dx (/ line-dy-with-protrusions (tan ang)))
                   (protrusion-dx (/ protrusion (tan ang)))
                   (corr (if (= dir 1) (car stem-y-ext) (cdr stem-y-ext))))
              (ly:stencil-add
               stil
               (grob-interpret-markup grob
                                      (markup
                                       #:translate
                                       (cons (- protrusion-dx)
                                             (+ corr
                                                (* dir
                                                   (- stem-length
                                                      (+ stem-fraction protrusion)))))
                                       #:override '(thickness . 1.7)
                                       #:draw-line
                                       (cons line-dx
                                             (* dir line-dy-with-protrusions)))))))
           (else stil))))
   #})

startSlashedGraceMusic = {
  \slash 40 1 0.5
  \override Flag.stroke-style = #"grace"
}
stopSlashedGraceMusic = {
  \revert Flag.stroke-style
}

startAcciaccaturaMusic = {
  \slash 40 1 0.5
  s1*0(
  \override Flag.stroke-style = #"grace"
}
stopAcciaccaturaMusic = {
  \revert Flag.stroke-style
  s1*0)
}
%%%%%%%%%%%%%%%%%%% LSR SNIPPET END %%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%% A %%%%%%%%%%%%%%%%%%

\score {

  \new Staff = "allElementsCombined"
  \with {instrumentName = \markup {\fontsize #4 \box "A"}}  {
    \numericTimeSignature
    \override Score.MetronomeMark.Y-offset = #5.75
    \tempo 4 = 100
    \time 5/4

    <<
      {
        \tieNeutral \stemNeutral
        d'4~
        \tuplet 3/2 {d'8 d'4}
        \stemUp \grace  {
          \startSlashedGraceMusic \graceNoteBeforeBeatOn e'8 f''
          \stopSlashedGraceMusic
        } \graceNoteBeforeBeatOff g'4~
        \stemNeutral g'8.[ \grace {
          \startSlashedGraceMusic \graceNoteAfterBeatOn
          e''16 c'' e' c' \stopSlashedGraceMusic
        }
        \graceNoteAfterBeatOff d''16]~
        \tuplet 3/2 {d''8 d'8 d'8~} |
        \time 4/4
        d'1 \bar"||"
      }
      \\
      {
        s4  \tuplet 3/2 {
          s8 \override Voice.TextSpanner.Y-offset = #6.5
          s4^\markup {\translate #'(0 . 6.5) \bold "rall."}
          \rallArrow #4
        } s2. \tempo 4 = 50 s4*4 \stopTextSpan
      }
    >>
  }
}
%%%%%%%%%%%%%%%%%%% B %%%%%%%%%%%%%%%%%%
\score {
  <<
    \new Staff = "tempoLine" \with {
      \remove Clef_engraver
      \remove Staff_symbol_engraver
      \remove Time_signature_engraver
    }
    {
      \numericTimeSignature
      \override Score.MetronomeMark.Y-offset = #6
      \tempo 4 = 100
      \time 5/4
      s4  \tuplet 3/2 {
        s8 \override Voice.TextSpanner.Y-offset = #-2.25
        s4^\markup {\translate #'(0 . 0) \bold "rall."}
        \rallArrow #4
      } s2 \after 64*15 \stopTextSpan s8*2 |
      \tempo 4 = 50  s4*4
    }

    \new Staff = "music"
    \with { instrumentName = \markup {\fontsize #4 \box "B"}}
    {
      \tieNeutral \stemNeutral
      d'4~
      \tuplet 3/2 {d'8 d'4}
      \grace {
        \startSlashedGraceMusic \graceNoteBeforeBeatOn e'8 f''
        \stopSlashedGraceMusic
      } \graceNoteBeforeBeatOff g'4~
      g'8.[ \grace {
        \startSlashedGraceMusic \graceNoteAfterBeatOn
        e''16 c'' e' c' \stopSlashedGraceMusic
      }
      \graceNoteAfterBeatOff d''16]~
      \tuplet 3/2 {d''8 d'8 d'8~} |
      \time 4/4
      d'1 \bar"||"
    }
  >>
}

