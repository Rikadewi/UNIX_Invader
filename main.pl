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

	write('Hai warrior! Siapa namamu? (dimulai huruf kecil)'), nl,
	write('>> '),
	read(X),
	write('Semua orang sudah dibrainwash oleh Joshua! Tugasmu adalah membersihkan dunia dari para zombie yang masih berkeliaran.'), nl,
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
do(n) :- north, move_all_enemies, langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(s) :- south, move_all_enemies,langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(w) :- west, move_all_enemies,langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(e) :- east, move_all_enemies,langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(drop(X)) :- drop(X), move_all_enemies,langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(look) :-	look_around, nl, !.
do(take(X)):- notmaxinv, !, takes(X),move_all_enemies,langkah(L),plusdisDeadzone(L), L2 is L+1, retract(langkah(L)),asserta(langkah(L2)),!.
do(take(X)):- write('Inventory full, ferguso'), nl, !.
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
count([H|T],N) :-
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
	maxinventory(I),
	write(Save,maxinventory(I)),write(Save,'.'),nl(Save),
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
	difficulty(L),
	disDeadzone(D),
	langkah(L),
	maxinventory(I),
	retractall(langkah(L)),
	retractall(maxinventory(I)),
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

/*PRINT MAP*/

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

upzone(D1,D1):- objLoc(_,X,Y), X==D1,Y==D1,!, retract(objLoc(_,X,Y)), asserta(deadzone(D1,D1)),!.
upzone(D1,D1):- asserta(deadzone(D1,D1)),!.
upzone(D1,D2):- objLoc(_,X,Y), X==D1,Y==D2,!, retract(objLoc(_,X,Y)), asserta(deadzone(D1,D2)), Dnew is D2-1 , upzone(D1,Dnew),!.
upzone(D1,D2):- asserta(deadzone(D1,D2)), Dnew is D2-1 , upzone(D1,Dnew),!.
downzone(D2,D2):-objLoc(_,X,Y), X==D2,Y==D2,!, retract(objLoc(_,X,Y)), asserta(deadzone(D2,D2)),!.
downzone(D2,D2):-asserta(deadzone(D2,D2)),!.
downzone(D1,D2):- objLoc(_,X,Y), X==D2,Y==D1,!, retract(objLoc(_,X,Y)),asserta(deadzone(D2,D1)), Dnew is D1+1 , downzone(Dnew,D2),!.
downzone(D1,D2):- asserta(deadzone(D2,D1)), Dnew is D1+1 , downzone(Dnew,D2),!.
leftzone(D1,D1):- objLoc(_,X,Y), X==D1,Y==D1,!, retract(objLoc(_,X,Y)), retract(deadzone(D1,D1)),!.
leftzone(D1,D1):-retract(deadzone(D1,D1)),!.
leftzone(D1,D2):- Dnew is D2-1, objLoc(_,X,Y), X==Dnew,Y==D1,!, retract(objLoc(_,X,Y)),asserta(deadzone(Dnew,D1)) , leftzone(D1,Dnew),!.
leftzone(D1,D2):- Dnew is D2-1, asserta(deadzone(Dnew,D1)) , leftzone(D1,Dnew),!.
rightzone(D2,D2):- objLoc(_,X,Y), X==D2,Y==D2,!, retract(objLoc(_,X,Y)),retract(deadzone(D2,D2)),!.
rightzone(D2,D2):-retract(deadzone(D2,D2)),!.
rightzone(D1,D2):- Dnew is D1+1, objLoc(_,X,Y), X==Dnew,Y==D2,!, retract(objLoc(_,X,Y)),asserta(deadzone(Dnew,D2)) , rightzone(Dnew,D2),!.
rightzone(D1,D2):- Dnew is D1+1, asserta(deadzone(Dnew,D2)) , rightzone(Dnew,D2),!.



plusdisDeadzone(Count):- Count==26, disDeadzone(D) , D2 is D+1,retract(disDeadzone(D)),asserta(disDeadzone(D2)),plusDeadzone,!.
plusdisDeadzone(Count):- Count==21,disDeadzone(D) , D2 is D+1,retract(disDeadzone(D)),asserta(disDeadzone(D2)),plusDeadzone,!.
plusdisDeadzone(Count):- Count==15,disDeadzone(D) , D2 is D+1,retract(disDeadzone(D)),asserta(disDeadzone(D2)),plusDeadzone,!.
plusdisDeadzone(Count):- Count==8,disDeadzone(D) , D2 is D+1,retract(disDeadzone(D)),asserta(disDeadzone(D2)),plusDeadzone,!.
plusdisDeadzone(Count):-!.
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

	weapon_ammo(W, B), ammo(B, A),

	write('Ammo : '), write(A),nl,
	write('List Inventory '),
	maxinventory(In), write('('),write(In),write(') :'),
	findall(I,inventory(I),Listinvent), nl,
	printlist(Listinvent),nl,!.

printlist([]).
printlist([H|T]) :- write(H), nl, printlist(T),!.


/* equip_armor(jahim) :- newarmor(jahim,N), armor(A,X), X=0, retract(armor(A,X)),asserta(armor(jahim,N)), write('Armor : '),write(N),nl,write('Mantap bosque'),nl,!.
equip_armor(jahim) :- newarmor(jahim,N), armor(jamal,X), X=50, currLoc(P,Q), asserta(objLoc(A, P, Q)), retract(armor(A,X)),asserta(armor(jahim,N)), write('Armor : '),write(N),nl,write('Mantap bosque'),nl,!.
equip_armor(jahim) :- newarmor(jahim,N), armor(jamal,X), X<50, retract(armor(A,X)),asserta(armor(jahim,N)), write('Armor : '),write(N),nl,write('Mantap bosque'),nl,!.
equip_armor(jahim) :- newarmor(jahim,N), armor(slayerSparta,X), X=25, currLoc(P,Q), asserta(objLoc(A, P, Q)), retract(armor(A,X)),asserta(armor(jahim,N)), write('Armor : '),write(N),nl,write('Mantap bosque'),nl,!.
equip_armor(jahim) :- newarmor(jahim,N), armor(slayerSparta,X), X<25, retract(armor(A,X)),asserta(armor(jahim,N)), write('Armor : '),write(N),nl,write('Mantap bosque'),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(A,X), X=0, retract(armor(A,X)),asserta(armor(jamal,N)), write('Armor : '),write(N),nl,write('Not bad bosque'),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(jahim,X), X=100, currLoc(P,Q), asserta(objLoc(A, P, Q)), retract(armor(A,X)),asserta(armor(jamal,N)), write('Armor : '),write(N),nl,write('Not bad bosque'),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(jahim,X), X<100, retract(armor(A,X)),asserta(armor(jamal,N)), write('Armor : '),write(N),nl,write('Not bad bosque'),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(slayerSparta,X), X=25, currLoc(P,Q), asserta(objLoc(A, P, Q)), retract(armor(A,X)),asserta(armor(jamal,N)), write('Armor : '),write(N),nl,write('Not bad bosque'),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(slayerSparta,X), X<25, retract(armor(A,X)),asserta(armor(jamal,N)), write('Armor : '),write(N),nl,write('Not bad bosque'),nl,!.
equip_armor(slayerSparta) :- newarmor(slayerSparta,N), armor(A,X), X=0, retract(armor(A,X)),asserta(armor(slayerSparta,N)), write('Armor : '),write(N),nl,write('Rapih bet bosque'),nl,!.
equip_armor(slayerSparta) :- newarmor(slayerSparta,N), armor(jahim,X), X=100, currLoc(P,Q), asserta(objLoc(A, P, Q)), retract(armor(A,X)),asserta(armor(slayerSparta,N)), write('Armor : '),write(N),nl,write('Rapih bet bosque'),nl,!.
equip_armor(slayerSparta) :- newarmor(slayerSparta,N), armor(jahim,X), X<100, retract(armor(A,X)),asserta(armor(slayerSparta,N)), write('Armor : '),write(N),nl,write('Rapih bet bosque'),nl,!.
equip_armor(slayerSparta) :- newarmor(slayerSparta,N), armor(jamal,X), X=50, currLoc(P,Q), asserta(objLoc(A, P, Q)), retract(armor(A,X)),asserta(armor(slayerSparta,N)), write('Armor : '),write(N),nl,write('Rapih bet bosque'),nl,!.
equip_armor(slayerSparta) :- newarmor(slayerSparta,N), armor(jamal,X), X<25, retract(armor(A,X)),asserta(armor(slayerSparta,N)), write('Armor : '),write(N),nl,write('Rapih bet bosque'),nl,!. */

equip_armor(jahim) :- newarmor(jahim,N), armor(X), retract(armor(X)), asserta(armor(N)), write('Armor : '),write(N),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(X), X+N > 100,retract(armor(X)),asserta(armor(100)), write('Armor : '),write(100),nl,!.
equip_armor(jamal) :- newarmor(jamal,N), armor(X), W is X+N ,retract(armor(X)),asserta(armor(W)), write('Armor : '),write(W),nl,!.
equip_armor(slayerSparta) :- newarmor(slayerSparta,N), armor(X), X+N > 100,retract(armor(X)),asserta(armor(100)), write('Armor : '),write(100),nl,!.
equip_armor(slayerSparta) :- newarmor(slayerSparta,N), armor(X), W is X+N ,retract(armor(X)),asserta(armor(W)), write('Armor : '),write(W),nl,!.

pakai_obat(crisbar) :- health(X), retract(health(X)),asserta(health(100)), write('Darahmu : '),write(100),nl,write('Full bosque'),nl,!.
pakai_obat(nasjep) :- health(X), X+50 > 100,retract(health(X)),asserta(health(100)), write('Darahmu : '),write(100),nl,write('Full bosque'),nl,!.
pakai_obat(nasjep) :- health(X), W is X+50,retract(health(X)),asserta(health(W)), write('Darahmu : '),write(W),nl,!.
pakai_obat(ekado) :- health(X) ,X+30 > 100,retract(health(X)),asserta(health(100)), write('Darahmu : '),write(100),nl,write('Full bosque'),nl,!.
pakai_obat(ekado) :- health(X) ,W is X+30,retract(health(X)),asserta(health(W)), write('Darahmu : '),write(W),nl,!.


add_ammo(ammoC) :- newammo(ammoC, N), ammo(ammoC, X), W is X + N, retract(ammo(ammoC, X)), asserta(ammo(ammoC, W)), write('Total ammoC adalah : '), write(W),nl,!.
add_ammo(ammoRuby) :- newammo(ammoRuby, N), ammo(ammoRuby, X), W is X + N, retract(ammo(ammoRuby, X)), asserta(ammo(ammoRuby, W)), write('Total ammoRuby adalah : '), write(W),nl,!.
add_ammo(ammoPython) :- newammo(ammoPython, N), ammo(ammoPython, X), W is X + N, retract(ammo(ammoPython, X)), asserta(ammo(ammoPython, W)), write('Total ammoPython adalah : '), write(W),nl,!.
add_ammo(ammoJava) :- newammo(ammoJava, N), ammo(ammoJava, X), W is X + N, retract(ammo(ammoJava, X)), asserta(ammo(ammoJava, W)), write('Total ammoJava adalah : '), write(W),nl,!.

equip_weapon(kunciC) :- equip(X), weapon_ammo(X, Z), ammo(Z, N), /*ammo(N), N>0,asserta(inventory(Z)),*/ retract(equip(X)),
						weapon_ammo(kunciC, B), ammo(B, J), asserta(equip(kunciC)),
						write('senjata yang dipakai : kunciC (Damage attack: 20)'),nl,
						write('Ammo yang kamu punya untuk senjata ini adalah '), write(J),nl,!.

/*equip_weapon(kunciC) :- equip(X), weapon_ammo(X, Z), total_ammo(Z, N), ammo(N), N == 0, retract(equip(X)), retract(ammo(N)),
						weapon_ammo(kunciC, B), total_ammo(B, J), asserta(equip(kunciC)), asserta(ammo(J)),
						write('senjata yang dipakai : kunciC (Damage attack: 20)'),nl,
						write('Ammo yang kamu punya untuk senjata ini adalah '), write(J),nl,!. */


equip_weapon(batuRuby) :- equip(X), weapon_ammo(X, Z), ammo(Z, N), /*ammo(N), N>0,asserta(inventory(Z)),*/ retract(equip(X)),
						weapon_ammo(batuRuby, B), ammo(B, J), asserta(equip(batuRuby)),
						write('senjata yang dipakai : batuRuby (Damage attack: 30)'),nl,
						write('Ammo yang kamu punya untuk senjata ini adalah '), write(J),nl,!.

/*equip_weapon(batuRuby) :- equip(X), weapon_ammo(X, Z), total_ammo(Z, N), ammo(N), N == 0, retract(equip(X)), retract(ammo(N)),
						weapon_ammo(batuRuby, B), total_ammo(B, J), asserta(equip(batuRuby)), asserta(ammo(J)),
						write('senjata yang dipakai : batuRuby (Damage attack: 30)'),nl,
						write('Ammo yang kamu punya untuk senjata ini adalah '), write(J),nl,!. */

equip_weapon(ularPython) :- equip(X), weapon_ammo(X, Z), ammo(Z, N), /*ammo(N), N>0,asserta(inventory(Z)),*/ retract(equip(X)), retract(ammo(N)),
						weapon_ammo(ularPython, B), ammo(B, J), asserta(equip(ularPython)),
						write('senjata yang dipakai : ularPython (Damage attack: 40)'),nl,
						write('Ammo yang kamu punya untuk senjata ini adalah '), write(J),nl,!.


/*equip_weapon(ularPython) :- equip(X), weapon_ammo(X, Z), total_ammo(Z, N), ammo(N), N == 0, retract(equip(X)), retract(ammo(N)),
						weapon_ammo(ularPython, B), total_ammo(B, J), asserta(equip(ularPython)), asserta(ammo(J)),
						write('senjata yang dipakai : ularPython (Damage attack: 40)'),nl,
						write('Ammo yang kamu punya untuk senjata ini adalah '), write(J),nl,!. */

/*equip_weapon(kunciC) :- equip(X), weapon_ammo(kunciC, N), ammo(N), retract(equip(X)),asserta(equip(kunciC)), write('senjata yang dipakai : kunciC (Damage attack: 20)'),nl,!.

equip_weapon(batuRuby) :- equip(X), retract(equip(X)),asserta(equip(batuRuby)), write('senjata yang dipakai : batuRuby (Damage attack : 30)'),nl,!.
equip_weapon(ularPython) :- equip(X), retract(equip(X)),asserta(equip(ularPython)), write('senjata yang dipakai : ularPython (Damage attack : 40)'),nl,!. */
/* equip_weapon(laptop) :- equip(X), retract(equip(X)),asserta(equip(laptop)), write('senjata yang dipakai : Laptop (Damage attack : 100 !!! Ngeri bosque)'),nl,!. */

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
	obj(weaponammo,X),
	inventory(X),
	add_ammo(X),
	retract(inventory(X)),!.
/* Use Armor */
uses(X) :-
	obj(armor,X),
	inventory(X),
	equip_armor(X),
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
drop(X) :- obj(weaponammo, X),!, retract(ammo(X, N)), asserta(ammo(X, 0)), write('ammmo sudah berubah sehingga hilang dari peta'), nl, !.

drop(X) :- write('Tidak ada barang '), write(X), write(' di inventory'), nl, !.

/* Supply Drop */
supply :-
	disDeadzone(A),
	A1 is 11-A+1,
	random(A,A1,X),
	random(A,A1,Y),
	random(1,4,M),
	medic_name(M, M_name),
	asserta(objLoc(M_name,X,Y)),
	random(A,A1,X2),
	random(A,A1,Y2),
	random(1,4,A),
	armor_name(A, A_name),
	asserta(objLoc(A_name,X2,Y2)),
	random(A,A1,X3),
	random(A,A1,Y3),
	random(1,4,W),
	weapon_name(W, W_name),
	asserta(objLoc(W_name,X3,Y3)),
	random(A,A1,X4),
	random(A,A1,Y4),
	random(1,4,A),
	ammo_name(O, O_name),
	asserta(objLoc(O_name,X4,Y4)), !.

medic_name(1, ekado).
medic_name(2, nasjep).
medic_name(3, crisbar).

armor_name(1, jahim).
armor_name(1, jamal).
armor_name(1, slayerSparta).

weapon_name(1, kunciC).
weapon_name(2, batuRuby).
weapon_name(3, ularPython).

ammo_name(1, ammoC).
ammo_name(2, ammoRuby).
ammo_name(3, ammoPython).

/*END CONDITION*/
end(n) :- 
	write('Anda memang seorang warrior sejati, '), 
	name(X), write(X), write('!') nl, !.

end(y) :- halt, !.

end_condition :-
  health(0), !,
  write('Nyawa Anda hilang. Joshua menang, ternyata hidup tidak semudah itu Ferguso'),nl, end(y), !.

end_condition :-
  totalenemy(0), !,
  write('Wow! Anda telah memusnahkan seluruh anggota UNIX, selamaaatt!!!'),nl, end(y), !.
