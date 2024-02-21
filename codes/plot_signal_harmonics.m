%% plot_signal_harmonics.m
%
% This script demonstrates how to plot the sinusoidal components of a complex signal
% x(t) = 0.0771*exp(j2*pi*100*t) - 0.8865*exp(j2*pi*200*t) + 4.8001*exp(-j2*pi*250*t) 
% + 0.1657*exp(-j2*pi*1600*t) + 0.4723*exp(-j2*pi*1700*t)

clear; close all; clc;

fs = 10000;
ZZ = 10000 * [ 0.0771 + 1i*1.2202;
              -0.8865 + 1i*2.8048;
               4.8001 - 1i*0.8995;
	           0.1657 - 1i*1.3520;
	           0.4723            ];
%
Fo = 100;
ff = Fo * [ 2, 4, 5, 16, 17 ];  %-- row
dur = 4/Fo;
tt = 0 : (1/fs) : dur;
xi =  exp( -2i*pi*tt'*ff );   %--- components
xx =  xi * ZZ;
%
dur_long = 1.5;
ttt = 0 : (1/fs) : dur_long;

tms = tt*1000;   %--- convert to msec

fh = figure('Units', 'normalized', 'Position', [0.1,0.1,0.4,0.8]);
subplot(5,1,1)
jkl = 1;
x1 = xi(:,jkl)*ZZ(jkl);
hp = plot(tms, real(x1));
set(hp, 'LineWidth', 2)
title('x = Re(A_2 exp(j*2*\pi*2*f_0*t))', 'FontSize', 16)
set(gca,'FontSize', 12)
ylabel('Amplitude', 'FontSize', 14)
xxx = real(exp(-2i*pi*ttt'*ff(jkl))*ZZ(jkl));
sound(xxx/max(abs(xxx)), fs);
disp('First harmonic played. Press any key to continue...')
pause()

jkl = 1:2;
x12 = xi(:,jkl) * ZZ(jkl);
subplot(5,1,2)
hp = plot(tms, real(x12));
set(hp,'LineWidth', 2)
title('x = x + Re(A_4 exp(j*2\pi*4*f_0*t))', 'FontSize', 16)
set(gca,'FontSize', 12)
ylabel('Amplitude', 'FontSize', 14)
xxx = real(exp(-2i*pi*ttt'*ff(jkl))*ZZ(jkl));
sound( xxx/max(abs(xxx)), fs);
disp('Two harmonics played. Press any key to continue')
pause()

%----------
jkl = 1:3;
x123 = xi(:,jkl) * ZZ(jkl);
subplot(5,1,3)
hp = plot( tms, real(x123) );
set(hp,'LineWidth',2)
title('x = x + Re(A_5 exp(j*2\pi*5*f_0*t))', 'FontSize',16)
set(gca,'FontSize',12)
ylabel('Amplitude','FontSize',14)
xxx = real(exp( -2i*pi*ttt'*ff(jkl) )*ZZ(jkl));
sound( xxx/max(abs(xxx)), fs);
disp('Three harmonics played. Press any key to continue')
pause()

%
jkl = 1:4;
x1234 = xi(:,jkl) * ZZ(jkl);
subplot(5,1,4)
hp = plot(tms, real(x1234));
set(hp,'LineWidth', 2)
title('x = x + Re(A_{16} exp(j*2\pi*16*f_0*t))', 'FontSize', 16)
set(gca,'FontSize', 12)
ylabel('Amplitude','FontSize', 14)
xxx = real(exp(-2i*pi*ttt'*ff(jkl))*ZZ(jkl));
sound( xxx/max(abs(xxx)), fs);
disp('Four harmonics played. Press any key to continue')
pause()

%------
subplot(5,1,5)
hp = plot(tms, real(xx));
grid on;
set(hp,'LineWidth', 2)
title('x = x + Re(A_{17} exp(j*2\pi*17f_0t))', 'FontSize', 16)
set(gca, 'FontSize', 12)
xlabel('time (msec)', 'FontSize', 14);
ylabel('Amplitude', 'FontSize', 14)
jkl = 1:5;
xxx = real(exp(-2i*pi*ttt'*ff(jkl))*ZZ(jkl));
sound( xxx/max(abs(xxx)), fs);
disp('Five harmonics played')
