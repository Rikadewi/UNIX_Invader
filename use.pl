
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
