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
:- dynamic(disDeadzone/1). %tebal deadzone saat ini
:- dynamic(deadzone/2). %(x, y)
:- dynamic(ammo/2). %nama ammo, jumlah
:- dynamic(totalenemy/1).
:- dynamic(difficulty/1).
:- dynamic(langkah/1).
:- dynamic(maxinventory/1).

/*Static Variable*/

health(50).
armor(40).
currLoc(1,1).
langkah(0).
/*inventory(none). -- inventory kosong*/
inventory(nasjep).
inventory(kunciC).
inventory(jahim).

equip(batuRuby).


/*default object*/
obj(armor, jahim).
obj(armor, jamal).
obj(armor, slayerSparta).
obj(medicine,ekado).
obj(medicine,nasjep).
obj(medicine,crisbar).
obj(weapon,kunciC).
obj(weapon,batuRuby).
obj(weapon,ularPython).
obj(weapon,none).
obj(weaponammo,ammoC).
obj(weaponammo,ammoRuby).
obj(weaponammo,ammoPython).
obj(weaponammo,ammonone).
obj(bag,bagLv1). %nambah 1 inventory
obj(bag,bagLv2). %nambah 2 inventory
obj(bag,bagLv3). %nambah 3 inventory


weapon_ammo(kunciC, ammoC).
weapon_ammo(batuRuby, ammoRuby).
weapon_ammo(ularPython, ammoPython).
weapon_ammo(kopiJava, ammoJava).
weapon_ammo(none, ammonone).

ammo(ammoRuby, 4).
ammo(ammoC, 0).
ammo(ammoPython, 0).
ammo(ammonone, 0).
ammo(ammoJava,0).

newarmor(jahim, 100).
newarmor(jamal, 50).
newarmor(slayerSparta, 25).

newammo(ammoruby, 5).
newammo(ammoC, 5).
newammo(ammoPython, 5).
newammo(ammoJava,5).

damage(kunciC,20).
damage(batuRuby,30).
damage(ularPython,40).

/*default lokasi object*/
objLoc(kunciC, 9, 10).
objLoc(kunciC, 3, 10).
objLoc(ammoC, 8, 9).
objLoc(ekado, 1, 4).
objLoc(slayerSparta, 6, 8).
objLoc(bagLv1, 5, 5).
objLoc(bagLv2, 5, 4).
objLoc(bagLv3, 5, 3).


/*default peta*/
loc(1,1,'Hutan bagian barat laut ITB').
loc(1,2,'Hutan bagian barat laut ITB').
loc(1,3,'Pintu gerbang Gedung SBM').
loc(1,4,'Sabuga').
loc(1,5,'Sabuga').
loc(1,6,'Saraga').
loc(1,7,'Hutan bagian timur laut ITB').
loc(1,8,'Hutan bagian timur laut ITB').
loc(1,9,'Hutan bagian timur laut ITB').
loc(1,10,'Gerbang Dayang Sumbi').
loc(2,1,'Hutan bagian barat laut ITB').
loc(2,2,'Kantin Barat Laut').
loc(2,3,'Gedung SBM').
loc(2,4,'Jalan Aspal').
loc(2,5,'CADL').
loc(2,6,'Tangga Sunken').
loc(2,7,'Perpustakaan').
loc(2,8,'CAS').
loc(2,9,'CRCS').
loc(2,10,'Pos Satpam').
loc(3,1,'Gerbang Barat ITB').
loc(3,2,'Hutan bagian barat laut ITB').
loc(3,3,'Gedung FTMD').
loc(3,4,'Jalan Aspal').
loc(3,5,'Labtek Biru').
loc(3,6,'Plaza Widya').
loc(3,7,'Perpustakaan').
loc(3,8,'Jalan Aspal').
loc(3,9,'Gedung Kimia').
loc(3,10,'Hutan bagian timur ITB').
loc(4,1,'Hutan bagian barat ITB').
loc(4,2,'GKU Barat').
loc(4,3,'GKU Barat').
loc(4,4,'Jalan Aspal').
loc(4,5,'Labtek VI').
loc(4,6,'Sisi Utara Intel').
loc(4,7,'Labtek VII').
loc(4,8,'Kantin Bengkok').
loc(4,9,'GKU Timur').
loc(4,10,'GKU Timur').
loc(5,1,'Hutan bagian barat ITB').
loc(5,2,'GKU Barat').
loc(5,3,'GKU Barat').
loc(5,4,'Amphitheatre').
loc(5,5,'Sisi Barat Intel').
loc(5,6,'Intel').
loc(5,7,'Sisi Timur Intel').
loc(5,8,'Jalan Aspal').
loc(5,9,'GKU Timur').
loc(5,10,'GKU Timur').
loc(6,1,'Hutan bagian barat ITB').
loc(6,2,'Hutan bagian barat ITB').
loc(6,3,'Tembok Ratapan').
loc(6,4,'Amphitheatre').
loc(6,5,'Labtek V').
loc(6,6,'Sisi Selatan Intel').
loc(6,7,'Labtek VIII').
loc(6,8,'Lab Doping').
loc(6,9,'GKU Timur').
loc(6,10,'GKU Timur').
loc(7,1,'Gedung CIBE').
loc(7,2,'Hutan bagian barat ITB').
loc(7,3,'Gedung Fisika').
loc(7,4,'Lapangan Basket').
loc(7,5,'CBar').
loc(7,6,'Tugu Friendzone').
loc(7,7,'CTim').
loc(7,8,'Taman Plano').
loc(7,9,'Gedung Arsitektur').
loc(7,10,'Nasjep').
loc(8,1,'Parkir Motor').
loc(8,2,'Hutan bagian barat ITB').
loc(8,3,'Gedung Sipil').
loc(8,4,'Lapangan Basket').
loc(8,5,'Lapangan Voli').
loc(8,6,'Tangga').
loc(8,7,'Lapangan Cinta').
loc(8,8,'Taman Plano').
loc(8,9,'Parkir Motor').
loc(8,10,'Ayam Goang').
loc(9,1,'Parkir Motor').
loc(9,2,'Lapangan Sipil').
loc(9,3,'Lapangan Sipil').
loc(9,4,'Jalan Aspal').
loc(9,5,'Parkir Sepeda').
loc(9,6,'Tangga').
loc(9,7,'ATM Center').
loc(9,8,'LFM').
loc(9,9,'Parkir Mobil').
loc(9,10,'Nasi Korea').
loc(10,1,'Gedung Sipil').
loc(10,2,'Lapangan Sipil').
loc(10,3,'Lapangan Sipil').
loc(10,4,'Aula Barat').
loc(10,5,'ATM Center').
loc(10,6,'Jam Gadang').
loc(10,7,'Aula Timur').
loc(10,8,'Lapangan SR').
loc(10,9,'Lapangan SR').
loc(10,10,'Lapangan SR').

/* default inventory */
maxinventory(5).

/*default deadzone*/

disDeadzone(1).

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
