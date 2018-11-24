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
<<<<<<< HEAD
	write('Instruksi permainan'), nl,
	do(help),
	spawn,
=======
	write('Pilih Tingkat stress yang anda inginkan : '),nl,
	write('[1] Kentang'),nl,
	write('[2] Sparta Day 4'),nl,
	write('[3] Ferguso'),nl,
	write('Pilihan : '),
	read(L),nl,
	write('Instruksi permainan'), nl,
	do(help),
	spawn_player,
	spawn_level(L),nl, %Nanti ini diganti sama spawn_level(N) dimana N adalah integer 1 (gampang), 2(sedeng), 3(susah).
>>>>>>> 643b85903e1171484e41d649d9345169e957514a
	repeat,
		write('>> '), /* Menandakan input */
		read(Input),nl, /*Meminta input dari usedr */

		do(Input),nl, /*Menjadlankan do(Input) */
		end_condition,
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
do(attack) :-	write('attack'), nl, move_all_enemies,!.
do(status) :- statuss,!.
do(load) :-	loadgame, nl, !.
do(_) :- write('Invalid Input'), nl, !.

/*Kumpulan rule untuk save game*/
savegame:-
	open('savefile.txt',write,Save),
	name(Nama_User),
	write(Save,name(Nama_User)),write(Save,'.'),nl(Save),
	armor(Nama_Arm),
	write(Save,armor(Nama_Arm)),write(Save,'.'),nl(Save),
	health(Heal),
	write(Save,health(Heal)),write(Save,'.'),nl(Save),
	equip(Eq),
	write(Save,equip(Eq)),write(Save,'.'),nl(Save),
	currLoc(X,Y),
	write(Save,currLoc(X,Y)),write(Save,'.'),nl(Save),
	ammo(Nama,Amunisi),
	write(Save,ammo(Nama,Amunisi)),write(Save,'.'),nl(Save),
	totalenemy(Jumlah),
	write(Save,totalenemy(Jumlah)),write(Save,'.'),nl(Save),
	close(Save),
	findall(I,inventory(I),ListInvent),
	write_list_oneparam('savefile.txt',ListInvent,inventory),
	findall(Nama_Object,objLoc(Nama_Object,OX,OY),ListObj),
	findall(OX,objLoc(Nama_Object,OX,OY),ListObjX),
	findall(OY,objLoc(Nama_Object,OX,OY),ListObjY),
	write_list_threeparam('savefile.txt',ListObj,ListObjX,ListObjY,objLoc),
	findall(Nama_Enemy,enemyLoc(Nama_Enemy,EX,EY),ListEnemy),
	findall(EX,enemyLoc(Nama_Object,EX,EY),ListEnemyX),
	findall(EY,enemyLoc(Nama_Object,EX,EY),ListEnemyY),
	write_list_threeparam('savefile.txt',ListEnemy,ListEnemyX,ListEnemyY,enemyLoc),
	findall(Dx,deadzone(Dx,Dy),ListDzoneX),
	findall(Dy,deadzone(Dx,Dy),ListDzoneY),
	write_list_twoparam('savefile.txt',ListDzoneX,ListDzoneY,deadzone).


	/*forall(inventory(Invent),(write(Save,inventory(Invent)),write(Save,'.'),nl(Save))),*/
	/*forall(objLoc(Nama_Object,OX,OY),(write(Save,objLoc(Nama_Object,OX,OY)),write(Save,'.'),nl(Save))),
	forall(enemyLoc(Nama_Enemy,EX,EY),(write(Save,enemyLoc(Nama_Enemy,EX,EY)),write(Save,'.'),nl(Save))),
	forall(deadzone(Dx,Dy),(write(Save,deadzone(Dx,Dy)),write(Save,'.'),nl(Save))),
	*/

/*Bagian rekursif untuk save game*/
writeData_One(_,[],Name) :- !.
writeData_One(S,[X1|Tail],Name) :-
	write(S,Name),
	write(S,'('),
	write(S,X1),
	write(S,')'),
	write(S,'.'),
	nl(S),
	writeData_One(S,Tail,Name).

write_list_oneparam(NamaFile,L,Name) :-
	open(NamaFile,append,S),
	repeat,
	writeData_One(S,L,Name),
	close(S).

writeData_three(_,[],[],[],Name) :- !.
writeData_three(S,[X1|Tail1],[X2|Tail2],[X3|Tail3],Name) :-
	write(S,Name),
	write(S,'('),
	write(S,(X1,X2,X3)),
	write(S,')'),
	write(S,'.'),
	nl(S),
	writeData_three(S,Tail1,Tail2,Tail3,Name).

write_list_threeparam(NamaFile,L1,L2,L3,Name) :-
	open(NamaFile,append,S),
	repeat,
	writeData_three(S,L1,L2,L3,Name),
	close(S).

writeData_two(_,[],[],Name) :- !.
writeData_two(S,[X1|Tail1],[X2|Tail2],Name) :-
	write(S,Name),
	write(S,'('),
	write(S,(X1,X2)),
	write(S,')'),
	write(S,'.'),
	nl(S),
	writeData_two(S,Tail1,Tail2,Name).

write_list_twoparam(NamaFile,L1,L2,Name) :-
	open(NamaFile,append,S),
	repeat,
	writeData_two(S,L1,L2,Name),
	close(S).

/*Bagian Load Game*/
loadgame:-
	health(H),
	armor(A),
	currLoc(Px,Py),
	equip(Eq),
	name(N),
	ammo(Nammo,Mag),
	totalenemy(E),
	retractall(health(H)),
	retractall(armor(A)),
	retractall(currLoc(Px,Py)),
	retractall(equip(Eq)),
	retractall(name(N)),
	retractall(ammo(Nammo,Mag)),
	retractall(totalenemy(E)),
	remove_all_obj,
	remove_all_deadzone,
	remove_all_invent,
	remove_all_enemies,
	open('savefile.txt',read,Load),
	load_all(Load),
	close(Load).

/*Rule pendukung untuk load game*/
remove_all_obj :-
	objLoc(_,_,_),retractall(objLoc(_,_,_)),!.
remove_all_obj :- !.

remove_all_deadzone :-
	deadzone(_,_),retractall(deadzone(_,_)),!.
remove_all_deadzone:-!.

remove_all_invent :-
	inventory(_),retractall(inventory(_)),!.
remove_all_invent :-!.

load_all(Load):-
	repeat,
		read(Load,L),
		asserta(L),
		at_end_of_stream(Load).

showhelp :-
	write('Nama Anda: '), name(X),
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

/*Random spawn player*/
spawn_player:-
	currLoc(X,Y),
	set_seed(1), randomize,
	random(1,11,Xnew),
	random(1,11,Ynew),
	retract(currLoc(X,Y)),
	asserta(currLoc(Xnew,Ynew)),!.

/*PRINT MAP*/

printmap(X,Y) :- currLoc(X,Y), !,  write('P '), Y1 is Y+1, printmap(X,Y1), !.
printmap(11,11) :- write('X '), nl, !.
printmap(X,11) :- write('X '), nl, X1 is X+1, printmap(X1,0), !.
printmap(11,Y) :- write('X '), Y1 is Y+1, printmap(11,Y1), !.
printmap(0,Y) :- write('X '), Y1 is Y+1, printmap(0,Y1),!.
printmap(X,0) :- write('X '), printmap(X,1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(weapon_ammo, A), !,  write('O '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(armor, A), !,  write('A '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(medicine, A), !,  write('M '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- objLoc(A,X,Y), obj(weapon, A), !,  write('W '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- enemyLoc(_,X,Y), !,  write('E '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- deadzone(X,Y), !,  write('X '), Y1 is Y+1, printmap(X,Y1), !.
printmap(X,Y) :- write('_ '), Y1 is Y+1, printmap(X,Y1), !.

/*MOVEMENT*/

north :- currLoc(X,Y), X == 0, !, write('di paling atas'), nl, minushp, !.
north :- currLoc(X,Y), X1 is X-1, deadzone(X1,Y), !,retract(currLoc(X,Y)), asserta(currLoc(X1,Y)), minushp, !.
north :- currLoc(X,Y), X1 is X-1, retract(currLoc(X,Y)), asserta(currLoc(X1,Y)), !.

south :- currLoc(X,Y), X == 11, !, write('di paling bawah'), nl, minushp, !.
south :- currLoc(X,Y), X1 is X+1, deadzone(X1,Y), !, retract(currLoc(X,Y)), asserta(currLoc(X1,Y)), minushp, !.
south :- currLoc(X,Y), X1 is X+1, retract(currLoc(X,Y)), asserta(currLoc(X1,Y)), !.

west :- currLoc(X,Y), Y == 0, !, write('di paling kiri'), nl, minushp, !.
west :- currLoc(X,Y), Y1 is Y-1, deadzone(X,Y1), !, retract(currLoc(X,Y)), asserta(currLoc(X,Y1)), minushp, !.
west :- currLoc(X,Y), Y1 is Y-1, retract(currLoc(X,Y)), asserta(currLoc(X,Y1)), !.

east :- currLoc(X,Y), Y == 11, !, write('di paling kanan'), nl, minushp, !.
east :- currLoc(X,Y), Y1 is Y+1, deadzone(X,Y1), !, retract(currLoc(X,Y)), asserta(currLoc(X,Y1)), minushp, !.
east :- currLoc(X,Y), Y1 is Y+1, retract(currLoc(X,Y)), asserta(currLoc(X,Y1)), !.

minushp :- health(X),  X<10, !, retract(health(X)), asserta(health(0)), write('DANGER! DEADZONE!'), nl, !.
minushp :- health(X), retract(health(X)), X1 is X-10, asserta(health(X1)), write('DANGER! DEADZONE!'), nl, !.

/* Status*/
statuss :-
	name(X),
	write('Nama : '), write(X),nl,
	health(Y),
	write('Health : '), write(Y),nl,
	armor(N),
	write('Armor : '), write(N),nl,
	equip(W),
	write('Weapon : '), write(W),nl,
	ammo(Nama,A),
	write('Ammo : '), write(A),nl,
	write('List Inventory : '),
	findall(I,inventory(I),Listinvent), nl,
	printlist(Listinvent),nl,!.

printlist([]).
printlist([H|T]) :- write(H), nl, printlist(T),!.


/* equip_armor(jahim) :- newarmor(jahim,N), armor(A,X), X=0, retract(armor(A,X)),asserta(armor(jahim,N)), write('Armor : '),write(N),nl,write('Mantap bosque'),nl,!.
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
equip_armor(sweater) :- newarmor(sweater,N), armor(jamal,X), X<25, retract(armor(A,X)),asserta(armor(sweater,N)), write('Armor : '),write(N),nl,write('Rapih bet bosque'),nl,!. */

equip_armor(jahim) :- newarmor(jahim,N), armor(X), retract(armor(X)), asserta(armor(N)), write('Armor : '),write(N),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(X), X+N > 100,retract(armor(X)),asserta(armor(100)), write('Armor : '),write(100),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(X), W is X+N ,retract(armor(X)),asserta(armor(W)), write('Armor : '),write(W),nl,!.
equip_armor(sweater) :- newarmor(sweater,N), armor(X), X+N > 100,retract(armor(X)),asserta(armor(100)), write('Armor : '),write(100),nl,!.
equip_armor(sweater) :- newarmor(sweater,N), armor(X), W is X+N ,retract(armor(X)),asserta(armor(W)), write('Armor : '),write(W),nl,!.

pakai_obat(crisbar) :- health(X), retract(health(X)),asserta(health(100)), write('Darahmu : '),write(100),nl,write('Full bosque'),nl,!.
pakai_obat(nasjep) :- health(X), X+50 > 100,retract(health(X)),asserta(health(100)), write('Darahmu : '),write(100),nl,write('Full bosque'),nl,!.
pakai_obat(nasjep) :- health(X), W is X+50,retract(health(X)),asserta(health(W)), write('Darahmu : '),write(W),nl,!.
pakai_obat(ekado) :- health(X) ,X+30 > 100,retract(health(X)),asserta(health(100)), write('Darahmu : '),write(100),nl,write('Full bosque'),nl,!.
pakai_obat(ekado) :- health(X) ,W is X+30,retract(health(X)),asserta(health(W)), write('Darahmu : '),write(W),nl,!.

equip_ammo(ammoRuby) :- ammo(A,X), A == 'ammoRuby', W is X+5, retract(ammo(X)), asserta(ammo(W)), write('Ammo terpakai'), nl, write('Sekarang jumlah ammo kamu adalah :'), write(W),nl,!.

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

/* Supply Drop */
supply :- 
	disDeadzone(A),
	A1 is 11-A,
	random(A,A1,X),
	random(A,A1,Y),
	asserta(objLoc(ekado,X,Y)),
	random(A,A1,X),
	random(A,A1,Y),
	asserta(objLoc(jahim,X,Y)),
	random(A,A1,X),
	random(A,A1,Y),
	asserta(objLoc(kunciC,X,Y)),
	random(A,A1,X),
	random(A,A1,Y),
	asserta(objLoc(ammoC,X,Y)), !,


/*END CONDITION*/
end(quit) :- halt, !.

end_condition :-
  health(0), !,
  write('Anda telah terbunuh!, Permainan Selesai, Anda kalah.'),nl, end(quit), !.
/*
end_condition :-
  totalenemy(0), !,
  write('Selamat! Anda menjadi pejuang yang berdiri terakhir, selamaaatt !!!.'),nl, end(quit), !.
*/
 end_condition.
