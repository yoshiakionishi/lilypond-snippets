\version "2.24.4"
\language "english"

% This code includes snippet for grace note
% slashes, which has been taken from:
% https://lsr.di.unimi.it/LSR/Item?id=1048

% Slightly revised, Jan. 19 2025 - YO

graceNoteBeforeBeatOn =
#(define-music-function (setting-list starting_note) (list? ly:music? )
  #{
   \once \override TextSpanner.style = #'line
   \once \override TextSpanner.bound-details.left.text =
   \markup {
    \combine
    \draw-line #(cons 0 -0.5)
    \postscript #(string-append "newpath 
0 -0.5 moveto 
0 " (number->string (cadr setting-list)) " rlineto 
stroke")
   }
   \once \override TextSpanner.bound-details.right.text =
   \markup {
    \postscript
    #(string-append "newpath 0 0 moveto 
0 " (number->string (caddr setting-list))  " rlineto 
stroke 
newpath 
-0.275 " (number->string (+ (caddr setting-list) 0.25))  " moveto 
0.275 -0.75 rlineto 
0.275 0.75 rlineto 
-0.275 -0.2 rlineto 
closepath 
fill")
   }
   \once \override TextSpanner.extra-offset = #(cons 0 (car setting-list))
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
#(define-music-function (setting-list starting_note) (list? ly:music?)
  #{
   \once \override TextSpanner.style = #'line
   \once \override TextSpanner.bound-details.right.text =
   \markup {
    \combine
    \draw-line #(cons 0 -1)
    \postscript #(string-append "newpath 
0 -1 moveto 
0 " (number->string (caddr setting-list)) " rlineto 
stroke")
   }
   \once \override TextSpanner.bound-details.left.text =
   \markup {
    \postscript
    #(string-append "newpath 0 0 moveto 
0 " (number->string (cadr setting-list))  " rlineto 
stroke 
newpath 
-0.275 " (number->string (+ (cadr setting-list) 0.25))  " moveto 
0.275 -0.75 rlineto 
0.275 0.75 rlineto 
-0.275 -0.2 rlineto 
closepath 
fill")
   }
   \once \override TextSpanner.extra-offset = #(cons 0 (car setting-list))
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

{
 \grace {
  \startSlashedGraceMusic
  \graceNoteBeforeBeatOn #'(1 -2 -1) d'8^\markup{\translate #'(0 . 3) \box A} e f g e' c'
 }
 \graceNoteBeforeBeatOff d''2
 \grace {
  \startSlashedGraceMusic
  \graceNoteAfterBeatOn #'(0 -1 -2) d''8^\markup{\box B} e' f'' g' e'' c'
 }
 \graceNoteAfterBeatOff d'2
}