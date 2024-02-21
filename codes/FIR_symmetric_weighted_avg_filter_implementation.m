%% FIR_symmetric_weighted_avg_filter_implementation.m
%
% This script demonstrates the implementation of a symmetric weighted moving average filter
% using a for loop and the numpy mean function. The filter is applied to a given ECG signal
% and the filtered signal is plotted along with the original signal.


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

% Adds weights of one to the first and last points in the filter, and 
% increases the weight value by 1 as you move closer to the center point. 
% Thus a n=5 point filter would have weights of [1,2,3,2,1], respectively.
kernel = [1 : round(n/2), round(n/2)-1 : -1: 1];  % filter coefficients 
% kernel = conv(ones(1,round(n/2)), ones(1,round(n/2)));  % this is a better way to do it 

N = length(time);
% Filtering starts at the round(length(kernel)/2) point since you cannot gather 
% data from point 1 to  round(length(kernel)/2)-1 since there is not. 
% We also ignore the last points for similar reasons


filtered_voltage = voltage;

% Apply the symmetric weighted moving average filter
for i = round(length(kernel)/2) : N-round(length(kernel)/2)
    % You then have to multiply the filter by the signal values, add them 
    % all together and then divide the entire thing by the sum of the 
    % coefficients, which for a five point filter, it would be 1+2+3+2+1 = 9.
    filtered_voltage(i) = sum(voltage(i-round(length(kernel)/2)+1:i+round(length(kernel)/2)-1).*kernel)/sum(kernel);
end


% we can analize the magnitude and phase of the filter's impulse response
[response, frequencies] = freqz(kernel, sum(kernel), 2^12);
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
title('Magnitude', 'FontSize', 14)
xlim([frequencies(1)/(2*pi), frequencies(end)/(2*pi)])
grid on


% Plot the original and filtered signals
figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.6])
stem(time, voltage)
hold on
stem(time, filtered_voltage)
set(gca, 'FontSize', 12)
title(sprintf('%d-point symmetric weighted moving average filter (hardcoded)', n), 'FontSize', 14)
xlabel('Time (s)', 'FontSize', 14)
ylabel('Voltage', 'FontSize', 14)
xlim([time(1) time(end)])
legend({'Original signal', 'Filtered signal'}, 'Location', 'northeast')

