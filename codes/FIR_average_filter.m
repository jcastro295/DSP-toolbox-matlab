%% FIR_average_filter.m
%
% This script demonstrates the implementation of a moving average filter using
% the lfilter function. The filter is applied to a given signal x(n) and the
% filtered signal is plotted along with the original signal.

clc; clear; close all;

n = 0 : 40;
x = (1.02).^n + 1/2*cos(2*pi*n/8+pi/4);
baseline = (1.02).^n;

filter_length = 7;  % filter length
% get filter transfer function
b = ones(1,filter_length);
% You then have to multiply the filter by the signal values, add them 
% all together and then divide the entire thing by the sum of the 
% coefficients.
a = sum(b);

% zero padding before filtering
x_padded = [zeros(1, length(b)), x, zeros(1, length(b))];
n_padded = [-length(b):-1, n, n(end)+1:length(b)+n(end)];

% Apply filtering using filtfilt function
filtered_x = filter(b, a, x_padded);

% we can analize the magnitude and phase of the filter's impulse response
[response, frequencies] = freqz(b, a, 2^12);

figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.6])

subplot(2, 1, 1)
plot(frequencies/(2*pi), 20*log10(abs(response)))
set(gca, 'FontSize', 12)
xlabel('Frequency (x pi rad/sample)', 'FontSize', 12)
ylabel('Magnitude (dB)', 'Fontsize', 12)
title('Magnitude', 'FontSize', 14)
xlim([frequencies(1)/(2*pi), frequencies(end)/(2*pi)])
grid on

subplot(2, 1, 2)
plot(frequencies/(2*pi), rad2deg(angle(response)))
set(gca, 'FontSize', 12)
xlabel('Frequency (x pi rad/sample)', 'FontSize', 12)
ylabel('Phase (degrees)', 'FontSize', 12)
title('Phase', 'FontSize', 14)
xlim([frequencies(1)/(2*pi), frequencies(end)/(2*pi)])
grid on


% Plot the original and filtered signals
figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.6])

subplot(2, 1, 1)
stem(n_padded, x_padded)
hold on
plot(n, baseline)
set(gca, 'FontSize', 12)
title('Original signal', 'FontSize', 14)
xlabel('Time (n)', 'FontSize', 14)
ylabel('Amplitude', 'FontSize', 14)
xlim([n_padded(1) n_padded(end)])

subplot(2, 1, 2)
stem(n_padded, filtered_x)
hold on
plot(n+floor(length(b)/2), baseline)
set(gca, 'FontSize', 12)
title(sprintf('%d-point symmetric weighted moving average filter (filter)', ...
    length(b)), 'FontSize', 14)
xlabel('Time (s)', 'FontSize', 14)
ylabel('Amplitude', 'FontSize', 14)
xlim([n_padded(1) n_padded(end)])
p1 = patch([n(1) n(1)+length(b)-1 n(1)+length(b)-1 n(1)], ...
    [min(ylim) min(ylim) max(ylim) max(ylim)], [1, 0, 0]);
p1.EdgeColor = 'none';
p2 = patch([n(end) n(end)+length(b)-1 n(end)+length(b)-1 n(end)], ...
    [min(ylim) min(ylim) max(ylim) max(ylim)], [1, 0, 0]);
p2.EdgeColor = 'none';
alpha(0.2)
