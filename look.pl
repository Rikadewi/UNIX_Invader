is_valid(X,Y):- X=<10,X>=1,Y=<10,Y>=1.


look_around :-
	write('Anda mengamati sekeliling dan melihat berbagai hal..'),nl,
	currLoc(X,Y),

	% write('Di bawah kamu ada : '),
	I is X-1, J is Y-1,
	lookat(I,J),
	K is X-1, L is Y,
	lookat(K,L),
	M is X-1, N is Y+1,
	lookat(M,N),nl,
	O is X, P is Y-1,
	lookat(O,P),
	Q is X, R is Y,
	lookat(Q,R),
	S is X, T is Y+1,
	lookat(S,T),nl,
	U is X+1, V is Y-1,
	lookat(U,V),
	W is X+1, A is Y,
	lookat(W,A),
	B is X+1, C is Y+1,
	lookat(B,C),nl,!.

	/*Implementasi lookat*/


lookat(X,Y) :-
	enemyLoc(_,X,Y),
	write('E '),!.

lookat(X,Y) :-
	obj(medicine,Z),
	objLoc(Z,X,Y),
	write('M '),!.

lookat(X,Y) :-
	obj(weapon,Z),
	objLoc(Z,X,Y),
	write('W '),!.


lookat(X,Y) :-
	obj(armor,Z),
	objLoc(Z,X,Y),
	write('A '),!.


lookat(X,Y) :-
	obj(weapon_ammo,Z),
	objLoc(Z,X,Y),
	write('O '),!.

lookat(X,Y) :-
	currLoc(X,Y),
	write('P '),!.

lookat(X,Y) :-
	\+is_valid(X,Y),
	write('X '),!.


lookat(_,_):-
	write('- ').
