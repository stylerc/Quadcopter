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

m = 3.65; %kg, quadcopter mass
wb = 0.6; %m, quadcopter wheelbase

%----- Motor Parameteres -----
R = 0.0005; %electric resistance (Ohm)
L = 0.0003 % electric inductance (H)
b = 0.0009; % motor viscous friction constant (N.m.s)
J = 0.0008; % moment of inertia of the rotor (kg.m^2)
K = 0.001; % electromotive force constant / motor torque constant (RPM/V)

%Constants for thrust equation
pitch = 7; %inches
d = 20; %propeller diameter
v0 = 0; %airspeed in Z
x1 = 4.392399*10^-8;
x2 = 4.23333*10^-4;


%---- Simulation Constants -----
g = 9.8; %m/s gravity
