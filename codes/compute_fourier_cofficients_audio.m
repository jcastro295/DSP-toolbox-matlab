%% compute_fourier_cofficients_audio.m
%
% This script computes the Fourier coefficients of an audio signal and
% plots the magnitude and phase angle spectra. It also plays the original
% signal and signals with different numbers of Fourier components.

close all; clear; clc;

addpath('../data/')
addpath('tools')

[y, fs] = audioread('ahh_sound.mp3');

resampling_fs = 5000; % resampling frequency. Set it up to fs if you don't want to resample
n_coefficients = 3000; % number of Fourier coefficients

y = resample(y, resampling_fs, fs);
fs = resampling_fs;

t = (0 : length(y)-1)/fs;   % time vector

[f, coeffs] = computeComplexFourierCoef(y, fs, n_coefficients);

figure('Units', 'normalized', 'Position', [0, 0.1, 0.5, 0.8])

subplot(2, 1, 1)
stem(f, abs(coeffs), ...
     'LineWidth', 1.5, 'Color', '#1f77b4')
title('(a) Magnitude spectrum')
ylabel('|a_k|')
xlim([min(f) max(f)])
set(gca, 'FontSize', 14)

subplot(2, 1, 2)
stem(f, angle(coeffs), ...
     'LineWidth', 1.5, 'Color', '#1f77b4')
title('(b) Phase angle spectrum (rad)')
xlabel('Frequency f (Hz)')
ylabel('angle(a_k) (rad)')
xlim([min(f) max(f)])
set(gca, 'FontSize', 14)

% second figure
figure('Units', 'normalized', 'Position', [0.5, 0.1, 0.5, 0.8])

subplot(4, 1, 1)
plot(t/pi, y, 'LineWidth', 1.5)
title('Original signal')
ylabel('Amplitude')
ylim([-1.2 1.2])
set(gca, 'Fontsize', 14)
sound(y/max(abs(y)), fs)
fprintf('Original signal played. Type any key to continue...\n')
pause()

subplot(4,1,2)

idx = 1 : round(length(coeffs)/4);
y2 = real(exp(2i*pi*t'*f(idx))*coeffs(idx));
plot(t/pi, y2, 'LineWidth', 1.5)
title(sprintf('Signal with %d Fourier components', round(length(idx)/2)))
ylabel('Amplitude')
ylim([-1.2 1.2])
set(gca, 'Fontsize', 14)
sound(y2/max(abs(y2)), fs)
fprintf('Signal with %d coefficients played. Type any key to continue...\n', ...
        round(length(idx)/2))
pause()

subplot(4, 1, 3)
idx = 1 : round(length(coeffs)/2);
y3 = real(exp(2i*pi*t'*f(idx))*coeffs(idx));
plot(t/pi, y3, 'LineWidth', 1.5)
title(sprintf('Signal with %d Fourier components', round(length(idx)/2)))
ylabel('Amplitude')
ylim([-1.2 1.2])
set(gca, 'Fontsize', 14)
sound(y3/max(abs(y3)), fs);
fprintf('Signal with %d coefficients played. Type any key to continue...\n', ...
        round(length(idx)/2))
pause()

subplot(4, 1, 4)
idx = 1 : round(length(coeffs));
y4 = real(exp(2i*pi*t'*f(idx))*coeffs(idx));
plot(t/pi, y4, 'LineWidth', 1.5)
title(sprintf('Signal with %d Fourier components', round(length(idx)/2)))
ylabel('Amplitude')
xlabel('Time (t/\pi)')
ylim([-1.2 1.2])
set(gca, 'Fontsize', 14)
sound(y4/max(abs(y4)), fs);
fprintf('Signal with %d coefficients played. Type any key to continue...\n', ...
        round(length(idx)/2))