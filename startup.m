m = 550; %g, quadcopter mass
g = 9.8; %m/s gravity

%frame is X shaped, symmetrical

% x is forward
% y is to the left
% z is upward

% roll angle (?) rotation around the x axis.
% pitch angle (?) rotation around the y axis.
% yaw angle (?) rotation around the z axis.

%vrot_i is rotor angular velocity, 1-4

%-------Motor Parameteres------

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

%-----------------------------

