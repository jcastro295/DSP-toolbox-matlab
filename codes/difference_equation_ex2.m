%% difference_equation_ex2.py
%
% This script demonstrates the calculation of the output of a discrete-time system
% given its difference equation coefficients using for loop and filter function.

clc; clear; close all;

%% Example #1
% Consider the following difference equation
% y(k+1) = -2y(k) + 3y(k-1) + 1.5x(k) + 4x(k-1)
% where u = [-1, 2, 3, -4], with initial conditions 
% y(0) = 1 and y(1) = 1

x = [1 -2 3 -4]; % vector x
n_terms = length(x);
y(1) = 1;        % initial condition 
y(2) = 1;        % initial condition

for k = 2:n_terms
   y(k+1) = -2*y(k) + 3*y(k-1) + 1.5*x(k) + 4*x(k-1);
end

fprintf('Ex1. For loop solution, y(5) = %d\n', y(5));
disp(y)


%% Example #2
% Consider a difference equation:
% 8*y(n) - 6*y(n-1) + 2*y(n-2) = 1
% with initial condition y(0) = 0 and y(-1) = 2

n_terms = 100;
y = zeros(1, n_terms);  % Pre-allocate
y(1) = 2;
y(2) = 0;

for k = 3:n_terms
  y(k) = (1 + 6*y(k-1) - 2*y(k-2))/8;
end

disp('Ex2. For loop solution, y(97:100)')
disp(y(end-3:end));


%% Example 3
% Consider a difference equation
% y(n+1) = 5/2y(n) +y(n-1),
% with initial condition y(0) = 1, y(1) = 1 
n_terms = 50;
y = zeros(1,n_terms) ; 
y(1) = 1;
y(2) = 1;

for i = 2:n_terms-1
  y(i+1) = 5/2*y(i) + y(i-1); 
end
disp('Ex3. For loop solution, y(47:50)')
disp(y(end-3:end))

% instead of using a for loop, we can compute using 
% the built-in filter function from matlab
a = [1, -5/2, -1]; % y(n) coefficients
b = 0;             % x(n) coefficients
ic = [1, 1];       % initial conditions
y = [ic(1), filter(b, a, ones(1, n_terms-1), ic)];

disp('Ex3. Filter function solution, y(47:50)')
disp(y(end-4:end))