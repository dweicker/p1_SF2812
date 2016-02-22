SETS
  I    cities     /Sto, Lon, Par, Ber, War, Mad, Rom/
  K    traffic    /A,B,C/;

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

TABLE    DEMSUP2(K,I) extra demand and supply
         Ber     Mad
C        1       -1;

VARIABLES  X(I,J,K)  traffic from i to j with type k
           factor  maximum flow Berlin to Madrid;

POSITIVE VARIABLE X;

EQUATIONS
    CAPACITY(I,J)  we do not exceed cap
    BALANCE(I,K) we have conservation of flow;

CAPACITY(I,J).. sum(K,X(I,J,K)+X(J,I,K)) =l= (CAP(I,J)+CAP(J,I));
BALANCE(I,K).. sum(J,X(I,J,K)) =e= sum(J,X(J,I,K)) + DEMSUP(K,I) + factor*DEMSUP2(K,I);

MODEL NETT /ALL/;

SOLVE NETT USING LP MAXIMIZING factor;

DISPLAY X.L, factor.L;
