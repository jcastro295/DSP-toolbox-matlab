%% even_odd_signal_synthesis.py
%
% This script demonstrates the synthesis of a signal x(n) into its even and odd
% parts x_e(n) and x_o(n) using the evenodd function.

clc; clear; close all;

addpath("tools")

n = 0:10;

x1 = stepseq(0,0,10);
x2 = stepseq(10,0,10);
x = x1 - x2;

[xe,xo,m] = evenodd(x,n);

% x(n) = u(n-n0); n1 <= n,n0 <= n2
subplot(2,2,1)

stem(0:length(x1)-1, x1)
hold on
stem(0:length(x2)-1, x2, 'LineStyle', '--')
title('x_1(n) = u(n) | x_2(n) = u(n-10)')
xlabel('n');
ylabel('x_1(n) | x_2(n)'); 
axis([-10,10,0,1.2])

subplot(2,2,2); 
stem(n,x); 
title('Rectangular pulse [x(n) = x_1(n) - x_2(n)]')
xlabel('n');
ylabel('x(n)'); 
axis([-10,10,0,1.2])

subplot(2,2,3); 
stem(m,xe); 
title('Even Part [x_e(n) = 0.5*(x(n) + x(-n))]')
xlabel('n');
ylabel('x_e(n)');
axis([-10,10,0,1.2])

subplot(2,2,4);
stem(m,xo);
title('Odd Part [x_o(n) = 0.5*(x(n) - x(-n))]')
xlabel('n');
ylabel('x_o(n)');
axis([-10,10,-0.6,0.6])