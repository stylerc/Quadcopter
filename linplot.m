%%% This file plots the linearized regions of the elevation axis vs the
%%% actual elevation axis.

figure
u=0:.1:pi;
phi=0:.01:pi/2;
z=-g+(g*m)/m*cos(phi);
plot(phi,z)
hold on
z2=-g+(g*m)/m*.8628-(g*m)/m*.5055*(phi-.53);
plot(phi,z2)
z3=(-g+(g*m)/m)*ones(length(phi));
plot(phi,z3)
