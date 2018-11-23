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
:- dynamic(weapon_ammo/2).

/*Static Variable*/

health(50).
armor(40).
currLoc(1,1).
/*inventory(none). -- inventory kosong*/
inventory(nasjep).
inventory(kunciC).
inventory(jahim).

equip(batuRuby).
ammo(ammoRuby, 5).

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

/*obj(weapon_ammo,ammo). 
 obj(newammo, ) */
obj(weapammo, ammoC).
obj(weapammo, ammoRuby).
obj(weapammo, ammoPython).

newarmor(jahim, 100).
newarmor(jamal, 50).
newarmor(sweater, 25).

newammo(ammoruby, 5).
newammo(ammoC, 5).
newammo(ammoPython, 5).

weapon_ammo(kunciC, 5).
weapon_ammo(batuRuby, 5).
weapon_ammo(ularPython, 5).

damage(kunciC,20).
damage(batuRuby,30).
damage(ularPython,40).

/*default lokasi object*/
objLoc(kunciC, 3, 4).
objLoc(batuRuby, 5, 4).
objLoc(ammoC, 8, 9).
objLoc(ammoC, 1, 1).
objLoc(ammoRuby, 6, 9).
objLoc(ekado, 1, 4).
objLoc(sweater, 6, 8).

/*default peta*/
loc(1,1,'hutan').
loc(1,2,'hutan').
loc(2,1,'hutan').
loc(2,2,'kbl').

/*default deadzone*/
deadzone(9,1).

/*default deadzone*/
