:- dynamic xpositive/2.
:- dynamic xnegative/2.
%1. Opis obiektów (ich cech charakterystycznych)

conveyance_is(kontenerowiec) :-
	it_is(things_transport),
	positive(has,containers),
	positive(has,slow_speed).

conveyance_is(liniowiec) :-
	it_is(people_transport),
	postive(has,people),
	postive(has,luxury_quarters).

conveyance_is(truck) :-
	it_is(road_transport),
	positive(has,tires),
	positive(has,trailer).

conveyance_is(train) :-
	it_is(rail_transport),
	positive(has,rails),
	positive(has,cars).

conveyance_is(boeing) :-
	it_is(first_class_transport),
	positive(has,catering),
	positive(has,flight_attendant).

conveyance_is(cesna) :-
	it_is(economic_class_transport),
	positive(has,low_prices),
	positive(has,small_capacity).


%2. Opis cech charakterystycznych dla klas obiektów
%====================
% Pierwszy poziom
%====================
it_is(water_transport) :-
	positive(does,swim).

it_is(land_transport) :-
	positive(does,drive).

it_is(air_transport) :-
	positive(has,wings),
	positive(does,fly).

%====================
% Drugi poziom
%====================
it_is(things_transport) :-
	it_is(water_transport),
	positive(has,containers).

it_is(people_transport) :-
	it_is(water_transport),
	positive(has,people).

it_is(rail_transport) :-
	it_is(land_transport),
	positive(has,track).

it_is(road_transport) :-
	it_is(land_transport),
	positive(has,tires).

it_is(first_class_transport) :-
	it_is(air_transport),
	positive(has,catering).

it_is(economic_class_transport) :-
	it_is(air_transport),
	negative(has,catering),
	positive(has,low_prices).


%3. Szukanie potwierdzenia cechy obiektu w dynamicznej bazie
positive(X,Y) :-xpositive(X,Y),!.
positive(X,Y) :-
not(xnegative(X,Y)) , ask(X,Y,yes).
negative(X,Y) :-xnegative(X,Y),!.
negative(X,Y) :-
not(xpositive(X,Y)) ,
ask(X,Y,no).

%4. Zadawanie pytań użytkownikowi
ask(X,Y,yes) :-
write(X), write(' it '),write(Y), write('\n'),
read(Reply),
sub_string(Reply,0,1,_,'y'),!,
remember(X,Y,yes).
ask(X,Y,no) :-
write(X), write(' it '),write(Y), write('\n'),
read(Reply),
sub_string(Reply,0,1,_, 'n'),!,
remember(X,Y,no).

%5. Zapamiętanie odpowiedzi w dynamicznej bazie
remember(X,Y,yes) :-
asserta(xpositive(X,Y)).
remember(X,Y,no) :-
asserta(xnegative(X,Y)).

%6. Uruchomienie programu
run :-
conveyance_is(X),!,
write('\nYour conveyance may be a(n) '),write(X),
nl,nl,clear_facts.
run :-
write('\nUnable to determine what'),
write('your conveyance is.\n\n'),clear_facts.

%7. Wyczyszczenie zawartości dynamicznej bazy
clear_facts :-
retract(xpositive(_,_)),fail.
clear_facts :-
retract(xnegative(_,_)),fail.
clear_facts :-
write('\n\nPlease press the space bar to exit\n').
