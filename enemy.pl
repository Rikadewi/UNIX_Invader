/*Deklarasi enemy */
/*enemy(ID,nama,health,damage) */
enemy(1,joshua,100,100).
enemy(2,badur,20,20).
enemy(3,lukas,20,20).
enemy(4,rika,20,20).
enemy(5,alam,20,20).
enemy(6,johanes,20,20).https://github.com/Rikadewi/UNIX_Invader.git
enemy(7,tude,20,20).
enemy(9,asyraf,20,20).
enemy(10,asif,20,20).
enemy(8,bari,20,20).
enemy(11,jofi,20,20).
enemy(12,kintan,20,20).
enemy(13,vania,20,20).
enemy(14,asistenlogif,20,100).
enemy(15,winston,20,20).
enemy(16,steve,20,20).
enemy(17,dika,20,20).


spawn_enemy(N):-
  enemy(N,V,_,_),
  random(1,11,X),
  random(1,11,Y),
  asserta(enemyLoc(V,X,Y)),!.

spawn_enemy(N) :-
  enemy(N,V,_,_),
  random(1,11,Xnew),
  random(1,11,Ynew),
  retract(enemyLoc(_,Xnew,Ynew)),
  asserta(enemyLoc(V,Xnew,Ynew)),!.

spawn_level(1) :-
  random(1,18,X),
  spawn_enemy(X),
  random(1,18,Y),
  spawn_enemy(Y),
  random(1,18,Z),
  spawn_enemy(Z),
  random(1,18,U),
  spawn_enemy(U),
  asserta(totalenemy(4)).

spawn_level(2) :-
  random(1,18,X),
  spawn_enemy(X),
  random(1,18,Y),
  spawn_enemy(Y),
  random(1,18,Z),
  spawn_enemy(Z),
  random(1,18,U),
  spawn_enemy(U),
  random(1,18,UX),
  spawn_enemy(UX),
  random(1,18,UZ),
  spawn_enemy(UZ),
  asserta(totalenemy(6)).

spawn_level(3) :-
  random(1,18,X),
  spawn_enemy(X),
  random(1,18,Y),
  spawn_enemy(Y),
  random(1,18,Z),
  spawn_enemy(Z),
  random(1,18,U),
  spawn_enemy(U),
  random(1,18,V),
  spawn_enemy(V),
  random(1,18,W),
  spawn_enemy(W),
  random(1,18,A),
  spawn_enemy(A),
  random(1,18,B),
  spawn_enemy(B),
  random(1,18,C),
  spawn_enemy(C),
  random(1,18,D),
  spawn_enemy(D),
  asserta(totalenemy(10)).



remove_all_enemies :-
	enemyLoc(_,_,_),
	retractall(enemyLoc(_,_,_)), !.
remove_all_enemies :-!.


/* move 1 enemyLoc(N,X,Y) */

move_enemy_bawah(V) :-
	enemyLoc(V,X,Y),
	Xmove is X,
	Ymove is Y+1,
	retract(enemyLoc(V,X,Y)),
	asserta(enemyLoc(V,Xmove,Ymove)),
	\+deadzone(Xmove,Ymove),!,
  enemyaction(V,Xmove,Ymove),!.
move_enemy_bawah(N) :-
	move_enemy_atas(N), !.

move_enemy_atas(N) :-
	enemyLoc(N,X,Y),
	Xmove is X,
	Ymove is Y-1,
	retract(enemyLoc(N,X,Y)),
	asserta(enemyLoc(N,Xmove,Ymove)),
	\+deadzone(Xmove,Ymove), enemyaction(N,Xmove,Ymove),!.
move_enemy_atas(N) :-
	move_enemy_bawah(N), !.

move_enemy_kanan(A) :-
	enemyLoc(A,X,Y),
	Xmove is X+1,
	Ymove is Y,
	retract(enemyLoc(A,X,Y)),
	asserta(enemyLoc(A,Xmove,Ymove)),
	\+deadzone(Xmove,Ymove), enemyaction(A,Xmove,Ymove),!.
move_enemy_kanan(N) :-
	move_enemy_kiri(N), !.

move_enemy_kiri(N) :-
	enemyLoc(N,X,Y),
	Xmove is X-1,
	Ymove is Y,
	retract(enemyLoc(N,X,Y)),
	asserta(enemyLoc(N,Xmove,Ymove)),
	\+deadzone(Xmove,Ymove),
  enemyaction(N,Xmove,Ymove),!.
move_enemy_kiri(N) :-
	move_enemy_kanan(N), !.

/* enemy move sesuai Op nya*/
move_enemy_random(N, Op) :-
	Op =:= 1,
	move_enemy_atas(N), !.

move_enemy_random(N, Op) :-
	Op =:= 2,
	move_enemy_bawah(N), !.

move_enemy_random(N, Op) :-
	Op =:= 3,
	move_enemy_kanan(N), !.

move_enemy_random(N, Op) :-
	Op =:= 4,
	move_enemy_kiri(N), !.

/* rekursif, move semua enemy yang masih hidup */
move_ene([]).
move_ene(List):-
	List=[H|Tail],
	enemyLoc(H, X, Y),
	currLoc(X, Y),
	move_ene(Tail).
move_ene(List):-
	List=[H|Tail],
	% set_seed(5), randomize,
	random(1,5,Op),
	move_enemy_random(H, Op),
	move_ene(Tail).
move_ene(List) :-
	List = [_|Tail],
	move_ene(Tail).

move_all_enemies :-
  write('semua enemy bergerak!'),nl,
	findall(N,enemyLoc(N,_,_),Listene),
	move_ene(Listene), !.


attack_enemy :-
  currLoc(X,Y),
  enemyLoc(V,X,Y),
  equip(W),
  ammo(WA),
  totalenemy(N),
  write('A wild '),write(V),write(' appears!'),nl,
  write('Anda menggunakan '), write(W),nl,
  write(A), write(' telah berhasil dinetralisir'),
  retract(enemyLoc(V,X,Y)),
  retract(totalenemy(N)),
  retract(ammo(WA)),
  WAnew is WA-1,
  Nnew is N-1,
  asserta(ammo(WAnew)),
  asserta(totalenemy(Nnew)).

attack_enemy :-
  currLoc(X,Y),
  enemyLoc(V,X,Y),
  write('Anda mencoba melawannya dengn tangan kosong, namun apa daya seorang mahasiswa IF yang jarang olahraga'),nl,
  write('Seranganmu akhirnya Gagal!'),!.

attack_enemy :-
  write('tidak ada musuh di sekitar, ferguso'),nl,!.


enemyaction(V,X,Y) :-
  currLoc(X,Y),
  random(0,2,C), %klo 1 kena, kalo 0 nggak
  write('si '), write(V), write(' Berusaha menyerang dan mendapat '),write(C),nl,
  hitplayer(V,C).

enemyaction(V,X,Y):-
  write('si '), write(V), write(' Tidak ngpa2in'),nl.


hitplayer(V,1) :-
  enemy(_,V,_,D),
  health(X),
  X=<D,retract(health(X)), asserta(health(0)), write('Anda telah terbunuh oleh '), write(V),nl,!.

hitplayer(V,1) :-
  enemy(_,V,_,D),
  health(X),
  X>D, Xnew is X-D,
  retract(health(X)), asserta(health(Xnew)),
  write('Anda telah disakiti oleh '), write(V),nl,
  write('Nyawa berkurang sebesar '), write(D),nl,!.

hitplayer(V,0) :-
  write('Anda berhasil menghindarnya!'),nl.

