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

%----- Motor Parameteres -----
V_bat = 44.4; %battery voltage (V) 
R = 0.0005; %electric resistance (Ohm)
L = 0.0003; % electric inductance (H)
b = 0.0009; % motor viscous friction constant (N.m.s)
J = 0.0008; % moment of inertia of the rotor (kg.m^2)
K = 0.001; % electromotive force constant / motor torque constant (RPM/V)

%Constants for thrust equation
pitch = 7; %inches
d = 20; %propeller diameter
v0 = 0; %airspeed in Z
x1 = 4.392399*10^-8;
x2 = 4.23333*10^-4;

%----- Controller Tuning
% Altitude Loop
Kp_alt = 1;
Ki_alt = 1;

Kd_alt = 0;

% Pitch Loop
Kp_pitch = 1;
Ki_pitch = 1;
Kd_pitch = 0;

% Roll Loop
Kp_roll = 1;
Ki_roll = 1;
Kd_roll = 0;

% Yaw Loop
Kp_yaw = 1;
Ki_yaw = 1;
Kd_yaw = 0;


%---- Simulation Constants -----
g = 9.8; %m/s gravity
m = 3.65; %kg, quadcopter mass
wb = 0.6; %m, quadcopter wheelbase

%----- Initial Conditions -----
xinitial=0;
yinitial=0;
zinitial=-10;
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
