\version "2.24.4"

% freely modified from: https://lsr.di.unimi.it/LSR/Item?id=1168
% as well as http://lsr.di.unimi.it/LSR/Item?id=1023


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

\score {
  \layout {
    indent = 0
  }
  {
    c'2^\markup{\translate #'(-4 . 2) \box "A"}
    ^\markup {\translate #'(0 . 1.5) \tiny \bold "accel."} \accelArrow #5   c'2
    c'2 \after 2 \stopTextSpan c'2
    c'2 ^\markup {\translate #'(0 . 1.5) \tiny \bold "rit."}  \rallArrow #3   c'2
    c'2 \after 2 \stopTextSpan c'2 \bar "||"
  }
}

\score {
  \layout {
    indent = 0
    line-width = 50
  }
  {
    c'2^\markup{\translate #'(-4 . 2) \box "B"}
    ^\markup {\translate #'(0 . 1.5) \tiny \bold "accel."} \accelArrow #5 c'2
    c'2 c'2
    c'2^\markup {\translate #'(0 . 1.5) \teeny \bold "(accel.)"} \after 2 \stopTextSpan c'2
    c'2 ^\markup {\translate #'(0 . 1.5) \tiny \bold "rit."}  \rallArrow #2 c'2 \break
    c'2^\markup {\translate #'(0 . 1.5) \teeny \bold "(rit.)"} c'2
    c'2 \after 2 \stopTextSpan c'2 \bar "||"
  }
}

%^\markup{\translate #'(0 . 2) \bold "accel."}