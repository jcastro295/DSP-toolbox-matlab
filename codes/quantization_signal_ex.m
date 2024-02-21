%% quantization_signal_ex.m
%
% This script demonstrates how to plot the original, downsampled, and quantized
% versions of a signal.

close all; clear; clc;

addpath("tools")

fs = 1000;         % sample rate (Hz)
T = 4;             % duration (s)
n = (0:fs*T)/fs;   % time vector
f = 0.25;          % frequency (Hz)
N = 4;		       % bit-depth 
A = 0.5;
f_sampled = 20*f; % downsample frequency

x = A*cos(2*pi*f*n); % original signal

x_sampled = downsample(x, fs/f_sampled);
n_sampled = downsample(n, fs/f_sampled);

x_quantized = quantBits(x_sampled, N);  % N-bit quantized version of x 

figure('Units', 'normalized', 'Position', [0.2, 0.2, 0.6, 0.6]); 

hold on; 
grid on;

plot(n,x, ...
    'color', '#7f7f7f');
stem(n_sampled,x_sampled, ...
    'LineStyle', '-', ...
    'Color', '#1f77b4');
stem(n_sampled,x_quantized, ...
    'LineStyle', '--', ...
    'Color', '#d62728', ...
    'Marker','diamond', ...
    'MarkerFaceColor', '#d62728');
xlim([min(n) max(n)])
title(sprintf('%d-bit quantized version of x', N))
ylabel('Amplitude')
xlabel('Time')
legend({'Original signal', 'Sampled signal', 'Discrete signal'}, ...
       'Location', 'southeast')
set(gca, 'FontSize', 14)

% separate subplots
figure('Units', 'normalized', 'Position', [0.1, 0.2, 0.8, 0.6]); 

subplot(1, 3, 1)
plot(n,x, ...
    'color', '#7f7f7f');
title('Original signal')
ylabel('Amplitude')
xlabel('Time (t)')
grid on;
set(gca, 'FontSize', 14)

subplot(1, 3, 2)
stem(n_sampled,x_sampled, ...
    'LineStyle', '-', ...
    'Color', '#1f77b4');
title('Subsampled signal')
ylabel('Amplitude')
xlabel('Time (nT)')
grid on;
set(gca, 'FontSize', 14)

subplot(1, 3, 3)
stem(n_sampled,x_quantized, ...
    'LineStyle', '--', ...
    'Color', '#d62728', ...
    'Marker','diamond', ...
    'MarkerFaceColor', '#d62728');
xlim([min(n) max(n)])
title(sprintf('%d-bit quantized version of x', N))
ylabel('Amplitude')
xlabel('Time (nT)')
grid on;
set(gca, 'FontSize', 14)