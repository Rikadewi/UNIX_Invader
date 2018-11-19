
look_around :-
	write("Anda mengamati sekeliling, ")
	currLoc(X,Y),
	UX is X-1,
	DX is X+1,
	lookat()

lookat(X,Y) :-
