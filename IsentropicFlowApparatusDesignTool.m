%% Rocket Calc Stuff

clear; clc; close all;


%% Inputs

h = 7.4;
Dc = 3.5;
V = 1.6387*10^(-5)*h*pi*(Dc/2)^2;
d = 0.1;
D = .0254*d;
Pt = 3.447*10^6;
gamma = 1.289;
R = 287.05;
Tt = 300;

rho = 40.84; %estimated
mi = 40.84*V;


%% Preparation Calculations

A = pi*D^2*0.25;

mdoti= ((A*Pt)/(sqrt(Tt)))*(sqrt(gamma/R))*((gamma+1)/2)^(-1*((gamma+1)/(2*(gamma-1))));

F = 550*mdoti;


%% For loop

Time = 2.5;
dt = 0.01;
steps = Time/dt;
time = 0:dt:Time-dt;


mdot = zeros(1,steps);
P = zeros(1,steps);
P(1) = Pt;
T = zeros(1,steps);
T(1) = Tt;
m = zeros(1,steps);
m(1) = mi;
f = zeros(1,steps);
f(1) = F;
v = 550;


for i = 1:steps
    mdot(i) = ((A*P(i))/(sqrt(T(i))))*(sqrt(gamma/R))*((gamma+1)/2)^(-1*((gamma+1)/(2*(gamma-1))));
    m(i+1) = m(i)-mdot(i)*dt;
    P(i+1) = (R*T(i)*m(i+1))/(V);
    T(i+1) = 0.999*T(i);
    f(i) = mdot(i)*v*(P(i)/P(1));
end


%% Plots 

figure
plot(time,f);
xlabel('Time(s)');
ylabel('Force(N)');
title('Impulse (Metric)');

figure
plot(time,f*0.2248);
xlabel('Time(s)');
ylabel('Force(lb)');
title('Impulse (Imperial)');


