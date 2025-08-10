\version "2.24.4"
\pointAndClickOff

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
       \hspace #(if (< (ly:duration-log noteone) 3) -4.15
                    (+ (* (ly:duration-dot-count noteone) -0.5) -4.5))
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
                             (number->string (cadr (cadr ratiotwo)))))
                     (number->string (car (cadr ratiotwo)))
                     )

                 (#:italic (#:fontsize -5 (#:musicglyph "space")))))))))
           ))
         )
      }
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
       \hspace #(if (< (ly:duration-log noteone) 3) -4.15
                    (+ (* (ly:duration-dot-count noteone) -0.5) -4.5))
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

{
 \time 2/4
 \tempo 4 = 60
 c'16
 ^\markup {\translate #'(0 . 10) " "}
 [ c'16 c'16 c'16 ]
 \tuplet 5/4 {c'16 [ c'16 c'16 c'16 c'16 ] }
 \MModEquation 16 #'((5)) 16 #'() #8 #0
 \tempo 4 = 75
 c'16 [ c'16 c'16 c'16 ]
 \tuplet 3/2 {c'8 [ c'8 c'8 ] }
 \override TupletNumber.text = #tuplet-number::calc-fraction-text
 \tuplet 5/4 {c'8 [ c'8 ] \tuplet 4/3 { c'8 [ c'8 c'8 c'8  ] }}
 \MModEquation 8 #'((4 3)(5 4)) 8 #'((3)) 8 #-3
 \revert TupletNumber.text
 \break
 \MModEquationBegin 8 #'((4 3)(5 4)) 8 #'((3)) #6.5
 \tuplet 3/2 {
  c'8
  ^\markup {\translate #'(0 . 10) " "}
  ^\markup
  {\fontsize #-1 \raise #0.25 \note {4} #1 "= 83.33"}
  [ c'8 c'8 ]
 }
 \tuplet 3/2 {
  c'8 c'8 c'8
  \MModEquation 4 #'() 4. #'() #6 #0
 }
 \time 6/8
 c'8 c'8 c'8 c'4.
 \bar "|."
}


