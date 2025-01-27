\version "2.24.4"
\pointAndClickOff
%% "suppressWarning" function comes from:
%% http://lsr.di.unimi.it/LSR/Item?id=552

% Warnings may be suppressed using 'ly:expect-warning'
% Or use the here defined 'suppressWarning'-function, working since 2.20.

suppressWarning =
#(define-void-function (amount message)(number? string?)
   (for-each
    (lambda (warning)
      (ly:expect-warning message))
    (iota amount 1 1)))

\suppressWarning 3 "strange time signature found"

incompleteTupletBracket =  {
  \once \override Voice.TupletBracket.edge-height = #'(0.7 . 0)
  \once \override Voice.TupletBracket.bracket-visibility = ##t

}
incompleteSmallTupletBracket =  {
  \once \override Voice.TupletBracket.edge-height = #'(0.7 . 0)
  \once \override Voice.TupletBracket.bracket-visibility = ##t
  \once \override Voice.TupletNumber.X-offset =
  #(lambda (grob)
     (if (= UP (ly:grob-property grob 'direction))
         2.2
         1.2))

  \once \override Voice.TupletBracket.shorten-pair =
  #(lambda (grob)
     (if (= UP (ly:grob-property grob 'direction))
         '(-0.7 . 0.15)
         '(-0.3 . 0.8)))
  \once \override Voice.TupletBracket.X-positions =
  #(lambda (grob)
     (if (= UP (ly:grob-property grob 'direction))
         '(1.8 . 3)
         '(0.3 . 2.7)))
}


{
  \compoundMeter #'((2 4) (4 12))
  f'4 f'
  \tuplet 3/2 {g'8[ g' g']}
  \incompleteSmallTupletBracket
  \tuplet 3/2 {a'8 }|

  \time 4/20
  \incompleteTupletBracket
  \tuplet 5/4 {b'16[ b' b' b']} |
  \time 4/12
  \tuplet 3/2 {c''8[ g' e']}
  \incompleteSmallTupletBracket
  \tuplet 3/2 {c'8} |
  \tuplet 3/2 {c'8[ e' g']}
  \incompleteSmallTupletBracket
  \tuplet 3/2 {c''8} |
}


