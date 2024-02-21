%% average_filter_ex.m
%
% This script demonstrates the implementation of an IIR filter using the
% difference equation:
%     y(n) = 5*x(n) + 0.8*y(n-1)

clc; clear; close all;

addpath("tools")

n = -5 : 10;

% x(n) = delta(n), -3*delta(n-1), 2*delta(n-3)
x = 2*diracseq(n,0) - 3*diracseq(n,1) + 2*diracseq(n,3);

% filter definition
% y(n) = 5*x(n) + 0.8*y(n-1)
b = [0, 5]; % x(n-1), x(n)
a = [0.8, 0]; % y(n-1) y(n)

N = length(x);

filtered_x = zeros(1, N);

% compute y(n) for n=0
filtered_x(1) = sum(b.*x(1:1+length(b)-1));

% Apply the filter
for i = 1 : N-(max(length(a),length(b))-1)
    v_n = sum(b.*x(i:i+length(a)-1));
    
    filtered_x(i+1) = v_n + sum(a.*filtered_x(i:i+length(b)-1)); 
end

% Plot the original and filtered signals
figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.6])

subplot(3, 1, 1)
stem(n, x)
set(gca, 'FontSize', 12)
title('Original signal', 'FontSize', 14)
xlabel('Time (s)', 'FontSize', 14)
ylabel('Amplitude', 'FontSize', 14)
xlim([n(1) n(end)])

subplot(3, 1, 2)
stem(n, filtered_x)
set(gca, 'FontSize', 12)
title('Filtered signal (hardcoded)', 'FontSize', 14)
xlabel('Time (s)', 'FontSize', 14)
ylabel('Amplitude', 'FontSize', 14)
xlim([n(1) n(end)])

% using matlab filter function
h = [x(1), filter(flip(b), [1, -flip(a(1:end-1))], x(2:end), x(1))];

% Plot the filtered signal
subplot(3, 1, 3)
stem(n, h)
set(gca, 'FontSize', 12)
title('Filtered signal (filter)', 'FontSize', 14)
xlabel('Time (s)', 'FontSize', 14)
ylabel('Amplitude', 'FontSize', 14)
xlim([n(1) n(end)])