****************
*
*
*
*
***************


sets
i cities /Sto,Lon,Par,Ber,War,Mad,Rom/
alias(i,j);

set scenario /low,medium,high/;

parameter fraction(scenario) fraction of change in the capacities
        /low -0.1
         medium 0
         high 0.1/;

table cap(i,i) capacities of the network
        Lon     Par     Ber     War     Mad     Rom
Sto     11      14      25      30
Lon             21                      17
Par                     22              31      19
Ber                             26              18
War                                     18      22
Mad                                             15;

parameter e(i) define the B-flow
        /Sto 50
         Rom -50/;
parameter f(i) define the A-flow
        /Lon 40
         War -40/;

parameter actualCap(i,j,scenario);
actualCap(i,j,scenario) = (1+fraction(scenario))*cap(i,j);

parameter prob(scenario) probabilities of each scenario;
prob(scenario) = 1/3;

variables
    x(i,j) flow going from i to j for the B-flow (must be fixed beforehand)
    y(i,j,scenario) flow going from i to j for the A-flow (can depend on the scenario)
    maxUt(scenario) maximum utility in each scenario
    maxExp   maximum expected utility;

positive variables x,y;
maxUt.up(scenario) = 1;

equations
    capacities(i,j,scenario)  we do not exceed cap
    consB(i) we have conservation of B-flow
    consA(i,scenario) we have conservation of A-flow for every scenario
    objective the objective function we want to minimize;

capacities(i,j,scenario).. x(i,j)+x(j,i)+y(i,j,scenario)+y(j,i,scenario) =l= maxUt(scenario)*(actualCap(i,j,scenario)+actualCap(j,i,scenario));
consB(i).. sum(j,x(i,j)) =e= sum(j,x(j,i)) + e(i);
consA(i,scenario).. sum(j,y(i,j,scenario)) =e= sum(j,y(j,i,scenario)) + f(i);
objective.. maxExp =e= sum(scenario,prob(scenario)*maxUt(scenario));

model part4 /all/;

solve part4 using lp minimizing maxExp;

display x.l;
display y.l;
display maxUt.l;
