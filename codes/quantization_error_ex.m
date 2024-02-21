%% quantization_error_ex.m
% 
% This script demonstrates how to plot the quantization error of a signal.

clear; close all; clc;

addpath("tools")

fs = 1000;          % sample rate (Hz)
T = 4;              % duration (s)
n = (0:T*fs)/fs;    % time vector
f = 0.25;           % frequency (Hz)
A = 0.5;            % Max Amplitude 
N = 32;		        % bit-depth 

% plot quantization error
x = A*cos(2*pi*f*n); % signal
x_quantized = quantBits(x, N);  % 8-bit quantized version of x 

figure('Units', 'normalized', 'Position', [0.2, 0.2, 0.6, 0.6]); 

eq_x_quantized = x-x_quantized;
plot(n, eq_x_quantized, 'Color', '#1f77b4')

% plot quantized signal (scaled)
q=2/2^N;
hold on; grid on;
plot(n, x_quantized*q, 'LineWidth', 1.5, 'Color', '#d62728')
yticks([-q/2 -q/4 0 q/4 q/2]);
yticklabels({'-q/2', '-q/4', '0', '+q/4', '+q/2'});
ylabel('Amplitude/quantization error')
xlabel('Time')
title(sprintf('Quantization error plot for %d-bit representation', N))
set(gca, 'FontSize', 14)
legend({'Quantization error', 'Discrete signal'}, 'Location', 'southeast')
