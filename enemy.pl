/*Deklarasi enemy */
/*enemy(ID,nama,weapon,damage) */
enemy(1,joshua,kepintaranya,100).
enemy(2,badur,kunciC,20).
enemy(3,lukas,kunciC,20).
enemy(4,rika,kunciC,20).
enemy(5,alam,kunciC,20).
enemy(6,johanes,batuRuby,30).
enemy(7,tude,batuRuby,30).
enemy(9,asyraf,batuRuby,30).
enemy(10,asif,ularPython,40).
enemy(8,bari,ularPython,40).
enemy(11,jofi,kopiJava,50).
enemy(12,kintan,kopiJava,50).
enemy(13,danlap,agitashit,50).
enemy(14,asistenlogif,tubes,100).
enemy(15,winston,batuRuby,30).
enemy(16,steve,batuRuby,30).
enemy(17,pakRila,nilaiE,100).


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
  spawn_enemy(1),
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
  spawn_enemy(17),
  spawn_enemy(14),
  spawn_enemy(1),
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
  \+deadzone(Xmove,Ymove),!,
  retract(enemyLoc(V,X,Y)),
  asserta(enemyLoc(V,Xmove,Ymove)),
  enemyaction(V,Xmove,Ymove),!.

move_enemy_bawah(N) :-
  move_enemy_atas(N), !.

move_enemy_atas(N) :-
  enemyLoc(N,X,Y),
  Xmove is X,
  Ymove is Y-1,
  \+deadzone(Xmove,Ymove), !,
  enemyaction(N,Xmove,Ymove),
  retract(enemyLoc(N,X,Y)),
  asserta(enemyLoc(N,Xmove,Ymove)), !.

move_enemy_atas(N) :-
  move_enemy_kiri(N), !.



move_enemy_kanan(A) :-
  enemyLoc(A,X,Y),
  Xmove is X+1,
  Ymove is Y,
  \+deadzone(Xmove,Ymove), !,
  enemyaction(A,Xmove,Ymove),
  retract(enemyLoc(A,X,Y)),
  asserta(enemyLoc(A,Xmove,Ymove)), !.

move_enemy_kanan(N) :-
  move_enemy_bawah(N), !.

move_enemy_kiri(N) :-
  enemyLoc(N,X,Y),
  Xmove is X-1,
  Ymove is Y,
  \+deadzone(Xmove,Ymove),
  retract(enemyLoc(N,X,Y)),
  asserta(enemyLoc(N,Xmove,Ymove)),
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
/*
move_ene(List):-
  List=[H|Tail],
  enemyLoc(H, X, Y),
  currLoc(X, Y),
  move_ene(Tail), !.
*/

move_ene(List):-
  List=[H|Tail],
  all_deadzone(H), !,
  move_ene(Tail), !.

move_ene(List):-
  List=[H|Tail],
  % set_seed(5), randomize,
  random(1,5,Op),
  move_enemy_random(H, Op),
  move_ene(Tail), !.
/*
move_ene(List) :-
  List = [_|Tail],
  move_ene(Tail), !.
*/

move_all_enemies :-
  totalenemy(N),
  N =:= 0, !.

move_all_enemies :-
  write('semua enemy bergerak, FOKUS MAS/MBA!'),nl,
  findall(N,enemyLoc(N,_,_),Listene),
  move_ene(Listene), !.


all_deadzone(A) :-
  enemyLoc(A,X,Y),
  is_all_deadzone(X,Y),!,
  retract(enemyLoc(A,X,Y)),
  totalenemy(N),
  Nnew is N-1,
  retract(totalenemy(N)),
  asserta(totalenemy(Nnew)), !.

is_all_deadzone(X,Y) :-
  Xleft is X-1,
  Xright is X+1,
  Yup is Y-1,
  Ydown is Y+1,
  deadzone(X,Yup),
  deadzone(X,Ydown),
  deadzone(Xleft,Y),
  deadzone(Xright,Y),!.

attack_enemy :-
  currLoc(X,Y),
  enemyLoc(V,X,Y),
  equip(W),
  weapon_ammo(W, AmmoW),
  ammo(AmmoW, WA),
  WA>0,!,
  totalenemy(N),
  write('Anda menggunakan '), write(W), write(' untuk memusnahkan '), write(V), write(', luar biasa!'),nl,!,
  enemy(_,V,D,_),
  dropWeapon(D,X,Y),
  retract(enemyLoc(V,X,Y)),
  retract(totalenemy(N)),
  retract(ammo(AmmoW, WA)),
  WAnew is WA-1,
  Nnew is N-1,
  asserta(ammo(AmmoW, WAnew)),
  asserta(totalenemy(Nnew)), !.

attack_enemy :-
  currLoc(X,Y),
  enemyLoc(_S,X,Y),
  equip(W),
  weapon_ammo(W, AmmoW),
  ammo(AmmoW, WA),
  WA=0,!,
  write('Anda Mencoba menggunakan '), write(W), write(' namun Ammo Kosong, makanya spek diperhatikan!'), !.

attack_enemy :-
  currLoc(X,Y),
  enemyLoc(_,X,Y),
  write('Anda mencoba melawannya dengn tangan kosong, namun apa daya seorang mahasiswa IF yang terlalu banyak nubes, jarang olahraga'),nl,
  write('Seranganmu Gagal!'),!.

attack_enemy :-
  write('tidak ada musuh di sekitar, ferguso'),nl,!.

dropWeapon(D,X,Y):-
  obj(weapon,D),
  write('Musuh telah drop '), write(D),nl,
  asserta(objLoc(D,X,Y)),!.

dropWeapon(D,_,_):-
  write(D), write(' tidak dapat di drop'),nl,!.



enemyaction(V,X,Y) :-
  currLoc(X,Y),
  random(0,2,C), %klo 1 kena, kalo 0 nggak
  hitmiss(V,C).


enemyaction(_,_,_):-
  !.

hitmiss(V,C) :-
  C == 1, !, write('A wild '), write(V), write(' appears!'), write(' dia berhasil menyerangmu!'),nl, hitplayer(V,C), nl,!.

hitmiss(V,C) :- write('A wild '), write(V), write(' appears!'), write(' Untungnya anda sudah melihatnya terlebih dahulu'),nl,hitplayer(V,C),!.

hitplayer(V,1) :-
  enemy(_,V,W,_),
  health(_),
  armor(A),
  A>0, !,
  obj(weapon,W),
  damage(W,D),
  A=<D, !, retract(armor(A)), asserta(armor(0)),write('Armor anda telah dihancurkan oleh '), write(V),write(' menggunakan '), write(W),nl,!.

hitplayer(V,1) :-
  enemy(_,V,W,_),
  health(_),
  armor(A),
  A>0, !,
  obj(weapon,W),
  damage(W,D),
  A>D, !, 
  Anew is A-D,
  retract(armor(A)),asserta(armor(Anew)), write('Armor anda telah dirusak oleh '), write(V),write(' menggunakan '), write(W),nl,!.
/*
hitplayer(V,1) :-
  enemy(_,V,W,D),
  health(_),
  armor(A),
  A>0, !,
  A=<D,retract(armor(A)),asserta(armor(0)), write('Armor anda telah dihancurkan oleh '), write(V),write(' menggunakan '), write(W),nl,!.
*/
hitplayer(V,1) :-
  enemy(_,V,W,_),
  health(X),
  obj(weapon,W),
  damage(W,D),
  X>D, Xnew is X-D,
  retract(health(X)), asserta(health(Xnew)),
  write('Anda telah disakiti oleh '), write(V),write(' menggunakan '),write(W),nl,
  write('Nyawa berkurang sebesar '), write(D),nl,!.

hitplayer(V,1) :-
  enemy(_,V,W,_),
  health(X),
  obj(weapon,W),
  damage(W,D),
  X=<D,retract(health(X)), asserta(health(0)), write('Anda telah terbunuh oleh '), write(V),write(' menggunakan '), write(W),nl,!.

%kalo special enemy yang gapunya weapon
hitplayer(V,1) :-
  enemy(_,V,W,D),
  health(X),
  X=<D,retract(health(X)), asserta(health(0)), write('Anda telah terbunuh oleh '), write(V),write(' menggunakan '), write(W),nl,!.

%Special enemy
hitplayer(V,1) :-
  enemy(_,V,W,D),
  health(X),
  X>D, Xnew is X-D,
  retract(health(X)), asserta(health(Xnew)),
  write('Anda telah disakiti oleh '), write(V),write(' menggunakan '),write(W),nl,
  write('Nyawa berkurang sebesar '), write(D),nl,!.

hitplayer(_,0) :-
  write('Anda berhasil menghindarnya!'),nl.
