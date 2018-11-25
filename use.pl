
equip_armor(Z) :- newarmor(Z,N), armor(X), X+N > 100,retract(armor(X)),asserta(armor(100)), write('Armor : '),write(100),nl,!.
equip_armor(Z) :- newarmor(Z,N), armor(X), W is X+N ,retract(armor(X)),asserta(armor(W)), write('Armor : '),write(W),nl,!.


pakai_obat(Z) :- newmedicine(Z, N), health(X), X+N > 100,retract(health(X)),asserta(health(100)), write('Darahmu : '),write(100),nl,write('Full bosque'),nl,!.
pakai_obat(Z) :- newmedicine(Z, N), health(X), W is X+N, retract(health(X)),asserta(health(W)), write('Darahmu : '),write(W),nl,!.

add_ammo(Z) :- newammo(Z, N), ammo(Z, X), W is X + N, retract(ammo(Z, X)), asserta(ammo(Z, W)), write('Total '), write(Z), write(' adalah '), write(W),nl,!.


equip_weapon(A) :- equip(X), weapon_ammo(X, _), retract(equip(X)),
						weapon_ammo(A, B), ammo(B, J), asserta(equip(A)),
						write('senjata yang dipakai : '), write(A), nl, damage(A, H), write('Damage attack: '), write(H),nl,
						write('Ammo yang kamu punya untuk senjata ini adalah '), write(J),nl,!.

/* Use medicine*/
uses(X) :-
	obj(medicine,X),
	inventory(X),
	pakai_obat(X),
	retract(inventory(X)),!.
/* Use Ammo */
uses(X) :-
	obj(weaponammo,X),
	weapon_ammo(W,X),
	equip(W), !,
	inventory(X),
	add_ammo(X),
	retract(inventory(X)),!.

uses(X) :-
	obj(weaponammo,X),
	weapon_ammo(W,X),
	write(W),
	write(' sedang tidak dipakai'), nl, !.
	
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
