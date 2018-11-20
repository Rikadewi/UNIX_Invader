/*Variabel Dinamik*/
:- dynamic(health/1).
:- dynamic(armor/2). %(nama_armor, darah_armor).
:- dynamic(currLoc/2). %(x, y)
:- dynamic(inventory/1).
:- dynamic(equip/1). %equip current weapon
:- dynamic(objLoc/3). %(nama_object, x, y)
:- dynamic(enemyLoc/3). %(nama_enemy, x, y)
:- dynamic(name/1).
:- dynamic(deadzone/2). %(x, y)
:- dynamic(ammo/1).

/*Static Variable*/

health(50).
armor(none,0).
currLoc(1,1).
/*inventory(none). -- inventory kosong*/
inventory(nasjep).
inventory(jamal).
inventory(kunciC).
inventory(ammoC).
equip(none).
enemy(joshua).
enemyLoc(joshua, 4, 3).
ammo(0).

/*default object*/
obj(armor, jahim).
obj(armor, jamal).
obj(armor, slayerSparta).
newarmor(jahim, 100).
newarmor(jamal, 50).
newarmor(slayeSparta, 25).
obj(medicine,ekado).
obj(medicine,nasjep).
obj(medicine,crisbar).
obj(weapon,kunciC).
obj(weapon,batuRuby).
obj(weapon,ularPython).
obj(weapon,laptop).
obj(ammo,ammoC).
obj(ammo,ammoRuby).
obj(ammo,ammoPython).
obj(ammo,ammoLaptop).
/* obj(magazine,kunciC).
obj(magazine,batuRuby).
obj(magazine,ularPython).
obj(magazine,laptop). */
damage(kunciC,20).
damage(batuRuby,30).
damage(ularPython,40).
damage(laptop,100).


/*default lokasi object*/
objLoc(laptop, 3, 4).
objLoc(ammoLaptop, 8, 9).
objLoc(ekado, 1, 4).
objLoc(jahim, 6, 8).

/*default peta*/
loc(1,1,'hutan').
loc(1,2,'hutan').
loc(2,1,'hutan').
loc(2,2,'kbl').

/*default deadzone*/
deadzone(9,1).

/*default deadzone*/
