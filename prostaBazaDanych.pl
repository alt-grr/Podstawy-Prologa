:-dynamic komputer/5.

wykPrg:-
   write('1 - biezacy stan bazy danych'), nl,
   write('2 - dopisanie nowego komputera'), nl,
   write('3 - usuniecie komputera'), nl,
   write('4 - obliczenie sredniej ceny'), nl,
   write('5 - odczyt z pliku'), nl,
   write('6 - zapisanie bazy w pliku'), nl,
   write('7 - wypisz wg nazwy procesora'), nl,
   write('8 - wypisz o cenie niższej niz zadana'), nl,
   write('0 - koniec programu'), nl, nl,
   read(I),
   I > 0,
   opcja(I),
   wykPrg.
wykPrg.

opcja(1) :- wyswietl.

opcja(2) :- write('Nazwa procesora:'), read(NazwaProcesora),
            write('Zegar:'), read(Zegar),
            write('HDD:'), read(HDD),
            write('RAM:'), read(RAM),
            write('Cena:'), read(Cena), nl,
            assert(komputer(NazwaProcesora, Zegar, HDD, RAM, Cena)).

opcja(3) :- write('Podaj nazwę procesora:'), read(NazwaProcesora),
            write('Podaj cenę:'), read(Cena),
            retract(komputer(NazwaProcesora,_,_,_,Cena)),! ;
            write('Brak takiego komputera.').

opcja(4) :- sredniaCena.

opcja(5) :- write('Podaj nazwe pliku:'), read(Nazwa),
            exists_file(Nazwa), !, consult(Nazwa);
            write('Brak pliku o podanej nazwie'), nl.

opcja(6) :- write('Podaj nazwe pliku:'), read(Nazwa),
            open(Nazwa, write, X), zapis(X), close(X).

opcja(7) :- write('Podaj nazwę procesora:'), read(NazwaProcesora),
			findall([NazwaProcesora, Zegar, HDD, RAM, Cena], komputer(NazwaProcesora, Zegar, HDD, RAM, Cena), Lista),
			suma2(Lista, LiczbaKomputerow),
			write('Znaleziono trafień:'),
			write(LiczbaKomputerow), nl,
			write(Lista), nl


			.

opcja(8) :- write('Podaj cenę:'), read(PodanaCena),
			findall([NazwaProcesora, Zegar, HDD, RAM, Cena], (komputer(NazwaProcesora, Zegar, HDD, RAM, Cena), Cena < PodanaCena), Lista),
			suma2(Lista, LiczbaKomputerow),
			write('Znaleziono trafień:'),
			write(LiczbaKomputerow), nl,
			write(Lista), nl


			.

opcja(_) :- write('Zly numer opcji'), nl.

wyswietl :- write('Elementy bazy:'), nl,
            komputer(NazwaProcesora, Zegar, HDD, RAM, Cena),
            write(NazwaProcesora), write(' '), write(Zegar), write(' '),
            write(HDD), write(' '), write(RAM), write(' '), write(Cena), nl, fail.
wyswietl :- nl.

sredniaCena :- findall(Cena, komputer(_,_,_,_,Cena), Lista),
              suma(Lista, Suma, LiczbaKomputerow),
              SredniaCena is Suma / LiczbaKomputerow,
              write('Srednia cena:'), write(SredniaCena), nl, nl.

zapis(X) :- komputer(NazwaProcesora, Zegar, HDD, RAM, Cena),
            write(X, 'komputer('),
            write(X, '\''),
            write(X, NazwaProcesora),
            write(X, '\''),
            write(X, ','),
            write(X, Zegar), write(X, ','),
            write(X, HDD), write(X, ','),
            write(X, RAM), write(X, ','),
            write(X, Cena),
            write(X, ').'), nl(X), fail.
zapis(_) :- nl.

suma([],0,0).
suma([G|Og], Suma, N) :- suma(Og, S1, N1),
                         Suma is G + S1,
                         N is N1+1.

suma2([],0).
suma2([G|Og], N) :- suma2(Og, N1),
                         N is N1+1.
