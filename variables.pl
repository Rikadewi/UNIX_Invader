/*Menandakan lokasi valid*/
is_loc_valid(X,Y):- X=<10,X>=1,Y=<10,Y>=1.


/*Variabel Dinamik*/
:- dynamic(health/1).
:- dynamic(armor/1). %(darah_armor).
:- dynamic(currLoc/2). %(x, y)
:- dynamic(inventory/1).
:- dynamic(equip/1). %equip current weapon
:- dynamic(objLoc/3). %(nama_object, x, y)
:- dynamic(enemyLoc/3). %(nama_enemy, x, y)
:- dynamic(name/1).
:- dynamic(deadzone/2). %(x, y)
:- dynamic(ammo/2).
:- dynamic(totalenemy/1).


/*Static Variable*/

health(50).
armor(40).
currLoc(1,1).
/*inventory(none). -- inventory kosong*/
inventory(nasjep).
inventory(kunciC).
inventory(ammo).
inventory(jahim).

equip(batuRuby).
ammo(ammoRuby, 4).

/*default object*/
obj(armor, jahim).
obj(armor, jamal).
obj(armor, sweater).
obj(medicine,ekado).
obj(medicine,nasjep).
obj(medicine,crisbar).
obj(weapon,kunciC).
obj(weapon,batuRuby).
obj(weapon,ularPython).
obj(weapon_ammo,ammo).

newarmor(jahim, 100).
newarmor(jamal, 50).
newarmor(sweater, 25).

newammo(ammoruby, 5).
newammo(ammoC, 5).
newammo(ammoPython, 5).

damage(kunciC,20).
damage(batuRuby,30).
damage(ularPython,40).

/*default lokasi object*/
objLoc(kunciC, 3, 4).
objLoc(ammo, 8, 9).
objLoc(ekado, 1, 4).
objLoc(sweater, 6, 8).

/*default peta*/
loc(1,1,'hutan').
loc(1,2,'hutan').
loc(2,1,'hutan').
loc(2,2,'kbl').

/*default deadzone*/
deadzone(0,0).
deadzone(0,1).
deadzone(0,2).
deadzone(0,3).
deadzone(0,4).
deadzone(0,5).
deadzone(0,6).
deadzone(0,7).
deadzone(0,8).
deadzone(0,9).
deadzone(0,10).
deadzone(0,11).
deadzone(11,1).
deadzone(11,2).
deadzone(11,3).
deadzone(11,4).
deadzone(11,5).
deadzone(11,6).
deadzone(11,7).
deadzone(11,8).
deadzone(11,9).
deadzone(11,10).
deadzone(11,11).
deadzone(1,0).
deadzone(2,0).
deadzone(3,0).
deadzone(4,0).
deadzone(5,0).
deadzone(6,0).
deadzone(7,0).
deadzone(8,0).
deadzone(9,0).
deadzone(10,0).
deadzone(11,0).
deadzone(1,11).
deadzone(2,11).
deadzone(3,11).
deadzone(4,11).
deadzone(5,11).
deadzone(6,11).
deadzone(7,11).
deadzone(8,11).
deadzone(9,11).
deadzone(10,11).
deadzone(11,11).
