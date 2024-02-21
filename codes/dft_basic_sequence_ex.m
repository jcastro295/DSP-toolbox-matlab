%% dft_basic_sequence_ex.m
%
% This script provides an example for using the coded DFT function.
% It compares the outputs and elapsed time between DFT and FFT

clc; clear; close all;

addpath("tools")

% generate a simple 9-point sequence
xn = [1 4 9 16 25 36 49 64 81];
N = 9; % Number of points for DFT/FFT

% DFT computation
tic
Xk_dft = dft(xn, N); 
% Xk_dft = dft_for_loop(Xk, N);  %foor loop version
dft_time = toc;
fprintf('DFT computation time: %2.5f seconds \n', dft_time)

figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.6])

subplot(2,2,1); 
stem(0:N-1,abs(Xk_dft), 'LineWidth', 1.5); 
title('Magnitude of the DFT sequence', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Magnitude', 'FontSize', 12); 
grid on

subplot(2,2,3); 
stem(0:N-1, angle(Xk_dft), 'LineWidth', 1.5); 
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
stem(0:N-1, abs(Xk_fft), 'LineWidth', 1.5); 
title('Magnitude of the FFT sequence', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Magnitude', 'FontSize', 12); 
grid on

subplot(2,2,4); 
stem(0:N-1, angle(Xk_fft), 'LineWidth', 1.5); 
title('Phase of the FFT sequence', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Phase', 'FontSize', 12); 
grid on
