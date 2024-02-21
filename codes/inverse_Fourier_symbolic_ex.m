%% inverse_Fourier_symbolic_ex.m
%
% Symbolic Inverse Fourier Transform
% Retrieved from Mathworks documentation
% https://www.mathworks.com/help/symbolic/sym.ifourier.html
% f = ifourier(F,var,transVar)

clear; clc; close all;

% define symbolic variables
syms a w t

% Ex 1. ompute the inverse Fourier transform of exp(-w^2/4).
F = exp(-w^2/4);
f = ifourier(F, t);
fprintf('Ex1. exp(-w^2/4)\n')
pretty(f)

% Ex 2. Compute the inverse Fourier transform of exp(-w^2-a^2). 
F = exp(-w^2-a^2);
f = ifourier(F, t);
fprintf('\nEx2. exp(-w^2-a^2)\n')
pretty(f)

% Ex 3. Compute the inverse Fourier transform of expressions in terms of 
% Dirac and Heaviside functions.
f1 = ifourier(dirac(w), w, t);
fprintf('\nEx3.1. Dirac\n')
pretty(f1)

F = 2*exp(-abs(w))-1;
f2 = ifourier(F,w,t);
fprintf('\nEx3.2. Exponential & Dirac\n')
pretty(f2)

F = exp(-w)*heaviside(w);
f3 = ifourier(F,w,t); 
fprintf('\nEx3.3. Exponential and heaviside\n')
pretty(f3)