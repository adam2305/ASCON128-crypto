# ASCON128-crypto

# Table des matières
 - [Introduction](#introduction)
 - [Structure du projet](#structure-du-projet)
 - [Licence](licence)

# Introduction
Le but de est d'utiliser le language de description matérielle Systemverilog pour concevoir un circuit 
permettant de chiffre un mesage sur 256 bit à l'aide de l'algorithme ASCON128.
Le projet est exhaustif et présente aussi l'ensemble des test qui ont étés réalisés sur chaque composant.

# Structure
chiers liés aux architectures Systemverilog sont situés dans le répertoire "/SRC",
pour ce projet deux bibliothèques associées on étés mises en place pour faciliter la compilation
et l'exécution : "LIB_RTL" et "LIB_BENCH".
Les chiers de testbench se trouvent dans le répertoire "SRC/BENCH". Les chiers de
testbench sont facilement identiables grâce à leur nom du type xxx_tb.sv.
De plus, il existe un répertoire (SRC/RTL) qui contiennen les chiers décrivant l'architecture
du circuit des diérents composants.
Enn le projet comprend le pakcage "ascon_pack",ce dernier englobe les dénitions de
types couramment utilisés, tels que la structure type_state.

