/*PRINT MAP*/

printmap(11,11) :- currLoc(11,11), !,  write('P '), nl, !.
printmap(X,11) :- currLoc(X,11), !,  write('P '), X1 is X+1, nl, printmap(X1,0), !.
printmap(X,Y) :- currLoc(X,Y), !,  write('P '), Y1 is Y+1, printmap(X,Y1), !.
printmap(11,11) :- write('X '), nl, !.
printmap(X,11) :- write('X '), nl, X1 is X+1, printmap(X1,0), !.
printmap(11,Y) :- write('X '), Y1 is Y+1, printmap(11,Y1), !.
printmap(0,Y) :- write('X '), Y1 is Y+1, printmap(0,Y1),!.
printmap(X,0) :- write('X '), printmap(X,1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(weaponammo, A), !,  write('O '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(armor, A), !,  write('A '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(medicine, A), !,  write('M '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(weapon, A), !,  write('W '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(bag, A), !,  write('B '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- enemyLoc(_,X,Y), !,  write('E '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- deadzone(X,Y), !,  write('X '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- write('_ '), Y1 is Y+1, printmap(X,Y1), !.

/*Smaller Map*/
plusDeadzone:-
	disDeadzone(D),
	D1 is D-1,
	D2 is 11-D1,
	write('Peta Mengecil, Hati-hati dengan DEADZONE!!'),
	upzone(D1,D2),
	downzone(D1,D2),
	leftzone(D1,D2),
	rightzone(D1,D2),
	supply.

upzone(D1,D1):- objLoc(_,X,Y), X==D1,Y==D1,!, retractall(objLoc(_,X,Y)), asserta(deadzone(D1,D1)),!.
upzone(D1,D1):- asserta(deadzone(D1,D1)),!.
upzone(D1,D2):- objLoc(_,X,Y), X==D1,Y==D2,!, retractall(objLoc(_,X,Y)), asserta(deadzone(D1,D2)), Dnew is D2-1 , upzone(D1,Dnew),!.
upzone(D1,D2):- asserta(deadzone(D1,D2)), Dnew is D2-1 , upzone(D1,Dnew),!.

downzone(D2,D2):-objLoc(_,X,Y), X==D2,Y==D2,!, retractall(objLoc(_,X,Y)), asserta(deadzone(D2,D2)),!.
downzone(D2,D2):-asserta(deadzone(D2,D2)),!.
downzone(D1,D2):- objLoc(_,X,Y), X==D2,Y==D1,!, retractall(objLoc(_,X,Y)),asserta(deadzone(D2,D1)), Dnew is D1+1 , downzone(Dnew,D2),!.
downzone(D1,D2):- asserta(deadzone(D2,D1)), Dnew is D1+1 , downzone(Dnew,D2),!.

leftzone(D1,D1):- objLoc(_,X,Y), X==D1,Y==D1,!, retractall(objLoc(_,X,Y)), retract(deadzone(D1,D1)),!.
leftzone(D1,D1):-retract(deadzone(D1,D1)),!.
leftzone(D1,D2):- Dnew is D2-1, objLoc(_,X,Y), X==Dnew,Y==D1,!, retractall(objLoc(_,X,Y)),asserta(deadzone(Dnew,D1)) , leftzone(D1,Dnew),!.
leftzone(D1,D2):- Dnew is D2-1, asserta(deadzone(Dnew,D1)) , leftzone(D1,Dnew),!.

rightzone(D2,D2):- objLoc(_,X,Y), X==D2,Y==D2,!, retractall(objLoc(_,X,Y)),retract(deadzone(D2,D2)),!.
rightzone(D2,D2):-retract(deadzone(D2,D2)),!.
rightzone(D1,D2):- Dnew is D1+1, objLoc(_,X,Y), X==Dnew,Y==D2,!, retractall(objLoc(_,X,Y)),asserta(deadzone(Dnew,D2)) , rightzone(Dnew,D2),!.
rightzone(D1,D2):- Dnew is D1+1, asserta(deadzone(Dnew,D2)) , rightzone(Dnew,D2),!.



plusdisDeadzone(Count):- Count==26, disDeadzone(D) , D2 is D+1,retract(disDeadzone(D)),asserta(disDeadzone(D2)),plusDeadzone,!.
plusdisDeadzone(Count):- Count==21,disDeadzone(D) , D2 is D+1,retract(disDeadzone(D)),asserta(disDeadzone(D2)),plusDeadzone,!.
plusdisDeadzone(Count):- Count==15,disDeadzone(D) , D2 is D+1,retract(disDeadzone(D)),asserta(disDeadzone(D2)),plusDeadzone,!.
plusdisDeadzone(Count):- Count==8,disDeadzone(D) , D2 is D+1,retract(disDeadzone(D)),asserta(disDeadzone(D2)),plusDeadzone,!.
plusdisDeadzone(_):-!.

/*MOVEMENT*/

north :- currLoc(X,_), X == 0, !, write('Tidak bisa ke atas'), nl, minushp, !.
north :- currLoc(X,Y), X1 is X-1, deadzone(X1,Y), !,retract(currLoc(X,Y)), asserta(currLoc(X1,Y)), minushp, !.
north :- currLoc(X,Y), X1 is X-1, retract(currLoc(X,Y)), asserta(currLoc(X1,Y)), !.

south :- currLoc(X,_), X == 11, !, write('Tidak bisa ke bawah'), nl, minushp, !.
south :- currLoc(X,Y), X1 is X+1, deadzone(X1,Y), !, retract(currLoc(X,Y)), asserta(currLoc(X1,Y)), minushp, !.
south :- currLoc(X,Y), X1 is X+1, retract(currLoc(X,Y)), asserta(currLoc(X1,Y)), !.

west :- currLoc(_,Y), Y == 0, !, write('Tidak bisa ke kiri'), nl, minushp, !.
west :- currLoc(X,Y), Y1 is Y-1, deadzone(X,Y1), !, retract(currLoc(X,Y)), asserta(currLoc(X,Y1)), minushp, !.
west :- currLoc(X,Y), Y1 is Y-1, retract(currLoc(X,Y)), asserta(currLoc(X,Y1)), !.

east :- currLoc(_,Y), Y == 11, !, write('Tidak bisa ke kanan'), nl, minushp, !.
east :- currLoc(X,Y), Y1 is Y+1, deadzone(X,Y1), !, retract(currLoc(X,Y)), asserta(currLoc(X,Y1)), minushp, !.
east :- currLoc(X,Y), Y1 is Y+1, retract(currLoc(X,Y)), asserta(currLoc(X,Y1)), !.

minushp :- health(X),  X<10, !, retract(health(X)), asserta(health(0)), write('DANGER! DEADZONE!'), nl, !.
minushp :- health(X), retract(health(X)), X1 is X-10, asserta(health(X1)), write('DANGER! DEADZONE!'), nl, !.

/*Print Info*/

printinfo :-
	currLoc(X,Y),
	deadzone(X,Y),!,
	write('Deadzone mengurangi health!'), nl,
	printinfoW,
	printinfoE,
	printinfoN,
	printinfoS, !.

printinfo :-
	currLoc(X,Y),
	loc(X,Y,A),
	write('Saat ini Anda sedang ada di '),
	write(A), nl,
	printinfoW,
	printinfoE,
	printinfoN,
	printinfoS, !.

printinfoW :-
	currLoc(X,Y),
	Y1 is Y-1,
	deadzone(X,Y1),!,
	write('Sebelah baratmu adalah Deadzone hati-hati!'), nl, !.

printinfoW :-
	currLoc(_,Y),
	Y1 is Y-1,
	Y1 =:= -1, !,
	write('Sebelah baratmu adalah tembok, Ferguso'), nl, !.

printinfoW :-
	currLoc(X,Y),
	Y1 is Y-1,
	loc(X,Y1,A),
	write('Sebelah barat Anda adalah '),
	write(A), nl, !.

printinfoE :-
	currLoc(X,Y),
	Y1 is Y+1,
	deadzone(X,Y1),!,
	write('Sebelah timurmu adalah Deadzone hati-hati!'), nl, !.

printinfoE :-
	currLoc(_,Y),
	Y1 is Y+1,
	Y1 =:= 12,!,
	write('Sebelah timurmu adalah tembok, Ferguso'), nl, !.

printinfoE :-
	currLoc(X,Y),
	Y1 is Y+1,
	loc(X,Y1,A),
	write('Sebelah timur Anda adalah '),
	write(A), nl, !.

printinfoS :-
	currLoc(X,Y),
	X1 is X+1,
	deadzone(X1,Y),!,
	write('Sebelah selatanmu adalah Deadzone hati-hati!'), nl, !.

printinfoS :-
	currLoc(X,_),
	X1 is X+1,
	X1 =:= 12,!,
	write('Sebelah selatanmu adalah tembok, Ferguso'), nl, !.

printinfoS :-
	currLoc(X,Y),
	X1 is X+1,
	loc(X1,Y,A),
	write('Sebelah selatan Anda adalah '),
	write(A), nl, !.

printinfoN :-
	currLoc(X,Y),
	X1 is X-1,
	deadzone(X1,Y),!,
	write('Sebelah utaramu adalah Deadzone hati-hati!'), nl, !.

printinfoN :-
	currLoc(X,_),
	X1 is X-1,
	X1 =:= 0,!,
	write('Sebelah utaramu adalah tembok, Ferguso'), nl, !.

printinfoN :-
	currLoc(X,Y),
	X1 is X-1,
	loc(X1,Y,A),
	write('Sebelah utara Anda adalah '),
	write(A), nl, !.
