%% convolution_ex1.m
%
% This script demonstrates the convolution of two sequences x(n) and 
% h(n) to obtain the output sequence y(n).

close all; clear; clc;

addpath('tools')


n = -5:50;

u1 = stepseq(0,-5,50); 
u2 = stepseq(10,-5,50);

% input x(n)
x = u1-u2;

% impulse response h(n)
h = ((0.9).^n).*u1;

subplot(3,1,1); 
stem(n,x); 
axis([-5,50,0,2])
title('Input Sequence x(n)')
xlabel('n'),
ylabel('x(n)')

subplot(3,1,2);
stem(n,h);
axis([-5,50,0,2])
title('Impulse Response h(n)')
xlabel('n'),
ylabel('h(n)');

% output response
y = (10*(1-(0.9).^(n+1))).*(u1-u2)+(10*(1-(0.9)^10)*(0.9).^(n-9)).*u2;

subplot(3,1,3);
stem(n,y);
axis([-5,50,0,8])
title('Output Sequence y(n) = x(n)*h(n) (* represents the convolution operator))')
xlabel('n'),
ylabel('y(n)')