%EVERYTHING IN HERE IS FINAL (unless we want to change it)

roll_lin_tf = tf([3.1646],[1 0 0]); %from Simulink Linear Analysis tool
roll_lin_ss = ss(roll_lin_tf);

stepMag = 0.2; %rad, ~11deg

%PID tuning from PID Tuner in simulink
Kp = 1.0032;
Ki = 0.20242;
Kd = 1.2268;
N = 41.7603;

C = pid(Kp,Ki,Kd); %implement PID controller

T = feedback(C*roll_lin_tf,1); %closed loop transfer function of system

t = 0:0.01:5;
figure(1)
step(stepMag*T,t); %plot closed loop step response
ylabel('roll angle (rad)');
title('Closed-loop Step Response');
grid
stepinfo(stepMag*T) %handy step response stats

%figure(2)
%bode(T) %generate bode plot
%title('Closed-loop Bode Plot');
%grid


%Controllability
co = ctrb(roll_lin_ss); % controllability matrix, co
rank(co); %should be 2 if controllable

%LQR
Q = roll_lin_ss.C'*roll_lin_ss.C;
Qgain = 200;
R = 1;
Nbar = 14.14;

Klqr = lqr(roll_lin_ss.A, roll_lin_ss.B, Q*Qgain, R);

Ac = [(roll_lin_ss.A-roll_lin_ss.B*Klqr)];
Bc = [roll_lin_ss.B];
Cc = [roll_lin_ss.C];
Dc = [roll_lin_ss.D];

states = {'phi' 'phi_dot'};
inputs = {'r'};
outputs = {'phi'};

sys_cl = ss(Ac,Bc,Cc,Dc);%,'statename',states,'inputname',inputs,'outputname',outputs);

figure(3)
step(stepMag*Nbar*sys_cl,t)
ylabel('roll angle (rad)');
title('Step Response with LQR Control')
stepinfo(stepMag*Nbar*sys_cl) %handy step response stats
grid

figure(4)
step(stepMag*T,stepMag*Nbar*sys_cl,t)
ylabel('roll angle (rad)');
title('PID vs LQR Step Response')
legend('PID','LQR')
grid








