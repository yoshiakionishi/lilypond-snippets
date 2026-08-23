\version "2.26.0"

\pointAndClickOff


{
 <e' \harmonic
 \tweak NoteHead.stencil #ly:text-interface::print
 \tweak NoteHead.text
 \markup \musicglyph "noteheads.s2triangle" f>8-.-> ^\markup { \tiny "[tongue ram]" }
 <f' \harmonic
 \tweak NoteHead.stencil #ly:text-interface::print
 \tweak NoteHead.text
 \markup \musicglyph "noteheads.s2triangle" ges>8-.->
 <d' \harmonic
 \tweak NoteHead.stencil #ly:text-interface::print
 \tweak NoteHead.text
 \markup \musicglyph "noteheads.s2triangle" ees>8-.->
 <cis' \harmonic
 \tweak NoteHead.stencil #ly:text-interface::print
 \tweak NoteHead.text
 \markup \musicglyph "noteheads.s2triangle" d>8-.->
}



% The following is deprecated and is no longer functional. I hope to
% revisit this and improve upon it.
% tgrWithIndication =
% #(define-music-function (note1) (ly:music?)
%   (let* 	(
%           (p1 #{ #(ly:music-deep-copy note1) \harmonic #})
%           (p2 #{ \transpose c df, #(ly:music-property note1 'pitch)#})
%           (d1  (ly:music-property note1 'duration))
%           )
%    #{ < $p1
%       \single \override NoteHead.stencil = #ly:text-interface::print
%       \single \override NoteHead.text =
%       \markup \musicglyph "noteheads.s2triangle"
%       \single \override Stem.stencil =
%       $p2 > $d1 ^\markup {\override #'(font-size . -2) {[T.R.]} }
%    #}
%    ))
%
% tgr =
% #(define-music-function (note1) (ly:music?)
%   (let* 	(
%           (p1 #{ #(ly:music-deep-copy note1) \harmonic #})
%           (p2 #{ \transpose c df, #(ly:music-property note1 'pitch)#})
%           (d1  (ly:music-property note1 'duration))
%           )
%    #{ < $p1
%       \single \override NoteHead.stencil = #ly:text-interface::print
%       \single \override NoteHead.text =
%       \markup \musicglyph "noteheads.s2triangle"
%       \single \override Stem.stencil =
%       $p2 > $d1  #}
%    ))
%
% {
%  \language "english" \tgrWithIndication d'4-.->
%  \tgr cs'4-.-> \tgr ef'4-.->
% }
%
