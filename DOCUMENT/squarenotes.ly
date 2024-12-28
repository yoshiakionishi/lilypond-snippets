\version "2.24.4"

% See also: https://lsr.di.unimi.it/LSR/Item?id=516

squareHollowNoteheadDesign =
#(ly:make-stencil '(path 0.15 (moveto  0.05 0.425
                                       rlineto 1. 0
                                       rlineto 0 -0.875
                                       rlineto -1. 0
                                       closepath)
                         )
                  (cons -0.025 1.125)
                  (cons -1 1))

squareHollowNotehead =
#(define-music-function (note) (ly:music?)
   #{\once \override Voice.NoteHead.stencil =
     \squareHollowNoteheadDesign $note #})

squareHollowNoteheadOn =
#(define-music-function (note) (ly:music?)
   #{\override Voice.NoteHead.stencil =
     \squareHollowNoteheadDesign $note #})

squareHollowNoteheadOff = \revert Voice.NoteHead.stencil

squareFilledNoteheadDesign =
#(ly:make-stencil '(path 0.15 (moveto  0.05 0.425
                                       rlineto 1. 0
                                       rlineto 0 -0.875
                                       rlineto -1. 0
                                       closepath)
                         round
                         round
                         #t)
                  (cons -0.025 1.125)
                  (cons -1 1))


squareFilledNotehead =
#(define-music-function (note) (ly:music?)
   #{\once \override Voice.NoteHead.stencil =
     \squareFilledNoteheadDesign $note #})
squareFilledNoteheadOn =
#(define-music-function (note) (ly:music?)
   #{\override Voice.NoteHead.stencil =
     \squareFilledNoteheadDesign $note #})

squareFilledNoteheadOff = \revert Voice.NoteHead.stencil

{
  \squareHollowNotehead c'8
  \squareHollowNoteheadOn d' e' f'
  \squareHollowNoteheadOff
  \squareFilledNotehead c'8
  \squareFilledNoteheadOn d' e' f'
  \squareFilledNoteheadOff
  \squareHollowNotehead a''8
  \squareHollowNoteheadOn g'' f'' e''
  \squareHollowNoteheadOff
  \squareFilledNotehead a''8
  \squareFilledNoteheadOn g'' f'' e''
  \squareFilledNoteheadOff
}