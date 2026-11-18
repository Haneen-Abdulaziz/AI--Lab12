% ============================================================
%  ARTI 401 - Lab 10: Graphs
%  Task 1 (slides 26-27): find the path between cities
%
%  ?- travel('Dammam','Madinah',P).
%  P = ['Dammam', 'Qatif', 'Madinah'] ;
%  false.
%
%  ?- travel('Makkah','Riyadh',P).
%  P = ['Makkah', 'Madinah', 'Taif', 'Dammam', 'Riyadh'] ;
%  P = ['Makkah', 'Madinah', 'Tabuk', 'Taif', 'Dammam', 'Riyadh'] ;
%  P = ['Makkah', 'Riyadh'] ;
%  false.
% ============================================================

% The graph: connected(From, To) is one arrow in the figure.
connected('Makkah',  'Madinah').
connected('Makkah',  'Riyadh').
connected('Madinah', 'Makkah').
connected('Madinah', 'Taif').
connected('Madinah', 'Tabuk').
connected('Taif',    'Dammam').
connected('Taif',    'Tabuk').
connected('Tabuk',   'Taif').
connected('Riyadh',  'Dammam').
connected('Dammam',  'Qatif').
connected('Dammam',  'Riyadh').
connected('Qatif',   'Madinah').
connected('Qatif',   'Dammam').

% travel(Start, End, Path)
% Path is built backwards in Visited, so reverse it at the end.
travel(Start, End, Path) :-
    path(Start, End, [Start], RevPath),
    reverse(RevPath, Path).

% path(Current, End, Visited, Path)
% Take one arrow out of Current to a city not visited yet.
% If that city is the destination, stop; otherwise keep going from it.
path(Current, End, Visited, Path) :-
    connected(Current, Next),
    \+ member(Next, Visited),          % avoid going round in cycles
    (   Next == End
    ->  Path = [Next|Visited]
    ;   path(Next, End, [Next|Visited], Path)
    ).
