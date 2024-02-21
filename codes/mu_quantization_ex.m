%% mu_quantization.m
%
% This script demonstrates the quantization of an audio signal using linear and
% mu-law companding.

clear; close all; clc;

addpath("tools")
addpath("../data/")

u = 255;	  % mu-law compression factor
N = 4;		  % bit-depth 

[y, fs] = audioread('flute.wav');	

% cropping sinal out
y = y(1:round(0.23*size(y,1)), :);

n = (0:length(y)-1)/fs;

y_linear_quantized = quantBits(y, N);
 
% mu-law quantizer
y_mu = sign(y).*log(1+u*abs(y))/log(1+u);
y_linear_mu_comp = quantBits(y_mu, N);
y_linear_mu = sign(y_linear_mu_comp)*(1/u).*((1+u).^(abs(y_linear_mu_comp))-1);

sound([y; y_linear_quantized; y_linear_mu],fs)

figure('Units', 'normalized', 'Position', [0.1, 0.2, 0.8, 0.6]); 

subplot(1, 3, 1)

plot(n, y, ...
    'color', '#7f7f7f');
title('Original signal')
xlim([min(n) max(n)])
ylabel('Amplitude')
xlabel('Time')
grid on;

subplot(1, 3, 2)
plot(n, y_linear_quantized, ...
    'Color', '#1f77b4');
xlim([min(n) max(n)])
title(sprintf('%d-bit Linear quantization', N))
ylabel('Amplitude')
xlabel('Time')
grid on;
set(gca, 'FontSize', 14)

subplot(1, 3, 3)
plot(n, y_linear_mu, ...
    'Color', '#d62728');
xlim([min(n) max(n)])
title(sprintf('%c-law quantization (%c=%d)', char(181), char(181), u))
ylabel('Amplitude')
xlabel('Time')
grid on;
set(gca, 'FontSize', 14)

