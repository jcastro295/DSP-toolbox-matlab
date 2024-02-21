%% ifft_comparison.m
%
% This script provides an example for using the coded IDFT function.
% It compares the outputs and elapsed time between IDFT and IFFT

clc; clear; close all;

addpath("tools")

% generate a simple sequence
% for this fft implementation, Xk must be a power of 2
Xk = rand(1, 2^10); % if run out of memory use 2^6 instead
N = length(Xk); % Number of points for IDFT/IFFT

% IDFT computation
tic
xn = idft(Xk, N); 
% xn = idft_for_loop(Xk, N);  %foor loop version
idft_time = toc;
fprintf('IDFT computation time: %2.5f seconds \n', idft_time)


figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.8, 0.4])

ax1 = subplot(1,3,1);
stem(0:N-1, real(xn), 'LineWidth', 1.5); 
title('Recovered signal (IDFT)', 'FontSize', 14); 
xlabel('Time', 'FontSize', 12); 
ylabel('Amplitude', 'FontSize', 12); 
xlim([0, N-1])
grid on


% IFFT computation (using the coded ifft function)
tic 
xn_ifft = ifft_coded(Xk);
ifft_time = toc;
fprintf('IFFT computation time: %2.5f seconds \n', ifft_time)

ax2 = subplot(1,3,2);
stem(0:N-1, real(xn_ifft), 'LineWidth', 1.5); 
title('Recovered signal (IFFT)', 'FontSize', 14); 
xlabel('Time', 'FontSize', 12); 
ylabel('Amplitude', 'FontSize', 12); 
xlim([0, N-1])
grid on


% IFFT computation (using the Matlab ifft function)
tic 
xn_ifft_matlab = ifft(Xk, N);
ifft_time_matlab = toc;
fprintf('IFFT computation time: %2.5f seconds \n', ifft_time_matlab)

ax3 = subplot(1,3,3);
stem(0:N-1, real(xn_ifft_matlab), 'LineWidth', 1.5); 
title('Recovered signal (IFFT) (Matlab)', 'FontSize', 14); 
xlabel('Time', 'FontSize', 12); 
ylabel('Amplitude', 'FontSize', 12); 
xlim([0, N-1])
grid on

legend(ax1, sprintf('Time: %2.5f', idft_time), 'Location', 'northeast')
legend(ax2, sprintf('Time: %2.5f \n (x%d faster than DFT)', ...
       ifft_time, round(idft_time/ifft_time)), 'Location', 'northeast')
legend(ax3, sprintf('Time: %2.5f\n (x%d faster than DFT)', ...
    ifft_time_matlab, round(idft_time/ifft_time_matlab)), 'Location', 'northeast')