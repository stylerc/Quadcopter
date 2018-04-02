% From feasibility report


%----- Physical Parameters -----
% frame is X shaped, symmetrical

% Reference: F3-DP-2017-Gopalakrishnan-Eswarmurthi-Master Thesis.pdf
% x is forward
% y is to the left
% z is upward

% roll angle (?) rotation around the x axis.
% pitch angle (?) rotation around the y axis.
% yaw angle (?) rotation around the z axis.

%----- Initial Conditions -----
xinitial=0;
yinitial=0;
zinitial=0;
phiinitial=0;
thetainitial=0;
psiinitial=0;

xvelinitial=0;
yvelinitial=0;
zvelinitial=0;
phivelinitial=0;
thetavelinitial=0;
psivelinitial=0;

xaccinitial=0;
yaccinitial=0;
zaccinitial=0;
phiaccinitial=0;
thetaaccinitial=0;
psiaccinitial=0;

%----- Motor Parameteres -----
Motor_Parameters;



%----- Controller Tuning
Controller_Tuning;


%---- Simulation Constants -----
Sim_Constants;



