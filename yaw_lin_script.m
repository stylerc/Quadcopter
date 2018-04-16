%%% YAW AXIS %%%

yaw_lin_tf = tf([7.015e-07],[1 0 0]); %from Simulink Linear Analysis tool
yaw_lin_ss = ss(yaw_lin_tf);

stepMag = 0.2; %rad, ~11deg

%PID tuning from PID Tuner in simulink
Kp = 1.0032;
Ki = 0.20242;
Kd = 1.2268;
N = 41.7603;

C = pid(Kp,Ki,Kd); %implement PID controller

T = feedback(C*yaw_lin_tf,1); %closed loop transfer function of system

t = 0:0.01:5;
figure(1)
step(stepMag*T,t); %plot closed loop step response
ylabel('yaw angle (rad)');
title('Closed-loop Step Response');
grid
stepinfo(stepMag*T) %handy step response stats

%figure(2)
%bode(T) %generate bode plot
%title('Closed-loop Bode Plot');
%grid


%Controllability
co = ctrb(yaw_lin_ss); % controllability matrix, co
rank(co); %should be 2 if controllable

%LQR
Q = yaw_lin_ss.C'*yaw_lin_ss.C;
Qgain = 200;
R = 1;
Nbar = 14.14;

Klqr = lqr(yaw_lin_ss.A, yaw_lin_ss.B, Q*Qgain, R);

Ac = [yaw_lin_ss.A-yaw_lin_ss.B*Klqr];
Bc = [yaw_lin_ss.B];
Cc = [yaw_lin_ss.C];
Dc = [yaw_lin_ss.D];

states = {'psi' 'psi_dot'};
inputs = {'r'};
outputs = {'psi'};

sys_cl = ss(Ac,Bc,Cc,Dc);%,'statename',states,'inputname',inputs,'outputname',outputs);

figure(3)
step(stepMag*Nbar*sys_cl,t)
ylabel('yaw angle (rad)');
title('Step Response with LQR Control')
stepinfo(stepMag*Nbar*sys_cl) %handy step response stats
grid

figure(4)
step(stepMag*T,stepMag*Nbar*sys_cl,t)
ylabel('yaw angle (rad)');
title('Yaw Axis, PID vs LQR Step Response')
legend('PID','LQR')
grid








