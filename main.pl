/*Included files */
:-include('variables.pl').
:-include('enemy.pl').
:-include('look.pl').
/*badur was here*/

/*Rules*/
start :-

	write('███    █▄  ███▄▄▄▄    ▄█  ▀████    ▐████▀       ▄█  ███▄▄▄▄    ▄█    █▄     ▄████████ ████████▄     ▄████████    ▄████████    ▄████████ '), nl,
	write('███    ███ ███▀▀▀██▄ ███    ███▌   ████▀       ███  ███▀▀▀██▄ ███    ███   ███    ███ ███   ▀███   ███    ███   ███    ███   ███    ███ '),nl,
	write('███    ███ ███   ███ ███▌    ███  ▐███         ███▌ ███   ███ ███    ███   ███    ███ ███    ███   ███    █▀    ███    ███   ███    █▀  '),nl,
	write('███    ███ ███   ███ ███▌    ▀███▄███▀         ███▌ ███   ███ ███    ███   ███    ███ ███    ███  ▄███▄▄▄      ▄███▄▄▄▄██▀   ███        '),nl,
	write('███    ███ ███   ███ ███▌    ████▀██▄          ███▌ ███   ███ ███    ███ ▀███████████ ███    ███ ▀▀███▀▀▀     ▀▀███▀▀▀▀▀   ▀███████████ '),nl,
	write('███    ███ ███   ███ ███    ▐███  ▀███         ███  ███   ███ ███    ███   ███    ███ ███    ███   ███    █▄  ▀███████████          ███ '),nl,
	write('███    ███ ███   ███ ███   ▄███     ███▄       ███  ███   ███ ███    ███   ███    ███ ███   ▄███   ███    ███   ███    ███    ▄█    ███ '),nl,
	write('████████▀   ▀█   █▀  █▀   ████       ███▄      █▀    ▀█   █▀   ▀██████▀    ███    █▀  ████████▀    ██████████   ███    ███  ▄████████▀  '),nl
	,nl,nl,

	write('Masukkan Nama (dimulai huruf kecil): '),
	read(X),
	asserta(name(X)),
	write('Instruksi permainan'), nl,
	do(help),
	spawn,
	repeat,
		write('>> '), /* Menandakan input */
		read(Input), /*Meminta input dari usedr */

		do(Input),nl, /*Menjadlankan do(Input) */
		end(Input). /*apabila bernilai end(quit) maka program akan berakhir */

/* Daftar fungsi-fungsi do() yang SUDAH DIIMPLEMENTASI*/
do(help) :- showhelp, !.
do(quit) :- write('end game'), nl, !.
do(map) :- printLegend, !.
do(save) :-	savegame, !.
do(n) :- north, move_all_enemies,!.
do(s) :- south, move_all_enemies,!.
do(w) :- west, move_all_enemies,!.
do(e) :- east, move_all_enemies,!.
do(drop(X)) :- drop(X), move_all_enemies,!.

/* Fungsi yang BELUM di implementasikan (edit do di bawah sesuai kebutuhan)*/
do(look) :-	look_around, nl, !.
do(take(X)):- takes(X),move_all_enemies,!.
do(use(X)):- uses(X),move_all_enemies,!.
do(attack) :-	attack_enemy, move_all_enemies,!.
do(status) :- statuss,!.
do(load) :-	write('load'), nl, !.
do(_) :- write('Invalid Input'), nl, !.

savegame:-
	open('savefile.txt',write,Save),
	name(Nama_User),
	write(Save,name(Nama_User)),write(Save,'.'),nl(Save),
	armor(Nama_Arm,Shield),
	write(Save,armor(Nama_Arm,Shield)),write(Save,'.'),nl(Save),
	health(Heal),
	write(Save,health(Heal)),write(Save,'.'),nl(Save),
	equip(Eq),
	write(Save,equip(Eq)),write(Save,'.'),nl(Save),
	currLoc(X,Y),
	write(Save,currLoc(X,Y)),write(Save,'.'),nl(Save),
	ammo(Amunisi),
	write(Save,ammo(Amunisi)),write(Save,'.'),nl(Save),
	forall(inventory(Invent),(write(Save,inventory(Invent)),write(Save,'.'),nl(Save))),
	forall(objLoc(Nama_Object,OX,OY),(write(Save,objLoc(Nama_Object,OX,OY)),write(Save,'.'),nl(Save))),
	forall(enemyLoc(Nama_Enemy,EX,EY),(write(Save,enemyLoc(Nama_Enemy,EX,EY)),write(Save,'.'),nl(Save))),
	forall(deadzone(Dx,Dy),(write(Save,deadzone(Dx,Dy)),write(Save,'.'),nl(Save))),
	close(Save).

showhelp :-
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

printLegend :-
	write('Keterangan:'), nl,
	write('>> P: Posisi '), name(X), write(X), write(' sekarang'), nl,
	write('>> E: Enemy'), nl,
	write('>> O: Ammo'), nl,
	write('>> A: Armor'), nl,
	write('>> M: Medicine'), nl,
	write('>> W: weapon'), nl,
	write('>> X: Deadzone'), nl, nl,
	printmap(0,0),!.


/*PRINT MAP*/
is_loc_valid(X,Y) :- X<11, Y<11, X>0, Y>0, forall(deadzone(X1,Y1), X =:= X1), forall(deadzone(X2,Y2), Y2 =:= Y), !.

printmap(11,11) :- write('X '), nl, !.
printmap(X,11) :- write('X '), nl, X1 is X+1, printmap(X1,0), !.
printmap(11,Y) :- write('X '), Y1 is Y+1, printmap(11,Y1), !.
printmap(0,Y) :- write('X '), Y1 is Y+1, printmap(0,Y1),!.
printmap(X,0) :- write('X '), printmap(X,1), !.
printmap(X,Y) :- currLoc(X,Y), !,  write('P '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(weapon_ammo, A), !,  write('O '), Y1 is Y+1, printmap(X,Y1), !.
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

/* Status*/
statuss :-
	health(Y),
	write('Health : '), write(Y),nl,
	armor(Z,N),
	write('Armor : '), write(N),nl,
	equip(W),
	write('Weapon : '), write(W),nl,
	ammo(A),
	write('Ammo : '), write(A),nl,
	write('List Inventory : '),
	findall(I,inventory(I),Listinvent), nl,
	printlist(Listinvent),nl,!.

printlist([]).
printlist([H|T]) :- write(H), nl, printlist(T),!.


equip_armor(jahim) :- newarmor(jahim,N), armor(A,X), X=0, retract(armor(A,X)),asserta(armor(jahim,N)), write('Armor : '),write(N),nl,write('Mantap bosque'),nl,!.
equip_armor(jahim) :- newarmor(jahim,N), armor(jamal,X), X=50, currLoc(P,Q), asserta(objLoc(A, P, Q)), retract(armor(A,X)),asserta(armor(jahim,N)), write('Armor : '),write(N),nl,write('Mantap bosque'),nl,!.
equip_armor(jahim) :- newarmor(jahim,N), armor(jamal,X), X<50, retract(armor(A,X)),asserta(armor(jahim,N)), write('Armor : '),write(N),nl,write('Mantap bosque'),nl,!.
equip_armor(jahim) :- newarmor(jahim,N), armor(sweater,X), X=25, currLoc(P,Q), asserta(objLoc(A, P, Q)), retract(armor(A,X)),asserta(armor(jahim,N)), write('Armor : '),write(N),nl,write('Mantap bosque'),nl,!.
equip_armor(jahim) :- newarmor(jahim,N), armor(sweater,X), X<25, retract(armor(A,X)),asserta(armor(jahim,N)), write('Armor : '),write(N),nl,write('Mantap bosque'),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(A,X), X=0, retract(armor(A,X)),asserta(armor(jamal,N)), write('Armor : '),write(N),nl,write('Not bad bosque'),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(jahim,X), X=100, currLoc(P,Q), asserta(objLoc(A, P, Q)), retract(armor(A,X)),asserta(armor(jamal,N)), write('Armor : '),write(N),nl,write('Not bad bosque'),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(jahim,X), X<100, retract(armor(A,X)),asserta(armor(jamal,N)), write('Armor : '),write(N),nl,write('Not bad bosque'),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(sweater,X), X=25, currLoc(P,Q), asserta(objLoc(A, P, Q)), retract(armor(A,X)),asserta(armor(jamal,N)), write('Armor : '),write(N),nl,write('Not bad bosque'),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(sweater,X), X<25, retract(armor(A,X)),asserta(armor(jamal,N)), write('Armor : '),write(N),nl,write('Not bad bosque'),nl,!.
equip_armor(sweater) :- newarmor(sweater,N), armor(A,X), X=0, retract(armor(A,X)),asserta(armor(sweater,N)), write('Armor : '),write(N),nl,write('Rapih bet bosque'),nl,!.
equip_armor(sweater) :- newarmor(sweater,N), armor(jahim,X), X=100, currLoc(P,Q), asserta(objLoc(A, P, Q)), retract(armor(A,X)),asserta(armor(sweater,N)), write('Armor : '),write(N),nl,write('Rapih bet bosque'),nl,!.
equip_armor(sweater) :- newarmor(sweater,N), armor(jahim,X), X<100, retract(armor(A,X)),asserta(armor(sweater,N)), write('Armor : '),write(N),nl,write('Rapih bet bosque'),nl,!.
equip_armor(sweater) :- newarmor(sweater,N), armor(jamal,X), X=50, currLoc(P,Q), asserta(objLoc(A, P, Q)), retract(armor(A,X)),asserta(armor(sweater,N)), write('Armor : '),write(N),nl,write('Rapih bet bosque'),nl,!.
equip_armor(sweater) :- newarmor(sweater,N), armor(jamal,X), X<25, retract(armor(A,X)),asserta(armor(sweater,N)), write('Armor : '),write(N),nl,write('Rapih bet bosque'),nl,!.


pakai_obat(crisbar) :- health(X), retract(health(X)),asserta(health(100)), write('Darahmu : '),write(100),nl,write('Full bosque'),nl,!.
pakai_obat(nasjep) :- health(X), X+50 > 100,retract(health(X)),asserta(health(100)), write('Darahmu : '),write(100),nl,write('Full bosque'),nl,!.
pakai_obat(nasjep) :- health(X), W is X+50,retract(health(X)),asserta(health(W)), write('Darahmu : '),write(W),nl,!.
pakai_obat(ekado) :- health(X) ,X+30 > 100,retract(health(X)),asserta(health(100)), write('Darahmu : '),write(100),nl,write('Full bosque'),nl,!.
pakai_obat(ekado) :- health(X) ,W is X+30,retract(health(X)),asserta(health(W)), write('Darahmu : '),write(W),nl,!.

equip_ammo(ammo) :- ammo(X), W is X+5, retract(ammo(X)), asserta(ammo(W)), write('Ammo terpakai'), nl, write('Sekarang jumlah ammo kamu adalah :'), write(W),nl,!.

equip_weapon(kunciC) :- equip(X), retract(equip(X)),asserta(equip(kunciC)), write('senjata yang dipakai : kunciC (Damage attack: 20)'),nl,!.
equip_weapon(batuRuby) :- equip(X), retract(equip(X)),asserta(equip(batuRuby)), write('senjata yang dipakai : batuRuby (Damage attack : 30)'),nl,!.
equip_weapon(ularPython) :- equip(X), retract(equip(X)),asserta(equip(ularPython)), write('senjata yang dipakai : ularPython (Damage attack : 40)'),nl,!.
equip_weapon(laptop) :- equip(X), retract(equip(X)),asserta(equip(laptop)), write('senjata yang dipakai : Laptop (Damage attack : 100 !!! Ngeri bosque)'),nl,!.

/* Take armor */
takes(X):-
	obj(armor,X),
	objLoc(X,Y,Z),
	currLoc(Y,Z),!,
	equip_armor(X),
	retract(objLoc(X,Y,Z)),
	write('item '), write(X), write(' diambil'), nl, !.

/* Take weapon */
	takes(X):-
	obj(weapon,X),
	objLoc(X,Y,Z),
	currLoc(Y,Z),!,
	asserta(inventory(X)),
	retract(objLoc(X,Y,Z)),
	write('item '), write(X),write(' diambil'), nl, write('kamu siap untuk bertempur!'),nl, !.

/* Take ammo & medicine */
takes(X):-
	obj(Jenis,X),
	objLoc(X,Y,Z),
	currLoc(Y,Z),!,
	asserta(inventory(X)),
	retract(objLoc(X,Y,Z)),
	write('item '), write(X),write(' diambil'), nl, !.

takes(X):-
	write(X), write(' tidak ada di sini'), nl.


/* Use medicine*/
uses(X) :-
	obj(medicine,X),
	inventory(X),
	pakai_obat(X),
	retract(inventory(X)),!.
/* Use Ammo */
uses(X) :-
	obj(weapon_ammo,X),
	inventory(X),
	equip_ammo(X),
	retract(inventory(X)),!.
/* Use weapon*/
uses(X) :-
	obj(weapon,X),
	inventory(X),
	equip(Y),
	Y == 'none',
	equip_weapon(X),
	retract(inventory(X)),!.

uses(X) :-
	obj(weapon,X),
	inventory(X),
	equip(Y),
	asserta(inventory(Y)),
	equip_weapon(X),
	retract(inventory(X)),!.
uses(X) :- write(X), write(' tidak bisa digunakan\n'), !.

/* Drop */

/* Drop dari inventory*/
drop(X) :- inventory(X),!, retract(inventory(X)), currLoc(A,B), asserta(objLoc(X, A, B)), write(X), write(' berhasil di drop'), nl,!.


/* Drop armor*/
drop(X) :- armor(X,N), newarmor(X,N), !, retract(armor(X,N)), currLoc(A,B), asserta(objLoc(X, A, B)), asserta(armor(none,0)), write(X), write(' berhasil di drop'), nl, !.
drop(X) :- armor(X,N),!, retract(armor(X,N)), asserta(armor(none,0)), write('armor sudah berkurang sehingga hilang dari peta'), nl, !.

/* Drop weapon*/
drop(X) :- equip(X), !, retract(equip(X)), currLoc(A,B), asserta(objLoc(X, A, B)), asserta(equip(none)),  write(X), write(' berhasil di drop'), nl,!.

/* Drop ammo*/
drop(ammo) :- ammo(X), newammo(ammo, X), !, retract(ammo(X)), currLoc(A,B), asserta(objLoc(X, A, B)), asserta(ammo(0)),  write(X), write('berhasil di drop'), nl,!.
drop(ammo) :- ammo(X),!, retract(ammo(X)), asserta(ammo(0)), write('ammmo sudah berubah sehingga hilang dari peta'), nl, !.

drop(X) :- write('Tidak ada barang '), write(X), write(' di inventory'), nl, !.

/*END CONDITION*/
end(quit) :- halt, !.

end_condition(_) :-
  hp(0),
  write('Anda telah terbunuh!, Permainan Selesai, Anda kalah.'),nl,!.

end_condition(_) :-
  totalenemy(0),
  write('Selamat! Anda menjadi pejuang yang berdiri terakhir, selamaaatt !!!.'),nl,!.
