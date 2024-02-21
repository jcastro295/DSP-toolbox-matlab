%% dft_noisy_signal_ex.m
%
% This script provides an example for using the coded DFT function.
% It compares the outputs and elapsed time between DFT and FFT

clc; clear; close all;

addpath("tools")

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
N = 1500;             % Length of signal - Number of points for DFT/FFT
t = (0:N-1)*T;        % Time vector
f = Fs/N*(0:N-1);     % Frequency vector

% generate a composite of noisy sine signals at 50 & 120 Hz
S = 0.8 + 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
xn = S + 2*randn(size(t));

% DFT computation
tic
Xk_dft = dft(xn, N);
% Xk_dft = dft_for_loop(Xk, N);  %foor loop version
dft_time = toc;
fprintf('DFT computation time: %2.5f seconds \n', dft_time)

figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.6])

subplot(2,2,1); 
plot(f, abs(Xk_dft), 'LineWidth', 1.5); 
title ('Magnitude of the DFT sequence', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Magnitude', 'FontSize', 12); 
grid on

subplot(2,2,3); 
plot(f, angle(Xk_dft), 'LineWidth', 1.5); 
title('Phase of the DFT sequence', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Phase', 'FontSize', 12); 
grid on

% FFT computation
tic 
Xk_fft = fft(xn, N);
fft_time = toc;
fprintf('FFT computation time: %2.5f seconds \n', fft_time)

subplot(2,2,2); 
plot(f, abs(Xk_fft), 'LineWidth', 1.5); 
title ('Magnitude of the FFT sequence', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Magnitude', 'FontSize', 12); 
grid on

subplot(2,2,4); 
plot(f, angle(Xk_fft), 'LineWidth', 1.5); 
title('Phase of the FFT sequence', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Phase', 'FontSize', 12); 
grid on
