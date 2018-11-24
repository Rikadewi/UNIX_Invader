UNIX_Invader
============

Sebuah game survival sederhana yanng memanfaatkan bahasa pemrograman logika ,yaitu PROLOG.

Prerequisites dan Setting
-------------------------

Prerequisite
------------
- GNU Prolog 1.3.0 (or higher)

Setting 
---------
- Windows user:
	1. Setting Variabel Environments dengan cara:
		Control Panel > System > Advanced System > Environment Variable
	2. Copy lokasi penyimpanan (bin) GNU Prolog ke bagian PATH di Environment VAriable
		PATH > New
	3. Untuk mengecek apakah GNU Prolog sudah dapat dipakai bisa melalui terminal/cmd, ketikan: 
		gplc --version
- Linux user (Ubuntu):
	1. Download GNU Prolog compiler .deb dari website GNU Prolog atau menggunakan terminal
		sudo apt install gprolog
	2. Untuk mengecek apakah GNU Prolog sudah terinstall bisa melalui terminal
		gprolog

Cara Menjalankan Program
-------------------------
- Windows user:
Cara I:
	- Ketik manual direktori file yang dituju		 
	- ketik	consult('main.pl').
Cara II:
	- buka File > Consult
	- pilih file main.pl

- Linux User:

Open terminal lalu buka gprolog
	gprolog

Kemudian masukkan nama file yang dituju
	consult('main.pl').

Selamat Bermain, warga UNIX!

