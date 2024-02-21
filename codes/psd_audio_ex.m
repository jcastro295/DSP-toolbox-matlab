%% psd_audio_ex.m
%
% This script computes the power spectral density (PSD) of an audio signal using
% the FFT-based and periodogram-based methods. The audio signal is read from a
% .wav file and is normalized to the range [-1, 1]. The PSD is computed using the
% FFT-based method and the periodogram-based method. The PSDs are plotted and
% compared. The audio signal is also played.
% For further details: 
% https://www.mathworks.com/help/signal/ug/power-spectral-density-estimates-using-fft.html
% https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.periodogram.html

clc; clear; close all;

addpath('../data/')

[x, fs] = audioread('flute.wav');

% cropping sinal out
x = x(1:round(0.23*size(x,1)), :);
% select only one channel
x = x(:,1);

N = length(x);
t = (0:length(x)-1)/fs;
xdft = fft(x);
xdft = xdft(1:floor(N/2)+1);
psdx = (1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/length(x):fs/2;

figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.8, 0.5])

subplot(2,2,[1,3])
plot(t,x)
grid on
set(gca, 'FontSize', 12)
title('Original signal x(n)', 'FontSize', 14)
xlabel('Time (s)', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)
xlim([t(1), t(end)])

subplot(2,2,2)
plot(freq, abs(xdft))
grid on
set(gca, 'FontSize', 12)
title('Magnitude of FFT X(k)', 'FontSize', 14)
xlabel('Frequency (Hz)', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)
xlim([freq(1), freq(end)])

subplot(2,2,4)
plot(freq, pow2db(psdx))
grid on
set(gca, 'FontSize', 12)
title('Power Spectral Density Using FFT', 'FontSize', 14)
xlabel('Frequency (Hz)', 'FontSize', 12)
ylabel('Power/Frequency (dB/Hz)', 'FontSize', 12)
xlim([freq(1), freq(end)])

% play the sound
sound(x, fs)

% Matlab supports a function 
[pxx, f] = periodogram(x, rectwin(N), N, fs);

figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.8])

subplot(2,1,1)
plot(freq, pow2db(psdx))
grid on
set(gca, 'FontSize', 12)
title('Power Spectral Density Using FFT', 'FontSize', 14)
xlabel('Frequency (Hz)', 'FontSize', 12)
ylabel('Power/Frequency (dB/Hz)', 'FontSize', 12)
xlim([freq(1), freq(end)])

subplot(2,1,2)
plot(f, pow2db(pxx))
grid on
set(gca, 'FontSize', 12)
title('Power Spectral Density Using Matlab function', 'FontSize', 14)
xlabel('Frequency (Hz)', 'FontSize', 12)
ylabel('Power/Frequency (dB/Hz)', 'FontSize', 12)
xlim([f(1), f(end)])

% compute the error (difference) between FFT-based implementation and
% periodogram
mxerr = max(psdx-pxx);
fprintf('The error between both implementations is %2.5e\n', mxerr)
