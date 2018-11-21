/*Deklarasi enemy */
/*enemy(ID,nama,health,damage) */
enemy(1,joshua,100,100).
enemy(2,badur,20,20).
enemy(3,lukas,20,20).
enemy(4,rika,20,20).
enemy(5,alam,20,20).
enemy(6,johanes,20,20).
enemy(7,tude,20,20).
enemy(9,asyraf,20,20).
enemy(10,asif,20,20).
enemy(8,bari,20,20).
enemy(11,jofi,20,20).
enemy(12,kintan,20,20).
enemy(13,vania,20,20).
enemy(14,asistenlogif,20,20).
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

spawn :-
  random(1,18,X),
  spawn_enemy(X),
  random(1,18,Y),
  spawn_enemy(Y),
  random(1,18,Z),
  spawn_enemy(Z),
  random(1,18,U),
  spawn_enemy(U).


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
	is_loc_valid(Xmove,Ymove), !.
move_enemy_bawah(N) :-
	move_enemy_atas(N), !.

move_enemy_atas(N) :-
	enemyLoc(N,X,Y),
	Xmove is X,
	Ymove is Y-1,
	retract(enemyLoc(N,X,Y)),
	asserta(enemyLoc(N,Xmove,Ymove)),
	is_loc_valid(Xmove,Ymove), !.
move_enemy_atas(N) :-
	move_enemy_bawah(N), !.

move_enemy_kanan(N) :-
	enemyLoc(N,X,Y),
	Xmove is X+1,
	Ymove is Y,
	retract(enemyLoc(N,X,Y)),
	asserta(enemyLoc(N,Xmove,Ymove)),
	is_loc_valid(Xmove,Ymove), !.
move_enemy_kanan(N) :-
	move_enemy_kiri(N), !.

move_enemy_kiri(N) :-
	enemyLoc(N,X,Y),
	Xmove is X-1,
	Ymove is Y,
	retract(enemyLoc(N,X,Y)),
	asserta(enemyLoc(N,Xmove,Ymove)),
	is_loc_valid(Xmove,Ymove), !.
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
