clc;
clear;

%G(s) = K / (s^2 - w0^2)
% w0 = sqrt(g/L)
% K = 1/(mL^2)

%specifying system parameters
m = 1;
L = 1;
g = 9.81;
w0 = sqrt(g/L);
K_nominal = 1 / (m*(L^2));
numG = K_nominal;
denG = [1 0 -w0^2];
G = tf(numG, denG);

% PID = D(s) = Kp + Ki/s + kd*s;
%controller parameters:
Kp = 40;
Ki = 10;
Kd = 5;
D = pid(Kp, Ki, Kd);


% Pertubed Plant
%To show robustness, we use 20% heavier system; thus effective
%gain drops by 20%
K_pertubed = K_nominal / 1.20;
K_pertubed2 = K_nominal / 1.90;
Gp = tf(K_pertubed, denG);
Gp2 = tf(K_pertubed2, denG);

% G, Gp are open loop transfer function


% Closed Loop Transfer Function

% 1. Reference Tracking:
% T(s) = G(s)*D(s) / (1 + G(s)*D(s))
T = feedback(G*D, 1);
TP = feedback(Gp*D, 1);
TP2 = feedback(Gp2*D, 1);

% Disturbance Rejection:
% If a torque response W(s) enters at the plant input,
% the output response is:
% theta(s)|W = (G(s) / (1 + G(s)*D(s)))*W(s) = G(s)*S(s)*W(s)
%where S(s) = 1 / (1 + GD) => Sensitivity
Td = G*inv(1 + G*D);
Tdp = Gp*inv(1 + Gp*D);
Tdp2 = Gp2*inv(1 + Gp2*D);

%Sensitvity Function
%S(s) = 1 / (1 + G(s)D(s))
sfunc = feedback(1, G*D);


%Comparisons:
t = 0:0.001:10;

%Reference
y_nom = step(T, t);
y_per = step(TP, t);
y_per2 = step(TP2, t);
figure(1);
subplot(3,1,1);
plot(t, y_nom, 'b', t, y_per, 'r--', t, y_per2, 'b--', LineWidth=2);
title("Closed-Loop Step (R->theta)")
xlabel('Time(s)'); ylabel('Tilit theta(t)');
legend('Nominal', '+20% mass', '+90% mass');
grid on;

%Disturbance
w_nom = step(Td, t);
w_per = step(Tdp,t);
w_per2 = step(Tdp2, t);
subplot(3,1,2);
plot(t, w_nom,'b', t, w_per,'r--', t, w_per2, 'b--', LineWidth = 2);
title('Closed-Loop Step to Disturbance (W → Theta)');
xlabel('Time (s)'); ylabel('Tilt Theta(t)');
legend('Nominal','+20% mass', '+90% mass');
grid on;

%Sensitivity
subplot(3,1,3);
bode(sfunc), grid on;
title('Sensitivity |S(j\omega)|');

saveas(gcf, sprintf("PID_plot_pg.png"));
