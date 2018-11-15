/*Variabel Dinamik*/
:- dynamic(health/1).
:- dynamic(armor/1).
:- dynamic(currLoc/2).
:- dynamic(invetory/1).
:- dynamic(equip/1).
:- dynamic(objLoc/3).
:- dynamic(enemyLoc/3).
:- dynamic(name/1).
:- dynamic(deadzone/2).

/*Variabel Statik*/

health(100).
armor(none).
currLoc(1,1).
inventory(none).
equip(none).

/*default object*/
obj(weapon, kulitPisang).
obj(ammo, pisang).
obj(medicine, ekado).
obj(armor, jahim).

/*default peta*/
loc(1,1,'hutan').
loc(1,2,'hutan').
loc(2,1,'hutan').
loc(2,2,'kbl').

/*Rules*/

start :-
	write('UNIX INVANSION'), nl,
	write('Masukkan Nama (dimulai huruf kecil): '),
	read(X),
	asserta(name(X)),
	write('Instruksi permainan'), nl,
	do(help),
	repeat,
		write('> '),
		read(Input),
		do(Input),nl,
		end(Input).

do(help) :- 
	name(X),
	write(X), nl,
	write('help'), nl,
	write('quit'), nl,
	write('look'), nl,
	write('map'), nl,
	write('n'), nl,
	write('s'), nl,
	write('e'), nl,
	write('w'), nl,
	write('take'), nl,
	write('drop'), nl,
	write('use'), nl,
	write('attack'), nl,
	write('status'), nl,
	write('save'), nl,
	write('load'), nl, !.

do(quit) :- write('end game'), nl, !.
do(map) :- printmap(0,0),!.
do(n) :- north, !.
do(s) :- south, !.
do(w) :- west, !.
do(e) :- east, !.

/*PRINT MAP*/

printmap(11,11) :- write('X '), nl, !.
printmap(X,11) :- write('X '), nl, X1 is X+1, printmap(X1,0), !.
printmap(11,Y) :- write('X '), Y1 is Y+1, printmap(11,Y1), !.
printmap(0,Y) :- write('X '), Y1 is Y+1, printmap(0,Y1), !.
printmap(X,0) :- write('X '), printmap(X,1), !.
printmap(X,Y) :- currLoc(X,Y), !,  write('P '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- write('_ '), Y1 is Y+1, printmap(X,Y1), !.

/*MOVEMENT*/

north :- currLoc(X,Y), X == 1, !, write('di paling atas'), nl, !.
north :- currLoc(X,Y), X1 is X-1, retract(currLoc(X,Y)), asserta(currLoc(X1,Y)), !.

south :- currLoc(X,Y), X == 10, !, write('di paling bawah'), nl, !.
south :- currLoc(X,Y), X1 is X+1, retract(currLoc(X,Y)), asserta(currLoc(X1,Y)), !.

west :- currLoc(X,Y), Y == 1, !, write('di paling kiri'), nl, !.
west :- currLoc(X,Y), Y1 is Y-1, retract(currLoc(X,Y)), asserta(currLoc(X,Y1)), !.

east :- currLoc(X,Y), Y == 10, !, write('di paling kanan'), nl, !.
east :- currLoc(X,Y), Y1 is Y+1, retract(currLoc(X,Y)), asserta(currLoc(X,Y1)), !.

/*END CONDITION*/
end(quit) :- halt, !.