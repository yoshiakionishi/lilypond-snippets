\version "2.24.4"

%% Inspired by:
%% http://lsr.di.unimi.it/LSR/Item?id=796


noteheadless = {
  \once \override Voice.NoteHead.transparent = ##t
  \once \override Voice.NoteHead.no-ledgers = ##t
}

noteheadlessOn = {
  \override Voice.NoteHead.transparent = ##t
  \override Voice.NoteHead.no-ledgers = ##t
}
noteheadlessOff = {
  \revert Voice.NoteHead.transparent
  \revert Voice.NoteHead.no-ledgers
}


{
  c'4 \noteheadless c'8 d' d'4
  \noteheadlessOn e'16 f' c' b |
  \noteheadlessOff d' c' b a
}

