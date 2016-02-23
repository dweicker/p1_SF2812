**************************************************
* SF2812 : Project 1A
* Linear program modeling the third question of
* project
*
* February 2016
* Author : Petter Aronson, Henrik Ekestam, David Weicker
**************************************************

sets
i cities /Sto,Lon,Par,Ber,War,Mad,Rom/
k traffic /A,B,C/;

alias(i,j);

table cap(i,i) capacities of the network
        Lon     Par     Ber     War     Mad     Rom
Sto     11      14      25      30
Lon             21                      17
Par                     22              31      19
Ber                             26              18
War                                     18      22
Mad                                             15;

variables
    x(i,j,k) flow going from i to j
    ent   maximum flow from Berlin to Madrid;

table e(k,i) flows entering and leaving the system
        Sto     Rom     Lon     War
A       50      -50
B                       40      -40;

positive variable x;

equations
    capacities(i,j)  we do not exceed cap
    conservation(i,k) we have conservation of flow;

capacities(i,j).. sum(k,x(i,j,k)+x(j,i,k)) =l= (cap(i,j)+cap(j,i));
conservation(i,k).. sum(j,x(i,j,k)) =e= sum(j,x(j,i,k)) + e(k,i) + ent$(ord(i) eq 6 AND ord(k) eq 3) - ent$(ord(i) eq 4 AND ord(k) eq 3);

model part1 /all/;

solve part1 using lp maximizing ent;

display x.l;