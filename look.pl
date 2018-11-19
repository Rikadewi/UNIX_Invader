
look_around :-
	write("Anda mengamati sekeliling, ")
	currLoc(X,Y),
	U is X-1,
	D is X+1,
	R is Y+1,
	L is Y-1,

	lookat(U,Y),
	lookat(U,L),
	lookat(U,R),

	lookat(DX,Y),
	lookat()
	URX is X
lookat(X,Y) :-
