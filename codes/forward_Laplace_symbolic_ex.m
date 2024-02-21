%% forward_Laplace_symbolic_ex.m
%
% Symbolic Forward Laplace Transform
% Retrieved from Mathworks documentation
% https://www.mathworks.com/help/symbolic/sym.laplace.html
% F = laplace(f,var,transVar)

clear; clc; close all;

% define symbolic variables
syms a t s x y positive

% Ex 1. Compute the Laplace transform of 1/sqrt(x). 
f = 1/sqrt(x);
F = laplace(f);
fprintf('Ex1. 1/sqrt(x)\n')
pretty(F)

% Ex 2. Compute the Laplace transform of exp(-a*t). 
f = exp(-a*t);
F = laplace(f);
fprintf('\nEx2. exp(-a*t)\n')
pretty(F)

% Ex 3. Compute the Laplace transforms of the Dirac and Heaviside functions.
F = laplace(dirac(t-a),t,s);
fprintf('\nEx3.1. Dirac and Heaviside function\n')
pretty(F)

F = laplace(heaviside(t-a),t,s);
fprintf('\nEx3.2. heaviside(t-a)\n')
pretty(F)

% Ex 4. Show that the Laplace transform of the derivative of a function is 
% expressed in terms of the Laplace transform of the function itself.
syms f(t) s
Df = diff(f(t),t);
F = laplace(Df,t,s);
fprintf('\nEx4. Laplace transform of the derivative\n')
pretty(F)