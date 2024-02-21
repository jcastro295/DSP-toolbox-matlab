%% idft_noisy_signal_ex.py
%
% This script provides an example for using the coded IDFT function.
% It compares the outputs and elapsed time between IDFT and IFFT

clc; clear; close all;

addpath("tools")

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
N = 500;             % Length of signal - Number of points for DFT/FFT
t = (0:N-1)*T;        % Time vector
f = Fs/N*(0:N-1);     % Frequency vector

% generate a composite of noisy sine signals at 10 & 20 Hz
S = 0.8 + 0.7*sin(2*pi*10*t) + sin(2*pi*20*t);
xn = S + 0.5*randn(size(t));

% get X(k) from x(n) using FFT
Xk = fft(xn); 

% IDFT computation
tic
xn_idft = idft(Xk, N); 
% xn_idft = idft_for_loop(Xk, N);  %foor loop version

idft_time = toc;
fprintf('IDFT computation time: %2.5f seconds \n', idft_time)

figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.8, 0.4])

subplot(1,3,1); 
plot(t, xn, 'LineWidth', 1.5); 
title('Original signal x(n)', 'FontSize', 14); 
xlabel('Time', 'FontSize', 12); 
ylabel('Amplitude', 'FontSize', 12); 
grid on

subplot(1,3,2); 
plot(t, real(xn_idft), 'LineWidth', 1.5); 
title('Recovered signal (IDFT)', 'FontSize', 14); 
xlabel('Time', 'FontSize', 12); 
ylabel('Amplitude', 'FontSize', 12); 
grid on

% IFFT computation
tic 
xn_ifft = ifft(Xk, N);
fft_time = toc;
fprintf('IFFT computation time: %2.5f seconds \n', fft_time)


subplot(1,3,3); 
plot(t, real(xn_ifft), 'LineWidth', 1.5); 
title('Recovered signal (IFFT)', 'FontSize', 14); 
xlabel('Time', 'FontSize', 12); 
ylabel('Amplitude', 'FontSize', 12); 
grid on
