/*Included files */
:-include('variables.pl').
:-include('enemy.pl').
:-include('look.pl').
:-include('use.pl').
:-include('map_move.pl').

/*Rules*/
start :-
	nl,
	write('.##.....#.##....#.###.##.....#...###.##....#.##.....#....###...########.#######.########.'), nl,
	write('.##.....#.###...#..##..##...##....##.###...#.##.....#...##.##..##.....#.##......##.....##'),nl,
	write('.##.....#.####..#..##...##.##.....##.####..#.##.....#..##...##.##.....#.##......##.....##'),nl,
	write('.##.....#.##.##.#..##....###......##.##.##.#.##.....#.##.....#.##.....#.######..########.'),nl,
	write('.##.....#.##..###..##...##.##.....##.##..###..##...##.########.##.....#.##......##...##..'),nl,
	write('.##.....#.##...##..##..##...##....##.##...##...##.##..##.....#.##.....#.##......##....##.'),nl,
	write('..#######.##....#.###.##.....#...###.##....#....###...##.....#.########.#######.##.....##'),nl,
	nl,nl,

	write('Hai warrior! Siapa namamu? (dimulai huruf kecil)'), nl,
	write('>> '),
	read(X),
	write('Semua anak UNIX telah dibrainwash oleh Joshua saat praktikum Logif! Tugasmu adalah membersihkan ITB dari para zombie yang masih berkeliaran.'), nl,
	asserta(name(X)),
	write('Pilih tingkat stress yang Anda inginkan : '),nl,
	write('[1] Kentang'),nl,
	write('[2] Sparta Day 4'),nl,
	write('[3] Ferguso'),nl,
	write('Pilihan : '),
	read(L),
	asserta(difficulty(L)), nl,
	write('Nah sekarang saatnya beraksi!'), nl,
	do(help),
	supply,
	spawn_player,
	
	spawn_level(L),nl, %Nanti ini diganti sama spawn_level(N) dimana N adalah integer 1 (gampang), 2(sedeng), 3(susah).

	repeat,
		write('>> '), /* Menandakan input */
		read(Input),nl, /*Meminta input dari user */
		do(Input),nl, /*Menjadlankan do(Input) */
		end_condition. /*apabila end end condition terpenuhi maka program akan berakhir */

/* Daftar fungsi-fungsi do() yang SUDAH DIIMPLEMENTASI*/
do(help) :- showhelp, !.
do(quit) :-
	write('Seorang warrior tidak pernah lari dari tanggung jawab.'), nl,
	write('Apakah Anda yakin ingin meninggalkan permainan?(y/n)'), nl,
	write('>> '), read(X), end(X), !.
do(map) :- printLegend, !.
do(save) :-	savegame, !.
do(n) :- north, printinfo, move_all_enemies, langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(s) :- south, printinfo, move_all_enemies,langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(w) :- west, printinfo, move_all_enemies,langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(e) :- east, printinfo, move_all_enemies,langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(drop(X)) :- drop(X), move_all_enemies,langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(look) :-	look_around, nl, !.
do(take(X)):- notmaxinv, !, takes(X),move_all_enemies,langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(take(_)):- write('Inventory full, ferguso'), nl, !.
do(use(X)):- uses(X),move_all_enemies,langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(attack) :-	attack_enemy, move_all_enemies,langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(status) :- statuss,!.
do(load) :-	loadgame, nl, !.
do(_) :- write('Invalid Input'), nl, !.


/* inventory */
notmaxinv :-
	findall(I,inventory(I),L),
	count(L,N),
	maxinventory(X),
	N<X.

count([],0).
count([_|T],N) :-
	count(T, N1),
	N is N1+1, !.


/*Kumpulan rule untuk save game*/
savegame:-
	open('savefile.txt',write,Save),
	name(Nama_User),
	write(Save,name(Nama_User)),write(Save,'.'),nl(Save),
	difficulty(Level),
	write(Save,difficulty(Level)),write(Save,'.'),nl(Save),
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
	disDeadzone(Dead),
	write(Save,disDeadzone(Dead)),write(Save,'.'),nl(Save),
	langkah(L),
	write(Save,langkah(L)),write(Save,'.'),nl(Save),
	maxinventory(Max),
	write(Save,maxinventory(Max)),write(Save,'.'),nl(Save),
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


/*Bagian rekursif untuk save game*/
writeData_One(_,[],_) :- !.
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

writeData_three(_,[],[],[],_) :- !.
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

writeData_two(_,[],[],_) :- !.
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
	difficulty(L),
	disDeadzone(D),
	langkah(S),
	maxinventory(Max),
	retractall(langkah(S)),
	retractall(maxinventory(Max)),
	retractall(difficulty(L)),
	retractall(disDeadzone(D)),
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
	name(X),
	write(X),
	write(' kamu adalah warrior terpilih yang ditakdirkan untuk melawan si jahat Joshua'), nl,
	write('Berikut aksi yang dapat kamu lakukan untuk menyelamatkan dunia'), nl,
	write('[1] help'), nl,
	write('[2] quit'), nl,
	write('[3] look'), nl,
	write('[4] map'), nl,
	write('[5] n'), nl,
	write('[6] s'), nl,
	write('[7] e'), nl,
	write('[8] w'), nl,
	write('[9] take'), nl,
	write('[10] drop'), nl,
	write('[11] use'), nl,
	write('[12] attack'), nl,
	write('[13] status'), nl,
	write('[14] save'), nl,
	write('[15] load'), nl, !.

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
	set_seed(2),randomize,
	random(1,11,Xnew),
	random(1,11,Ynew),
	retract(currLoc(X,Y)),
	asserta(currLoc(Xnew,Ynew)),!.



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

	weapon_ammo(W, B), ammo(B, A),

	write('Ammo : '), write(A),nl,
	write('List Inventory '),
	maxinventory(In), write('('),write(In),write(') :'),
	findall(I,inventory(I),Listinvent), nl,
	printlist(Listinvent),nl,!.

printlist([]).
printlist([H|T]) :- write(H), nl, printlist(T),!.


plusinv(bagLv1) :-
	maxinventory(N),
	N1 is N+1,
	retract(maxinventory(N)),
	asserta(maxinventory(N1)),!.

plusinv(bagLv2) :-
	maxinventory(N),
	N1 is N+2,
	retract(maxinventory(N)),
	asserta(maxinventory(N1)),!.

plusinv(bagLv3) :-
	maxinventory(N),
	N1 is N+3,
	retract(maxinventory(N)),
	asserta(maxinventory(N1)),!.

/* Take bag */
takes(X):-
	obj(bag,X),
	objLoc(X,Y,Z),
	currLoc(Y,Z),!,
	plusinv(X),
	retract(objLoc(X,Y,Z)),
	write('item '), write(X), write(' diambil'), nl,
	maxinventory(N),
	write('Maximum inventory berubah menjadi '), write(N), nl, !.

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
/* Take Ammo */
/* takes(X):-
	obj(weaponammo,X),
	objLoc(X,Y,Z),
	currLoc(Y,Z),!,
	asserta(inventory(X)),
	retract(objLoc(X,Y,Z)),
	write('item '), write(X),write(' diambil'), nl, !. */

/* Take ammo & medicine */
takes(X):-
	obj(_,X),
	objLoc(X,Y,Z),
	currLoc(Y,Z),!,
	asserta(inventory(X)),
	retract(objLoc(X,Y,Z)),
	write('item '), write(X),write(' diambil'), nl, !.

takes(X):-
	write(X), write(' tidak ada di sini'), nl.



/* Drop */

/* Drop dari inventory*/
drop(X) :- inventory(X),!, retract(inventory(X)), currLoc(A,B), asserta(objLoc(X, A, B)), write(X), write(' berhasil di drop'), nl,!.


/* Drop armor*/

drop(armor) :- armor(X), X == 0, !, write('armor Anda 0'), nl, !.
drop(armor) :- armor(X), retract(armor(X)), asserta(armor(0)), write('armor hilang dari peta'), nl, !.


/* Drop weapon*/
drop(X) :- equip(X), weapon_ammo(X, A),  ammo(A, N), N == 0, !,
	retract(equip(X)),
	currLoc(A,B), asserta(objLoc(X, A, B)),
	asserta(equip(none)),
	write(X), write(' berhasil di drop'), nl,!.

drop(X) :- equip(X), weapon_ammo(X, A),  ammo(A, N), !,
	retract(equip(X)),
	retract(ammo(A, N)),
	currLoc(C,B),
	asserta(objLoc(X, C, B)),
	asserta(equip(none)),
	asserta(ammo(A, 0)),
	asserta(ammo(ammonone, 0)),
	write(X), write(' berhasil di drop'), nl,
	write('Amunisi hilang dari peta'), nl,!.

/* Drop ammo*/

drop(X) :- obj(weaponammo, X), ammo(X, N), newammo(X, N), !, retract(ammo(X)), currLoc(A,B), asserta(objLoc(X, A, B)), asserta(ammo(X, 0)),  write(X), write('berhasil di drop'), nl,!.
drop(X) :- obj(weaponammo, X),!, retract(ammo(X, _)), asserta(ammo(X, 0)), write('ammmo sudah berubah sehingga hilang dari peta'), nl, !.

drop(X) :- write('Tidak ada barang '), write(X), write(' di inventory'), nl, !.

/* Supply Drop */
supply :-
	disDeadzone(A),
	A1 is 11-A+1,
	/*supply medicine*/
	random(A,A1,X),
	random(A,A1,Y),
	random(1,4,M),
	medic_name(M, M_name),
	asserta(objLoc(M_name,X,Y)),
	/*supply armor*/
	random(A,A1,X2),
	random(A,A1,Y2),
	random(1,4,Ar),
	armor_name(Ar, A_name),
	asserta(objLoc(A_name,X2,Y2)),
	/*supply weapon*/
	random(A,A1,X3),
	random(A,A1,Y3),
	random(1,5,W),
	weapon_name(W, W_name),
	asserta(objLoc(W_name,X3,Y3)),
	/*supply armor*/
	random(A,A1,X4),
	random(A,A1,Y4),
	random(1,5,O),
	ammo_name(O, O_name),
	asserta(objLoc(O_name,X4,Y4)), 
	/*supply bag*/
	random(A,A1,X5),
	random(A,A1,Y5),
	random(1,4,B),
	bag_name(B, B_name),
	asserta(objLoc(B_name,X5,Y5)), 
	!.

medic_name(1, ekado).
medic_name(2, nasjep).
medic_name(3, crisbar).

armor_name(1, jahim).
armor_name(2, jamal).
armor_name(3, slayerSparta).

weapon_name(1, kunciC).
weapon_name(2, batuRuby).
weapon_name(3, ularPython).
weapon_name(4, kopiJava).

ammo_name(1, ammoC).
ammo_name(2, ammoRuby).
ammo_name(3, ammoPython).
ammo_name(4, ammoJava).

bag_name(1, bagLv1).
bag_name(2, bagLv2).
bag_name(3, bagLv3).

/*END CONDITION*/
end(n) :-
	write('Anda memang seorang warrior sejati, '),
	name(X), write(X), write('!'), nl, !.

end(y) :- halt, !.

end_condition :-
  health(0), !,
  write('Nyawa Anda hilang. Joshua menang, ternyata hidup tidak semudah itu Ferguso'),nl, end(y), !.

end_condition :-
  totalenemy(0), !,
  write('Wow! Anda telah memusnahkan seluruh anggota UNIX, selamaaatt!!!'),nl, end(y), !.
