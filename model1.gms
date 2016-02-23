**************************************************
* SF2812 : Project 1A
* Linear program modeling the first question of
* project
*
* February 2016
* Author : Petter Aronson, Henrik Ekestam, David Weicker
**************************************************


SETS
  I    cities     /Sto, Lon, Par, Ber, War, Mad, Rom/
  K    traffic    /A,B/;

ALIAS(I,J);

TABLE   CAP(I,I) in gbits
       Lon     Par     Ber     War     Mad     Rom
Sto     11      14      25      30
Lon             21                      17
Par                     22              31      19
Ber                             26              18
War                                     18      22
Mad                                             15;

TABLE   DEMSUP(K,I)  demand and supply
         Sto     Rom     Lon     War
A        50      -50
B                        40      -40;

VARIABLES  X(I,J,K)  traffic from i to j with type k
           maxX      utility;

POSITIVE VARIABLE X;

EQUATIONS
    CAPACITY(I,J) traffic limitations
    BALANCE(I,K)  conservation of flow
    EXCEED        cannot exceed capacity;

CAPACITY(I,J).. sum(K,X(I,J,K)+X(J,I,K)) =l= maxX*(CAP(I,J)+CAP(J,I));
BALANCE(I,K)..  sum(J,X(I,J,K)) =e= sum(J,X(J,I,K)) + DEMSUP(K,I);
EXCEED..        maxX =l= 1;

MODEL NETT /ALL/;

option limrow = 49;

SOLVE NETT USING LP MINIMIZING maxX;

DISPLAY X.L, maxX.L;
