%% fft_comparison.m
%
% This script provides an example for using the coded DFT function.
% It compares the outputs and elapsed time between DFT and FFT

clc; clear; close all;

addpath("tools")

% generate a simple sequence
% for this fft implementation, Xk must be a power of 2
xn = rand(1, 2^10); % if run out of memory use 2^6 instead
N = length(xn); % Number of points for IDFT/IFFT

% DFT computation
tic
Xk_dft = dft(xn, N); 
% Xk_dft = dft_for_loop(Xk, N);  %foor loop version
dft_time = toc;
fprintf('DFT computation time: %2.5f seconds \n', dft_time)

figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.8, 0.6])

ax1 = subplot(2,3,1); 
stem(0:N-1,abs(Xk_dft), 'LineWidth', 1.5); 
title('Magnitude of the DFT sequence', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Magnitude', 'FontSize', 12); 
xlim([0, N-1])
grid on

subplot(2,3,4); 
stem(0:N-1, angle(Xk_dft), 'LineWidth', 1.5); 
title('Phase of the DFT sequence', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Phase', 'FontSize', 12); 
xlim([0, N-1])
grid on


% FFT computation (using coded fft function)
tic 
Xk_fft = fft_coded(xn);
fft_time = toc;
fprintf('FFT computation time: %2.5f seconds \n', fft_time)

ax2 = subplot(2,3,2); 
stem(0:N-1, abs(Xk_fft), 'LineWidth', 1.5); 
title('Magnitude of the FFT sequence', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Magnitude', 'FontSize', 12); 
xlim([0, N-1])
grid on

subplot(2,3,5); 
stem(0:N-1, angle(Xk_fft), 'LineWidth', 1.5); 
title('Phase of the FFT sequence', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Phase', 'FontSize', 12);
xlim([0, N-1])
grid on


% FFT computation (using Matlab fft function)
tic 
Xk_fft_matlab = fft(xn, N);
fft_time_matlab = toc;
fprintf('FFT computation time: %2.5f seconds \n', fft_time_matlab)

ax3 = subplot(2,3,3); 
stem(0:N-1, abs(Xk_fft_matlab), 'LineWidth', 1.5); 
title('Magnitude of the FFT sequence (Matlab)', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Magnitude', 'FontSize', 12); 
xlim([0, N-1])
grid on

subplot(2,3,6); 
stem(0:N-1, angle(Xk_fft_matlab), 'LineWidth', 1.5); 
title('Phase of the FFT sequence (Matlab)', 'FontSize', 14); 
xlabel('Frequency', 'FontSize', 12); 
ylabel('Phase', 'FontSize', 12); 
xlim([0, N-1])
grid on

legend(ax1, sprintf('Time: %2.5f', dft_time), 'Location', 'northeast')
legend(ax2, sprintf('Time: %2.5f \n (x%d faster than DFT)', ...
       fft_time, round(dft_time/fft_time)), 'Location', 'northeast')
legend(ax3, sprintf('Time: %2.5f\n (x%d faster than DFT)', ...
       fft_time_matlab, round(dft_time/fft_time_matlab)), 'Location', 'northeast')
