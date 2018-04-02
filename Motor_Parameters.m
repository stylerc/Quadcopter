%----- Motor Parameteres -----
V_bat = 44.4; %battery voltage (V) 
R = 0.000230; %electric resistance (Ohm), .0005
L = 0.000224; % electric inductance (H)
b = 0.0015; % motor viscous friction constant (N.m.s)
J = 0.00007; % moment of inertia of the rotor (kg.m^2)
Ke = 0.001; % electromotive force constant 
Kt = 0.001;    % motor torque constant 
idle = 0; % idle motors to reduce initial "slack"

%Constants for thrust equation
pitch = 7; %inches
d = 20; %propeller diameter
v0 = 0; %airspeed in Z
x1 = 4.392399*10^-8;
x2 = 4.23333*10^-4;

