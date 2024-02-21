%% idft_basic_sequence_ex.py
%
% This script provides an example for using the coded IDFT function.
% It compares the outputs and elapsed time between IDFT and IFFT

clc; clear; close all;

addpath("tools")

% generate a simple 9-point sequence
Xk = [1 2 3 4 5 9 8 7 6 5];
N = 9; % Number of points for IDFT/IFFT

% IDFT computation
tic
xn = idft(Xk, N); 
% xn = idft_for_loop(Xk, N);  %foor loop version
idft_time = toc;
fprintf('IDFT computation time: %2.5f seconds \n', idft_time)


figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.4])

subplot(1,2,1)
stem(0:N-1, real(xn), 'LineWidth', 1.5); 
title('Recovered signal (IDFT)', 'FontSize', 14); 
xlabel('Time', 'FontSize', 12); 
ylabel('Amplitude', 'FontSize', 12); 
grid on


% IFFT computation
tic 
xn_ifft = ifft(Xk, N);
fft_time = toc;
fprintf('IFFT computation time: %2.5f seconds \n', fft_time)

subplot(1,2,2)
stem(0:N-1, real(xn_ifft), 'LineWidth', 1.5); 
title('Recovered signal (IFFT)', 'FontSize', 14); 
xlabel('Time', 'FontSize', 12); 
ylabel('Amplitude', 'FontSize', 12); 
grid on
