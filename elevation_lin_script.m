load elevation_linsys.mat

el_tf = tf(linsys1);
el_ss = ss(linsys1);

%Controllability
co = ctrb(linsys1); % controllability matrix, co
rank(co); %should be 2 if controllable

%LQR
Q = el_ss.C'*el_ss.C;
R = 1;

Klqr = lqr(el_ss.A, el_ss.B, Q, R);