****************
*
*
*
*
***************


sets
i cities /Sto,Lon,Par,Ber,War,Mad,Rom/
k traffic /A,B/;

alias(i,j);

table cap(i,i) capacities of the network
        Lon     Par     Ber     War     Mad     Rom
Sto     11      14      25      30
Lon             21                      17
Par                     22              31      19
Ber                             26              18
War                                     18      22
Mad                                             15;

table e(k,i) flows entering and leaving the system
        Sto     Rom     Lon     War
A       -50      50
B                       -40      40;

variables
    x(i,j,k) flow going from i to j
    maxX   maximum utility;

positive variable x;

equations
    capacities(i,j)  we do not exceed cap
    conservation(i,k) we have conservation of flow;

capacities(i,j).. sum(k,x(i,j,k)+x(j,i,k)) =l= maxX*(cap(i,j)+cap(j,i));
conservation(i,k).. sum(j,x(i,j,k)) =e= sum(j,x(j,i,k)) + e(k,i);

model part1 /all/;

solve part1 using lp minimizing maxX;

display x.l;