\version "2.24.4"
\pointAndClickOff
qmp = #(make-dynamic-script
        (markup #:combine
                #:combine
                #:translate '(-0.85 . -0.1)
                #:normal-text (#:italic #:fontsize 0.75 "\"")
                #:dynamic "mp"
                #:translate '(3.25 . -0.1)
                #:normal-text (#:italic #:fontsize 0.75 "\"")))
qp = #(make-dynamic-script
       (markup #:combine
               #:combine
               #:translate '(-0.95 . -0.1)
               #:normal-text (#:italic #:fontsize 0.75 "\"")
               #:dynamic "p"
               #:translate '(1.35 . -0.1)
               #:normal-text (#:italic #:fontsize 0.75 "\"")))
qpp = #(make-dynamic-script
        (markup #:combine
                #:combine
                #:translate '(-0.95 . -0.1)
                #:normal-text (#:italic #:fontsize 0.75 "\"")
                #:dynamic "pp"
                #:translate '(2.75 . -0.1)
                #:normal-text (#:italic #:fontsize 0.75 "\"")))
qppp = #(make-dynamic-script
         (markup #:combine
                 #:combine
                 #:translate '(-0.95 . -0.1)
                 #:normal-text (#:italic #:fontsize 0.75 "\"")
                 #:dynamic "ppp"
                 #:translate '(4.25 . -0.1)
                 #:normal-text (#:italic #:fontsize 0.75 "\"")))

qmf = #(make-dynamic-script
        (markup #:combine
                #:combine
                #:translate '(-0.85 . 0)
                #:normal-text (#:italic #:fontsize 0.75 "\"")
                #:dynamic "mf"
                #:translate '(3.25 . 0)
                #:normal-text (#:italic #:fontsize 0.75 "\"")))
qf = #(make-dynamic-script
       (markup #:combine
               #:combine
               #:translate '(-0.75 . 0)
               #:normal-text (#:italic #:fontsize 0.75 "\"")
               #:dynamic "f"
               #:translate '(1.65 . 0)
               #:normal-text (#:italic #:fontsize 0.75 "\"")))
qff = #(make-dynamic-script
        (markup #:combine
                #:combine
                #:translate '(-0.75 . 0)
                #:normal-text (#:italic #:fontsize 0.75 "\"")
                #:dynamic "ff"
                #:translate '(2.75 . 0)
                #:normal-text (#:italic #:fontsize 0.75 "\"")))
qfff = #(make-dynamic-script
         (markup #:combine
                 #:combine
                 #:translate '(-0.75 . 0)
                 #:normal-text (#:italic #:fontsize 0.75 "\"")
                 #:dynamic "fff"
                 #:translate '(3.85 . 0)
                 #:normal-text (#:italic #:fontsize 0.75 "\"")))

{

  c'4\qppp
  c'4\qpp
  c'4\qp
  c'4\qmp

  c'4\qmf
  c'4\qf
  c'4\qff
  c'4\qfff

}

\layout {
  \context {
    \Score    proportionalNotationDuration = #(ly:make-moment 1/9)
  }
}