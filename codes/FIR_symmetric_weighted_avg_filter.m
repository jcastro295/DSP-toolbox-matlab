%% FIR_symmetric_weighted_avg_filter.m
%
% This script demonstrates the implementation of a symmetric weighted moving average filter
% using the filtfilt function. The filter is applied to a given ECG signal and the filtered
% signal is plotted along with the original signal.

clc; clear; close all;

addpath("../data/")

% Loading ECG data: The first column is the time vector, 
% and the second column is the voltage vector of the signal.
data = readmatrix('ECG_data.xlsx');

n = 3;   % filter length. It has to be and odd number
n = n - mod(n+1,2);  % make sure that n is odd

time = data(:,1)';
voltage = data(:,2)';

% let's pick only a the first 150 points in the data
time = time(1:150);
voltage = voltage(1:150);

% get filter transfer function
% Adds weights of one to the first and last points in the filter, and 
% increases the weight value by 1 as you move closer to the center point. 
% Thus a n=5 point filter would have weights of [1,2,3,2,1], respectively.
b = conv(ones(1,round(n/2)), ones(1,round(n/2)));
% we need to divide the entire thing by the sum of the 
% coefficients, which for a five point filter, it would be 1+2+3+2+1 = 9.
a = sum(b);

% Apply filtering using filtfilt function
filtered_voltage = filtfilt(b, a, voltage);

% we can analize the magnitude and phase of the filter's impulse response
figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.6])
freqz(b, a, 2^12)
set(gca, 'FontSize', 12)

figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.6])
stem(time, voltage)
hold on
stem(time, filtered_voltage)
set(gca, 'FontSize', 12)
title(sprintf('%d-point symmetric weighted moving average filter (filtfilt)', n), 'FontSize', 14)
xlabel('Time (s)', 'FontSize', 14)
ylabel('Voltage', 'FontSize', 14)
xlim([time(1) time(end)])
legend({'Original signal', 'Filtered signal'}, 'Location', 'northeast')


