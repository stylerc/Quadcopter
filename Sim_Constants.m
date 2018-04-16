%---- Simulation Constants -----
g = 9.8; %m/s gravity
m = 3.65; %kg, quadcopter mass
wb = 0.6; %m, quadcopter wheelbase

Izz = 16.25e-2;  %added 4/16 by Dan D. 

dair = 1.225; %density of air
cdrag = 1.3; %coeff of drag
aetop=.8494; %effective area of top of qc
aeside=aetop/10; %effective area of side of qc
aefront=aetop/10;  %effective area of front of qc 




%------------- K filter constants ------------

KfilterR=.1;
KfilterQ=.0001;
