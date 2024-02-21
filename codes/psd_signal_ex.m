%% psd_signal_ex.m
% 
% This code computes the power spectral density of a cosine signal with
% white noise. For further details:
% https://www.mathworks.com/help/signal/ug/power-spectral-density-estimates-using-fft.html
% https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.periodogram.html

clc; clear; close all;

fs = 1000;
t = 0:1/fs:1-1/fs;
x = cos(2*pi*100*t) + 0.1*randn(size(t));

N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N))*abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/length(x):fs/2;

figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.8, 0.5])

subplot(2,2,[1,3])
plot(t, x)
grid on
set(gca, 'FontSize', 12)
title('Original signal x(n)', 'FontSize', 14)
xlabel('Time (s)', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)

subplot(2,2,2)
plot(freq, abs(xdft))
grid on
set(gca, 'FontSize', 12)
title('Magnitude of FFT X(k)', 'FontSize', 14)
xlabel('Frequency (Hz)', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)

subplot(2,2,4)
plot(freq, pow2db(psdx))
grid on
set(gca, 'FontSize', 12)
title('Power Spectral Density Using FFT', 'FontSize', 14)
xlabel('Frequency (Hz)', 'FontSize', 12)
ylabel('Power/Frequency (dB/Hz)', 'FontSize', 12)


% Matlab supports a function 
[pxx,f] = periodogram(x, rectwin(N), N, fs);

figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.8])

subplot(2,1,1)
plot(freq, pow2db(psdx))
grid on
set(gca, 'FontSize', 12)
title('Power Spectral Density Using FFT', 'FontSize', 14)
xlabel('Frequency (Hz)', 'FontSize', 12)
ylabel('Power/Frequency (dB/Hz)', 'FontSize', 12)

subplot(2, 1, 2)
plot(f, pow2db(pxx))
grid on
set(gca, 'FontSize', 12)
title('Power Spectral Densitym Using Matlab function', 'FontSize', 14)
xlabel('Frequency (Hz)', 'FontSize', 12)
ylabel('Power/Frequency (dB/Hz)', 'FontSize', 12)

% compute the error (difference) between FFT-based implementation and
% periodogram
mxerr = max(psdx'-pxx);
fprintf('The error between both implementations is %2.5e\n', mxerr)
