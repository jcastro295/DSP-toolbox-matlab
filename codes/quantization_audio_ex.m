%% quantization_audio_ex.m
%
% This script demonstrates the quantization of an audio signal using linear
% quantization.

clear; close all; clc;

addpath("tools")
addpath("../data/")

N = 32;		  % bit-depth is .... [see pages X-Y in Ref....]

[y, fs] = audioread('flute.wav');	

% cropping sinal out
y = y(1:round(0.23*size(y,1)), :);

n = (0:length(y)-1)/fs;

y_linear_quantized = quantBits(y, N);
 
sound([y; y_linear_quantized],fs)

figure('Units', 'normalized', 'Position', [0.1, 0.2, 0.8, 0.6]); 

subplot(1, 2, 1)

plot(n, y, ...
    'color', '#7f7f7f');
title('Original signal')
xlim([min(n) max(n)])
ylabel('Amplitude')
xlabel('Time')
grid on;
set(gca, 'FontSize', 14)

subplot(1, 2, 2)
plot(n, y_linear_quantized, ...
    'Color', '#1f77b4');
xlim([min(n) max(n)])
title(sprintf('%d-bit Linear quantization', N))
ylabel('Amplitude')
xlabel('Time')
grid on;
set(gca, 'FontSize', 14)

