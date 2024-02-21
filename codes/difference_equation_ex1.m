%% difference_equation_ex1.py
%
% This script demonstrates the calculation of impulse response and step response
% of a discrete-time system given its difference equation coefficients. The script
% also checks the stability of the system.

clc; clear; close all;

addpath("tools")

% Given the following difference equation
% y(n) − y(n − 1) + 0.9y(n − 2) = x(n)

a = [1,-1,0.9];
b = 1;

% Part a) Calculate and plot the impulse response h(n) at n = −20,..., 100.

x = impseq(0,-20,120);
n = -20:120;

h = filter(b,a,x);

subplot(2,1,1);
stem(n,h)
axis([-20,120,-1.1,1.1])

title('Impulse Response');
xlabel('n');
ylabel('h(n)');

% Part b) Calculate and plot the unit step response s(n) at n = −20,..., 100.

x = stepseq(0,-20,120);
s = filter(b,a,x);

subplot(2,1,2);
stem(n,s)

axis([-20,120,-.5,2.5])

title('Step Response');
xlabel('n');
ylabel('s(n)')


% Part c) Is the system specified by h(n) stable?

fprintf('sum(|h|) = %2.3f\n', sum(abs(h)));
z = roots(a);
magz = abs(z);
fprintf('roots = %2.3f\n', magz)

disp('Since the magnitudes of both roots are less than one, the system is stable.')


