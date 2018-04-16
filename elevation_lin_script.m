%%% ELEVATION/Z AXIS %%%

el_lin_tf = tf([1.096],[1 0 0]); %from Simulink Linear Analysis tool
el_lin_ss = ss(el_lin_tf);

stepMag = 10; %m

%PID tuning from PID Tuner in simulink
Kp = 2.3948;
Ki = 0.1397;
Kd = 9.1206;
N = 1142.82798;

C = pid(Kp,Ki,Kd); %implement PID controller

T = feedback(C*el_lin_tf,1); %closed loop transfer function of system

t = 0:0.01:5;
figure(1)
step(stepMag*T,t); %plot closed loop step response
ylabel('elevation (m)');
title('Elevation Axis, Step Response with PID Control');
grid
stepinfo(stepMag*T) %handy step response stats

%figure(2)
%bode(T) %generate bode plot
%title('Closed-loop Bode Plot');
%grid


%Controllability
co = ctrb(el_lin_ss); % controllability matrix, co
rank(co); %should be 2 if controllable

%LQR
Q = el_lin_ss.C'*el_lin_ss.C;
Qgain = 200;
R = 1;
Nbar = 14.14;

Klqr = lqr(el_lin_ss.A, el_lin_ss.B, Q*Qgain, R);

Ac = [(el_lin_ss.A-el_lin_ss.B*Klqr)];
Bc = [el_lin_ss.B];
Cc = [el_lin_ss.C];
Dc = [el_lin_ss.D];

states = {'z' 'z_dot'};
inputs = {'r'};
outputs = {'z'};

sys_cl = ss(Ac,Bc,Cc,Dc);%,'statename',states,'inputname',inputs,'outputname',outputs);

figure(3)
step(stepMag*Nbar*sys_cl,t)
ylabel('elevation (m)');
title('Elevation Axis, Step Response with LQR Control')
stepinfo(stepMag*Nbar*sys_cl) %handy step response stats
grid

figure(4)
step(stepMag*T,stepMag*Nbar*sys_cl,t)
ylabel('elevation (m)');
title('Elevation Axis, PID vs LQR Step Response')
legend('PID','LQR')
grid

