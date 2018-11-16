/*Variabel Dinamik*/
:- dynamic(health/1).
:- dynamic(armor/1).
:- dynamic(currLoc/2). %(x, y)
:- dynamic(inventory/1).
:- dynamic(equip/1).
:- dynamic(objLoc/3). %(nama_object, x, y)
:- dynamic(enemyLoc/3). %(nama_enemy, x, y)
:- dynamic(name/1).
:- dynamic(deadzone/2). %(x, y)

/*Variabel Statik*/

health(100). 
armor(none).
currLoc(1,1).
/*inventory(none). -- inventory kosong*/
inventory(pisang).
equip(none).
enemy(joshua).

/*default object*/
obj(weapon, kulitPisang).
obj(ammo, pisang).
obj(medicine, ekado).
obj(armor, jahim).

/*default lokasi object*/
objLoc(kulitPisang, 3, 4).
objLoc(pisang, 8, 9).
objLoc(ekado, 1, 4).
objLoc(jahim, 6, 8).

/*default peta*/
loc(1,1,'hutan').
loc(1,2,'hutan').
loc(2,1,'hutan').
loc(2,2,'kbl').

/*default deadzone*/
deadzone(9,1).

/*default deadzone*/
enemyLoc(joshua, 4, 3).

/*Rules*/

start :-
	write('UNIX INVANSION'), nl,
	write('Masukkan Nama (dimulai huruf kecil): '),
	read(X),
	asserta(name(X)),
	write('Instruksi permainan'), nl,
	do(help),
	repeat,
		write('>> '),
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
do(map) :- 
	write('Keterangan:'), nl,
	write('>> P: Posisi '), name(X), write(X), write(' sekarang'), nl,
	write('>> E: Enemy'), nl,
	write('>> O: Ammo'), nl,
	write('>> A: Armor'), nl,
	write('>> M: Medicine'), nl,
	write('>> W: weapon'), nl,
	write('>> X: Deadzone'), nl, nl,
	printmap(0,0),!.

do(n) :- north, !.
do(s) :- south, !.
do(w) :- west, !.
do(e) :- east, !.
do(drop(X)) :- drop(X), !.

/*edit do di bawah sesuai kebutuhan*/
do(look) :-	write('look'), nl, !.
do(take) :-	write('take'), nl, !.
do(drop) :-	write('drop'), nl, !.
do(use) :-	write('use'), nl, !.
do(attack) :-	write('attack'), nl, !.
do(status) :-	write('status'), nl, !.
do(save) :-	write('save'), nl, !.
do(load) :-	write('load'), nl, !.
do(_) :- write('Invalid Input'), nl, !.

/*PRINT MAP*/

printmap(11,11) :- write('X '), nl, !.
printmap(X,11) :- write('X '), nl, X1 is X+1, printmap(X1,0), !.
printmap(11,Y) :- write('X '), Y1 is Y+1, printmap(11,Y1), !.
printmap(0,Y) :- write('X '), Y1 is Y+1, printmap(0,Y1), !.
printmap(X,0) :- write('X '), printmap(X,1), !.
printmap(X,Y) :- currLoc(X,Y), !,  write('P '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(ammo, A), !,  write('O '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(armor, A), !,  write('A '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(medicine, A), !,  write('M '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(weapon, A), !,  write('W '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- enemyLoc(_,X,Y), !,  write('E '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- deadzone(X,Y), !,  write('X '), Y1 is Y+1, printmap(X,Y1), !.
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

drop(X) :- \+inventory(X), !, write('Tidak ada barang '), write(X), write(' di inventory'), nl, !.
drop(X) :- inventory(X), retract(inventory(X)), currLoc(A,B), asserta(objLoc(X, A, B)), !.