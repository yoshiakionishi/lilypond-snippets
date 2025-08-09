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
\version "2.24.4"

\language "english"

MModEquation =
#(define-music-function
  (notevalue1 ratio1 notevalue2 ratio2 verticaloffset horizontaloffset)
  (ly:duration? list? ly:duration? list? number? number?)
  (let* (
         (noteone notevalue1)
         (notetwo notevalue2)
         (ratioone ratio1)
         (ratiotwo ratio2)
         )
   #{
    %  \tweak self-alignment-X #LEFT
    \tweak X-offset #(- horizontaloffset 0.35)
    \tweak Y-offset #verticaloffset
    \textEndMark  \markup \right-align {
     \hspace #-0.5
     \raise #0
     \fontsize #-4.5
     \override #'(self-alignment . LEFT)
     {
      {
       \note { $noteone } #(if (= (ly:duration-log noteone) 4) 1 1 )
      }
      {
       \hspace #(+ (* (ly:duration-dot-count noteone) -0.75) -4)
       \concat {
        \combine
        \musicglyph "arrowheads.open.0M1"
        \draw-line #'(2 . 0) \fontsize #-5 \musicglyph "space"
       }
      }
      {
       \hspace #(cond ((<= (ly:duration-log noteone) 2) 0.75)
                      ((> (ly:duration-log noteone) 2) 0.25) )
       \raise #(cond
                ((= (ly:duration-log noteone) 0) -2)
                ((and (> (ly:duration-log noteone) 0)
                      (<= (ly:duration-log noteone) 4) ) -.5)
                ((> (ly:duration-log noteone) 4)
                 (+ (* (- (ly:duration-log noteone) 5) 0.6) 0))
                )
       #(cond
         ((= (length ratioone) 1)
          (markup
           #:line
           (#:hspace
            -4.5
            #:raise
            2.75
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons 0 0.5)
                (#:draw-line (cons 0 -0.5))))
              #:vspace
              -0.45
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (car ratioone)) 2)
                     (begin (string-append
                             (number->string (car (car ratioone)))
                             ":"
                             (number->string (cadr (car ratioone))))  )
                     (number->string (car (car ratioone)))
                     )

                 (#:italic (#:fontsize -5 (#:musicglyph "space")))))))))))

         ((= (length ratioone) 2)
          (markup
           #:line
           (#:hspace
            -4.5
            #:raise
            2.75
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons 0 0.5)
                (#:draw-line (cons 0 -0.5))))
              #:vspace
              -0.45
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (car ratioone)) 2)
                     (begin (string-append
                             (number->string (car (car ratioone)))
                             ":"
                             (number->string (cadr (car ratioone))))  )
                     (number->string (car (car ratioone)))
                     )
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))))))))

           #:line
           (#:hspace
            -4.8
            #:raise
            4
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons 0 0.5)
                (#:draw-line (cons 0 -0.5))))
              #:vspace
              -0.45
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (cadr ratioone)) 2)
                     (begin (string-append
                             (number->string (car (cadr ratioone)))
                             ":"
                             (number->string (cadr (cadr ratioone))))  )
                     (number->string (car (cadr ratioone)))
                     )
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))))))))
           ))
         )
      }
     }
    }
    \tweak self-alignment-X #CENTER
    \tweak Y-offset #(- verticaloffset 0.4)
    \tweak X-offset #(- horizontaloffset 0.35)
    \textEndMark \markup {  \fontsize #-3 "="}

    \tweak Y-offset #verticaloffset
    \tweak self-alignment-X #RIGHT
    \tweak X-offset #(- horizontaloffset 0.35)
    \tweak self-alignment-Y -1
    \textEndMark \markup \left-align {
     \hspace #1.9
     \raise #0
     \fontsize #-4.5
     \concat {
      {
       \hspace #(cond ((<= (ly:duration-log notetwo) 2) 4)
                      ((> (ly:duration-log notetwo) 2) 3.75) )
       \raise #(cond
                ((= (ly:duration-log notetwo) 0) -2)
                ((and (> (ly:duration-log notetwo) 0)
                      (<= (ly:duration-log notetwo) 4) ) -.5)
                ((> (ly:duration-log notetwo) 4)
                 (+ (* (- (ly:duration-log notetwo) 5) 0.6) 0))
                )
       #(cond
         ((= (length ratiotwo) 1)
          (markup
           #:line
           (#:hspace
            -4.5
            #:raise
            3.25
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons 0 -0.5 )
                 (#:draw-line (cons 0 -0.5)))
                )
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons -3.5 0)
                (#:draw-line (cons -4.25 0))))
              #:vspace
              -0.35
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (car ratiotwo)) 2)
                     (begin (string-append
                             (number->string (car (car ratiotwo)))
                             ":"
                             (number->string (cadr (car ratiotwo))))  )
                     (number->string (car (car ratiotwo)))
                     )
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))))))))))
         ((= (length ratiotwo) 2)
          (markup
           #:line
           (#:hspace
            -4.5
            #:raise
            3.25
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)

                (#:translate
                 (cons 0 -0.5 )
                 (#:draw-line (cons 0 -0.5)))
                )
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons -3.5 0)
                (#:draw-line (cons -4.25 0))))
              #:vspace
              -0.35
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (car ratiotwo)) 2)
                     (begin (string-append
                             (number->string (car (car ratiotwo)))
                             ":"
                             (number->string (cadr (car ratiotwo))))  )
                     (number->string (car (car ratiotwo)))
                     )
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))))))))
           #:line
           (#:hspace
            -4.8
            #:raise
            4.5
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons 0 -0.5 )
                 (#:draw-line (cons 0 -0.5)))
                )
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons -3.5 0)
                (#:draw-line (cons -4.25 0)))
               )
              #:vspace
              -0.35
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (cadr ratiotwo)) 2)
                     (begin (string-append
                             (number->string (car (cadr ratiotwo)))
                             ":"
                             (number->string (cadr (cadr ratiotwo))))  )
                     (number->string (car (cadr ratiotwo)))
                     )

                 (#:italic (#:fontsize -5 (#:musicglyph "space")))))))))
           ))
         )
      }
      %


      {
       \hspace #-4.25

       \note { $notetwo } #(if (= (ly:duration-log notetwo) 4) 1 1 )
      }
      {
       \hspace #0.5
       \combine
       \draw-line #'(-2 . 0)
       \musicglyph "arrowheads.open.01"
      }





     }

    }

   #})
  )



MModEquationBegin =
#(define-music-function
  (notevalue1 ratio1 notevalue2 ratio2 verticaloffset )
  (ly:duration? list? ly:duration? list? number? )
  (let* (
         (noteone notevalue1)
         (notetwo notevalue2)
         (ratioone ratio1)
         (ratiotwo ratio2)
         )
   #{

    \tweak Y-offset #verticaloffset
    \textMark  \markup \left-align {

     \raise #0
     \fontsize #-4.5
     \override #'(self-alignment . LEFT)
     {
      {
       \hspace #-4
       %#(+ (* (ly:duration-dot-count noteone) -0.75) -4)
       \concat {
        \combine
        \musicglyph "arrowheads.open.0M1"
        \draw-line #'(2 . 0) \fontsize #-5 \musicglyph "space"
       }
      }

      {
       \hspace #-0.5
       \note { $noteone } #(if (= (ly:duration-log noteone) 4) 1 1 )
      }


      {
       \hspace #(cond
                 ((<= (ly:duration-dot-count noteone) 1) -0.5)
                 ((> (ly:duration-dot-count noteone) 1)
                  (+ (* (ly:duration-dot-count noteone) -0.5) -0.25)))
       \right-align
       \raise #(cond
                ((= (ly:duration-log noteone) 0) -2)
                ((and (> (ly:duration-log noteone) 0)
                      (<= (ly:duration-log noteone) 4) ) -.5)
                ((> (ly:duration-log noteone) 4)
                 (+ (* (- (ly:duration-log noteone) 5) 0.6) 0))
                )

       #(cond
         ((= (length ratioone) 1)
          (markup
           #:line
           (#:hspace
            -4.5
            #:raise
            2.75
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons 0 0.5)
                (#:draw-line (cons 0 -0.5))))
              #:vspace
              -0.45
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (car ratioone)) 2)
                     (begin (string-append
                             (number->string (car (car ratioone)))
                             ":"
                             (number->string (cadr (car ratioone))))  )
                     (number->string (car (car ratioone)))
                     )

                 (#:italic
                  (#:fontsize -5
                              (#:musicglyph "space")))))))))))

         ((= (length ratioone) 2)
          (markup
           #:line
           (#:hspace
            -4.5
            #:raise
            2.75
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons 0 0.5)
                (#:draw-line (cons 0 -0.5))))
              #:vspace
              -0.45
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (car ratioone)) 2)
                     (begin (string-append
                             (number->string (car (car ratioone)))
                             ":"
                             (number->string (cadr (car ratioone)))))
                     (number->string (car (car ratioone)))
                     )
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))))))))

           #:line
           (#:hspace
            -4.8
            #:raise
            4
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons 0 0.5)
                (#:draw-line (cons 0 -0.5))))
              #:vspace
              -0.45
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (cadr ratioone)) 2)
                     (begin (string-append
                             (number->string (car (cadr ratioone)))
                             ":"
                             (number->string (cadr (cadr ratioone))))  )
                     (number->string (car (cadr ratioone)))
                     )

                 (#:italic (#:fontsize -5 (#:musicglyph "space")))))))))
           ))
         )

      }
      {
       \hspace #(+ (* (ly:duration-dot-count noteone) 0.35) -0.2)
       \fontsize #2 \lower #0.5  "="
      }
      \concat {

       {
        \hspace #(cond ((<= (ly:duration-log notetwo) 2) 4.15 )
                       ((> (ly:duration-log notetwo) 2) 4.15) )
        \raise #(cond
                 ((= (ly:duration-log notetwo) 0) -2)
                 ((and (> (ly:duration-log notetwo) 0)
                       (<= (ly:duration-log notetwo) 4) ) -.5)
                 ((> (ly:duration-log notetwo) 4)
                  (+ (* (- (ly:duration-log notetwo) 5) 0.6) 0))
                 )

        #(cond
          ((= (length ratiotwo) 1)
           (markup
            #:line
            (#:hspace
             -4.5
             #:raise
             3.25
             (#:center-column
              (#:concat
               (#:translate
                (cons 3.5 0.5)
                (#:override
                 (cons 'thickness 1.5)

                 (#:translate
                  (cons 0 -0.5 )
                  (#:draw-line (cons 0 -0.5)))
                 )

                #:hspace
                -0.1

                #:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))


               #:vspace
               -0.35
               #:whiteout
               (#:halign
                1.75
                (#:concat
                 (#:fontsize
                  -1
                  (#:italic (#:fontsize -5 (#:musicglyph "space")))
                  #:fontsize
                  -1
                  #:italic
                  (if (= (length (car ratiotwo)) 2)
                      (begin (string-append
                              (number->string (car (car ratiotwo)))
                              ":"
                              (number->string (cadr (car ratiotwo)))))
                      (number->string (car (car ratiotwo)))
                      )
                  (#:italic
                   (#:fontsize -5
                               (#:musicglyph "space")))))))))))

          ((= (length ratiotwo) 2)
           (markup
            #:line
            (#:hspace
             -4.5
             #:raise
             3.25
             (#:center-column
              (#:concat
               (#:translate
                (cons 3.5 0.5)
                (#:override
                 (cons 'thickness 1.5)
                 (#:translate
                  (cons 0 -0.5 )
                  (#:draw-line (cons 0 -0.5)))
                 )
                #:hspace
                -0.1
                #:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:vspace
               -0.35
               #:whiteout
               (#:halign
                1.75
                (#:concat
                 (#:fontsize
                  -1
                  (#:italic (#:fontsize -5 (#:musicglyph "space")))
                  #:fontsize
                  -1
                  #:italic
                  (if (= (length (car ratiotwo)) 2)
                      (begin (string-append
                              (number->string (car (car ratiotwo)))
                              ":"
                              (number->string (cadr (car ratiotwo)))))
                      (number->string (car (car ratiotwo)))
                      )
                  (#:italic
                   (#:fontsize -5
                               (#:musicglyph "space")))))))))


            #:line
            (#:hspace
             -4.8
             #:raise
             4.5
             (#:center-column
              (#:concat
               (#:translate
                (cons 3.5 0.5)
                (#:override
                 (cons 'thickness 1.5)
                 (#:translate
                  (cons 0 -0.5 )
                  (#:draw-line (cons 0 -0.5)))
                 )
                #:hspace
                -0.1
                #:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0)))
                )
               #:vspace
               -0.35
               #:whiteout
               (#:halign
                1.75
                (#:concat
                 (#:fontsize
                  -1
                  (#:italic (#:fontsize -5 (#:musicglyph "space")))
                  #:fontsize
                  -1
                  #:italic
                  (if (= (length (cadr ratiotwo)) 2)
                      (begin (string-append
                              (number->string (car (cadr ratiotwo)))
                              ":"
                              (number->string (cadr (cadr ratiotwo)))))
                      (number->string (car (cadr ratiotwo)))
                      )
                  (#:italic
                   (#:fontsize -5
                               (#:musicglyph "space")))))))))
            ))
          )
       }
       %


       {
        \hspace #-4
        \note { $notetwo }
        #(if (= (ly:duration-log notetwo) 4) 1 1 )
       }
       {
        \hspace #0.5
        \combine
        \draw-line #'(-2 . 0)
        \musicglyph "arrowheads.open.01"
       }
      }
     }
    }
   #})
  )


MModEquationSTR =
#(define-music-function
  (notevalue1 ratio1 notevalue2 ratio2 verticaloffset horizontaloffset)
  (ly:duration? list? ly:duration? list? number? number?)
  (let* (
         (noteone notevalue1)
         (notetwo notevalue2)
         (ratioone ratio1)
         (ratiotwo ratio2)
         )
   #{
    %  \tweak self-alignment-X #LEFT
    \tweak X-offset #(- horizontaloffset 0.35)
    \tweak Y-offset #verticaloffset
    \textEndMark  \markup \right-align {
     \hspace #-0.5
     \raise #0
     \fontsize #-4.5
     \override #'(flag-style . modern-straight-flag)
     \override #'(self-alignment . LEFT)
     {
      {
       \override #'(flag-style . modern-straight-flag)
       \note { $noteone } #(if (= (ly:duration-log noteone) 4) 1 1 )
      }
      {
       \hspace #(+ (* (ly:duration-dot-count noteone) -0.5) -4.5)
       \concat {
        \combine
        \musicglyph "arrowheads.open.0M1"
        \draw-line #'(2 . 0) \fontsize #-5 \musicglyph "space"
       }
      }
      {
       \hspace #(cond ((<= (ly:duration-log noteone) 2) 0.75)
                      ((> (ly:duration-log noteone) 2) 0.25) )
       \raise #(cond
                ((= (ly:duration-log noteone) 0) -2)
                ((and (> (ly:duration-log noteone) 0)
                      (<= (ly:duration-log noteone) 4) ) -.5)
                ((> (ly:duration-log noteone) 4)
                 (+ (* (- (ly:duration-log noteone) 5) 0.6) 0))
                )
       #(cond
         ((= (length ratioone) 1)
          (markup
           #:line
           (#:hspace
            -4.5
            #:raise
            2.75
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons 0 0.5)
                (#:draw-line (cons 0 -0.5))))
              #:vspace
              -0.45
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (car ratioone)) 2)
                     (begin (string-append
                             (number->string (car (car ratioone)))
                             ":"
                             (number->string (cadr (car ratioone))))  )
                     (number->string (car (car ratioone)))
                     )
                 (#:italic
                  (#:fontsize -5
                              (#:musicglyph "space")))))))))))

         ((= (length ratioone) 2)
          (markup
           #:line
           (#:hspace
            -4.5
            #:raise
            2.75
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons 0 0.5)
                (#:draw-line (cons 0 -0.5))))
              #:vspace
              -0.45
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (car ratioone)) 2)
                     (begin (string-append
                             (number->string (car (car ratioone)))
                             ":"
                             (number->string (cadr (car ratioone)))))
                     (number->string (car (car ratioone)))
                     )
                 (#:italic
                  (#:fontsize -5
                              (#:musicglyph "space")))))))))
           #:line
           (#:hspace
            -4.8
            #:raise
            4
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons 0 0.5)
                (#:draw-line (cons 0 -0.5))))
              #:vspace
              -0.45
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (cadr ratioone)) 2)
                     (begin (string-append
                             (number->string (car (cadr ratioone)))
                             ":"
                             (number->string (cadr (cadr ratioone)))))
                     (number->string (car (cadr ratioone)))
                     )

                 (#:italic
                  (#:fontsize -5
                              (#:musicglyph "space")))))))))
           ))
         )
      }
     }
    }
    \tweak self-alignment-X #CENTER
    \tweak Y-offset #(- verticaloffset 0.4)
    \tweak X-offset #(- horizontaloffset 0.35)
    \textEndMark \markup {  \fontsize #-3 "="}
    \tweak Y-offset #verticaloffset
    \tweak self-alignment-X #RIGHT
    \tweak X-offset #(- horizontaloffset 0.35)
    \tweak self-alignment-Y -1
    \textEndMark \markup \left-align {
     \hspace #1.5
     \raise #0
     \fontsize #-4.5
     \concat {
      {
       \hspace #(cond ((<= (ly:duration-log notetwo) 2) 4.5)
                      ((> (ly:duration-log notetwo) 2) 3.75) )
       \raise #(cond
                ((= (ly:duration-log notetwo) 0) -2)
                ((and (> (ly:duration-log notetwo) 0)
                      (<= (ly:duration-log notetwo) 4) ) -.5)
                ((> (ly:duration-log notetwo) 4)
                 (+ (* (- (ly:duration-log notetwo) 5) 0.6) 0))
                )
       #(cond
         ((= (length ratiotwo) 1)
          (markup
           #:line
           (#:hspace
            -4.5
            #:raise
            3.25
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons 0 -0.5 )
                 (#:draw-line (cons 0 -0.5)))
                )
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons -3.5 0)
                (#:draw-line (cons -4.25 0))))
              #:vspace
              -0.35
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (car ratiotwo)) 2)
                     (begin (string-append
                             (number->string (car (car ratiotwo)))
                             ":"
                             (number->string (cadr (car ratiotwo)))))
                     (number->string (car (car ratiotwo)))
                     )
                 (#:italic
                  (#:fontsize -5
                              (#:musicglyph "space")))))))))))
         ((= (length ratiotwo) 2)
          (markup
           #:line
           (#:hspace
            -4.5
            #:raise
            3.25
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)

                (#:translate
                 (cons 0 -0.5 )
                 (#:draw-line (cons 0 -0.5)))
                )
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons -3.5 0)
                (#:draw-line (cons -4.25 0))))
              #:vspace
              -0.35
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (car ratiotwo)) 2)
                     (begin (string-append
                             (number->string (car (car ratiotwo)))
                             ":"
                             (number->string (cadr (car ratiotwo)))))
                     (number->string (car (car ratiotwo)))
                     )
                 (#:italic
                  (#:fontsize -5
                              (#:musicglyph "space")))))))))
           #:line
           (#:hspace
            -4.8
            #:raise
            4.5
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons 0 -0.5 )
                 (#:draw-line (cons 0 -0.5)))
                )
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons -3.5 0)
                (#:draw-line (cons -4.25 0)))
               )
              #:vspace
              -0.35
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (cadr ratiotwo)) 2)
                     (begin (string-append
                             (number->string (car (cadr ratiotwo)))
                             ":"
                             (number->string (cadr (cadr ratiotwo)))))
                     (number->string (car (cadr ratiotwo)))
                     )
                 (#:italic
                  (#:fontsize -5
                              (#:musicglyph "space")))))))))
           ))
         )
      }
      {
       \hspace #-4.25
       \override #'(flag-style . modern-straight-flag)
       \note { $notetwo } #(if (= (ly:duration-log notetwo) 4) 1 1 )
      }
      {
       \hspace #0.5
       \combine
       \draw-line #'(-2 . 0)
       \musicglyph "arrowheads.open.01"
      }
     }
    }
   #})
  )

MModEquationBeginSTR =
#(define-music-function
  (notevalue1 ratio1 notevalue2 ratio2 verticaloffset )
  (ly:duration? list? ly:duration? list? number? )
  (let* (
         (noteone notevalue1)
         (notetwo notevalue2)
         (ratioone ratio1)
         (ratiotwo ratio2)
         )
   #{

    \tweak Y-offset #verticaloffset
    \textMark  \markup \left-align {

     \raise #0
     \fontsize #-4.5
     \override #'(self-alignment . LEFT)
     {
      {
       \hspace #-4
       \concat {
        \combine
        \musicglyph "arrowheads.open.0M1"
        \draw-line #'(2 . 0) \fontsize #-5 \musicglyph "space"
       }
      }
      {
       \hspace #-0.5
       \override #'(flag-style . modern-straight-flag)
       \note { $noteone } #(if (= (ly:duration-log noteone) 4) 1 1 )
      }
      {
       \hspace #(cond ((<= (ly:duration-dot-count noteone) 1) -0.5)
                      ((> (ly:duration-dot-count noteone) 1)
                       (+ (* (ly:duration-dot-count noteone) -0.5)
                          -0.25) ) )
       \right-align
       \raise #(cond
                ((= (ly:duration-log noteone) 0) -2)
                ((and (> (ly:duration-log noteone) 0)
                      (<= (ly:duration-log noteone) 4) ) -.5)
                ((> (ly:duration-log noteone) 4)
                 (+ (* (- (ly:duration-log noteone) 5) 0.6) 0))
                )
       #(cond
         ((= (length ratioone) 1)
          (markup
           #:line
           (#:hspace
            -4.5
            #:raise
            2.75
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons 0 0.5)
                (#:draw-line (cons 0 -0.5))))
              #:vspace
              -0.45
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (car ratioone)) 2)
                     (begin (string-append
                             (number->string (car (car ratioone)))
                             ":"
                             (number->string (cadr (car ratioone)))))
                     (number->string (car (car ratioone)))
                     )

                 (#:italic
                  (#:fontsize -5
                              (#:musicglyph "space")))))))))))
         ((= (length ratioone) 2)
          (markup
           #:line
           (#:hspace
            -4.5
            #:raise
            2.75
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons 0 0.5)
                (#:draw-line (cons 0 -0.5))))
              #:vspace
              -0.45
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (car ratioone)) 2)
                     (begin (string-append
                             (number->string (car (car ratioone)))
                             ":"
                             (number->string (cadr (car ratioone)))))
                     (number->string (car (car ratioone)))
                     )
                 (#:italic
                  (#:fontsize -5
                              (#:musicglyph "space")))))))))
           #:line
           (#:hspace
            -4.8
            #:raise
            4
            (#:center-column
             (#:concat
              (#:translate
               (cons 3.5 0.5)
               (#:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:hspace
               -0.1
               #:override
               (cons 'thickness 1.5)
               (#:translate
                (cons 0 0.5)
                (#:draw-line (cons 0 -0.5))))
              #:vspace
              -0.45
              #:whiteout
              (#:halign
               1.75
               (#:concat
                (#:fontsize
                 -1
                 (#:italic (#:fontsize -5 (#:musicglyph "space")))
                 #:fontsize
                 -1
                 #:italic
                 (if (= (length (cadr ratioone)) 2)
                     (begin (string-append
                             (number->string (car (cadr ratioone)))
                             ":"
                             (number->string (cadr (cadr ratioone)))))
                     (number->string (car (cadr ratioone)))
                     )
                 (#:italic
                  (#:fontsize -5
                              (#:musicglyph "space")))))))))
           ))
         )
      }
      {
       \hspace #(+ (* (ly:duration-dot-count noteone) 0.35) -0.2)
       \fontsize #2 \lower #0.5  "="
      }
      \concat {
       {
        \hspace #(cond ((<= (ly:duration-log notetwo) 2) 4.15 )
                       ((> (ly:duration-log notetwo) 2) 4.15) )
        \raise #(cond
                 ((= (ly:duration-log notetwo) 0) -2)
                 ((and (> (ly:duration-log notetwo) 0)
                       (<= (ly:duration-log notetwo) 4) ) -.5)
                 ((> (ly:duration-log notetwo) 4)
                  (+ (* (- (ly:duration-log notetwo) 5) 0.6) 0))
                 )
        #(cond
          ((= (length ratiotwo) 1)
           (markup
            #:line
            (#:hspace
             -4.5
             #:raise
             3.25
             (#:center-column
              (#:concat
               (#:translate
                (cons 3.5 0.5)
                (#:override
                 (cons 'thickness 1.5)
                 (#:translate
                  (cons 0 -0.5 )
                  (#:draw-line (cons 0 -0.5)))
                 )
                #:hspace
                -0.1
                #:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:vspace
               -0.35
               #:whiteout
               (#:halign
                1.75
                (#:concat
                 (#:fontsize
                  -1
                  (#:italic (#:fontsize -5 (#:musicglyph "space")))
                  #:fontsize
                  -1
                  #:italic
                  (if (= (length (car ratiotwo)) 2)
                      (begin (string-append
                              (number->string (car (car ratiotwo)))
                              ":"
                              (number->string (cadr (car ratiotwo)))))
                      (number->string (car (car ratiotwo)))
                      )
                  (#:italic
                   (#:fontsize -5
                               (#:musicglyph "space")))))))))))
          ((= (length ratiotwo) 2)
           (markup
            #:line
            (#:hspace
             -4.5
             #:raise
             3.25
             (#:center-column
              (#:concat
               (#:translate
                (cons 3.5 0.5)
                (#:override
                 (cons 'thickness 1.5)
                 (#:translate
                  (cons 0 -0.5 )
                  (#:draw-line (cons 0 -0.5)))
                 )
                #:hspace
                -0.1
                #:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0))))
               #:vspace
               -0.35
               #:whiteout
               (#:halign
                1.75
                (#:concat
                 (#:fontsize
                  -1
                  (#:italic
                   (#:fontsize -5
                               (#:musicglyph "space")))
                  #:fontsize
                  -1
                  #:italic
                  (if (= (length (car ratiotwo)) 2)
                      (begin (string-append
                              (number->string (car (car ratiotwo)))
                              ":"
                              (number->string (cadr (car ratiotwo)))))
                      (number->string (car (car ratiotwo)))
                      )
                  (#:italic
                   (#:fontsize -5
                               (#:musicglyph "space")))))))))
            #:line
            (#:hspace
             -4.8
             #:raise
             4.5
             (#:center-column
              (#:concat
               (#:translate
                (cons 3.5 0.5)
                (#:override
                 (cons 'thickness 1.5)
                 (#:translate
                  (cons 0 -0.5 )
                  (#:draw-line (cons 0 -0.5)))
                 )
                #:hspace
                -0.1
                #:override
                (cons 'thickness 1.5)
                (#:translate
                 (cons -3.5 0)
                 (#:draw-line (cons -4.25 0)))
                )
               #:vspace
               -0.35
               #:whiteout
               (#:halign
                1.75
                (#:concat
                 (#:fontsize
                  -1
                  (#:italic (#:fontsize -5 (#:musicglyph "space")))
                  #:fontsize
                  -1
                  #:italic
                  (if (= (length (cadr ratiotwo)) 2)
                      (begin (string-append
                              (number->string (car (cadr ratiotwo)))
                              ":"
                              (number->string (cadr (cadr ratiotwo)))))
                      (number->string (car (cadr ratiotwo)))
                      )

                  (#:italic
                   (#:fontsize -5
                               (#:musicglyph "space")))))))))
            ))
          )
       }
       {
        \hspace #-4
        \override #'(flag-style . modern-straight-flag)
        \note { $notetwo } #(if (= (ly:duration-log notetwo) 4) 1 1 )
       }
       {
        \hspace #0.5
        \combine
        \draw-line #'(-2 . 0)
        \musicglyph "arrowheads.open.01"
       }
      }
     }
    }
   #})
  )

{
 c'2
 c'2 \MModEquation 2 #'((6  4) (3  4)) 2 #'((3  4)) 7 #0
 \tempo 4 = 120 c'2
 c'2
 c'2
 c'2 \MModEquation 4. #'((44  4) (3 4)) 16. #'((2  3)) 3 #-5 \break
 \MModEquationBegin 16 #'((44  4) (3  4)) 16.. #'((2  3)) 7
 \tempo 8 = 300
 c'2
 c'2
 c'2
 c'2 \MModEquation 4 #'() 16. #'( ) 0 #0
 c'2
 c'2 \break
 c'2
 c'2 % \MModEquationSTR 2 #'((6 . 4) (3 . 4)) 2 #'((3 . 4)) 7 #0
 \tempo 4 = 120 c'2
 c'2
 c'2
 c'2 % \MModEquationSTR 16. #'((44 . 4) (3 . 4)) 16. #'((2 . 3)) 3 #-5 \break
 \MModEquationBeginSTR 16. #'((44  4) (3 4)) 16. #'((2 3)) 7
 \tempo 8 = 300
 c'2
 c'2
 c'2
 c'2
 c'2
 c'2
 c'2
 c'2 \MModEquationSTR 16 #'((12 34)(5 6)) 4 #'() 0 #0
 c'2
 c'2  \break
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
