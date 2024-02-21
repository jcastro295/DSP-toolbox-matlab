%% inverse_Laplace_symbolic_ex.m
%
% Symbolic Inverse Laplace Transform
% Retrieved from Mathworks documentation
% https://www.mathworks.com/help/symbolic/sym.ilaplace.html
% f = ilaplace(F,var,transVar)

clear; clc; close all;

% define symbolic variables
syms a s t positive

% Ex 1. Compute the inverse Laplace transform of 1/s^2.
F = 1/s^2;
f = ilaplace(F);
fprintf('Ex1. 1/s^2\n')
pretty(f)

% Ex 2. Compute the inverse Laplace transform of 1/(s-a)^2.
F = 1/(s-a)^2;
f = ilaplace(F);
fprintf('\nEx2. 1/(s-a)^2\n')
pretty(f)

% Ex 3. Compute the following inverse Laplace transforms that involve the 
% Dirac and Heaviside functions.
f1 = ilaplace(1,s,t);
fprintf('\nEx3.1. Dirac\n')
pretty(f1)

F = exp(-2*s)/(s^2+1);
f2 = ilaplace(F,s,t);
fprintf('\nEx3.2. Heaviside\n')
pretty(f2)

% Ex 4. Create two functions f(t)=heaviside(t) and g(t)=exp(−t). Find the 
% Laplace transforms of the two functions by using laplace.
% Because the Laplace transform is defined as a unilateral or one-sided 
% transform, it only applies to the signals in the region t≥0.
f(t) = heaviside(t);
g(t) = exp(-t);
F = laplace(f);
G = laplace(g);

h = ilaplace(F*G);
fprintf('\nEx4. h(t)\n')
pretty(h)

% According to the convolution theorem for causal signals, the inverse 
% Laplace transform of this product is equal to the convolution.
syms tau
conv_fg = int(f(tau)*g(t-tau),tau,0,t);
fprintf('\nEx4. conv_fg\n')
pretty(conv_fg)
