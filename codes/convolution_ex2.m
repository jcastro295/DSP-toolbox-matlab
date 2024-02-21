%% convolution_ex2.m
% 
% This script demonstrates the convolution of two sequences x(n) and
% h(n) to obtain the output sequence y(n).

close all; clear; clc;

addpath("tools")

% input x(n)

x = [3,11,7,0,-1,4,2]; nx = -3:3;

% impulse response h(n)

h = [2,3,0,-5,2,1]; nh = -1:4;


[y,ny] = conv_m(x,nx,h,nh);

% plot signals and convolution
figure;
subplot(2,2,1); 
stem(nx, x); 
title('x(k)');
xlabel('k');

subplot(2,2,2);
stem(nh, h);
title('h(k)');
xlabel('k');

subplot(2,2,3:4);
stem(ny, y);
title('Convolution y(k)=x(k)*h(k)');
xlabel('k');

figure;
% plot x(k) and h(k)

subplot(2,2,1);
stem(nx-0.05,x);
axis([-5,5,-6,12]);
hold on;
stem(nh+0.05,h,':')
title('x(k) and h(k)');
xlabel('k');
text(-0.5,11,'solid: x    dashed: h');
hold off

% plot x(k) and h(-k)

subplot(2,2,2);
stem(nx-0.05,x);
axis([-5,5,-6,12]);
hold on;
stem(-fliplr(nh)+0.05,fliplr(h),':')
title('x(k) and h(-k)');
xlabel('k');
text(-0.5,-1,'n=0')
text(-0.5,11,'solid: x    dashed: h');
hold off

% plot x(k) and h(-1-k)

subplot(2,2,3);
stem(nx-0.05,x);
axis([-5,5,-6,12]);
hold on;
stem(-fliplr(nh)+0.05-1,fliplr(h),':')
title('x(k) and h(-1-k)');
xlabel('k');
text(-1.5,-1,'n=-1')
text(-0.5,11,'solid: x    dashed: h');
hold off

% plot x(k) and h(2-k)

subplot(2,2,4);
stem(nx-0.05,x);
axis([-5,5,-6,12]);
hold on;
stem(-fliplr(nh)+0.05+2,fliplr(h),':')
title('x(k) and h(2-k)');
xlabel('k');
text(2-0.5,-1,'n=2')
text(-0.5,11,'solid: x    dashed: h');
hold off

%print -deps2 ex020600.eps