%opis grafu
gallery(a1,a3).
gallery(a1,a2).
gallery(a2,a3).
gallery(a2,a4).
gallery(a3,a5).
gallery(a4,a5).
gallery(a5,a6).
gallery(a5,a7).
gallery(a6,a11).
gallery(a6,a8).
gallery(a7,a9).
gallery(a7,a10).
gallery(a8,a9).
gallery(a8,a12).
gallery(a10,a12).
gallery(a11,a9).
gallery(a11,a10).
gallery(a11,a13).
gallery(a12,a15).
gallery(a7,a15).
gallery(a13,a14).
gallery(a13,a15).
gallery(a14,a15).

% graf nieskierowany
neighborroom(X, Y) :- gallery(X, Y).
neighborroom(X, Y) :- gallery(Y, X).

%lista węzłów zakazanych
avoid([a8,a2]).
go(Here,There) :- route(Here, There,[Here]).

%rekurencyjne poszukiwanie drogi
route(There,There,VisitedRooms) :-
	list_member(a10,VisitedRooms), pisz(VisitedRooms), nl.
route(Room,Way_out,VisitedRooms) :-
	neighborroom(Room,NextRoom),
	avoid(DangerousRooms),
	\+ list_member(NextRoom,DangerousRooms),
	\+ list_member(NextRoom,VisitedRooms),
	route(NextRoom,Way_out,[NextRoom|VisitedRooms]).

%sprawdzenie, czy element występuje w liście
list_member(X,[X|_]).
list_member(X,[_|H]) :- list_member(X,H).

pisz([]).
pisz([G|Og]):-
	pisz(Og),nl,write(G).
