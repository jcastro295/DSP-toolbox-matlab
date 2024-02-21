%% forward_Fourier_symbolic_ex.m
% 
% Symbolic Forward Fourier Transform
% Retrieved from Mathworks documentation
% https://www.mathworks.com/help/symbolic/sym.fourier.html
% F = fourier(f,var,transVar)

clear; clc; close all;

% define symbolic variables
syms a b t

% Ex 1. Rectangular pulse. 
f = rectangularPulse(a,b,t);
f_FT = fourier(f);
fprintf('Ex1. Rectangular pulse\n')
pretty(f_FT)

% Ex 2. Unit impulse (Dirac delta). 
f = dirac(t);
f_FT = fourier(f);
fprintf('\nEx2. Unit impulse (Dirac delta)\n')
pretty(f_FT)

% Ex 3. Absolute value
f = a*abs(t);
f_FT = fourier(f);
fprintf('\nEx3. Absolute value\n')
pretty(f_FT)

% Ex 4. Step (Heaviside)
f = heaviside(t);
f_FT = fourier(f);
fprintf('\nEx4. Step (Heaviside)\n')
pretty(f_FT)

% Ex 5. Cosine
f = a*cos(b*t);
f_FT = fourier(f);
fprintf('\nEx5. Cosine\n')
pretty(f_FT)

% Ex 6. Sign
f = sign(t);
f_FT = fourier(f);
fprintf('\nEx6. Sign\n')
pretty(f_FT)

% Ex 7. Right-side exponential
f = exp(-t*abs(a))*heaviside(t);
f_FT = fourier(f);
fprintf('\nEx7. Right-side exponential\n')
pretty(f_FT);