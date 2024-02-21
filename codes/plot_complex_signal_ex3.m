%% plot_complex_signal_ex3.m
%
% This script demonstrates how to plot the magnitude and phase parts of a complex
% signal z(t) = exp(j(omega1*t+phi)) + exp(j(omega2*t+phi)), 0 <= t <= 2*pi.

clear; close all; clc;

t = 0 : (2*pi+1)/100 : 2*pi;
f1 = 0.1;
f2 = 0.5;
omega1 = 2*pi*f1;
omega2 = 2*pi*f2;
phi = 0;
z = exp(1i*(omega1*t+phi)) + exp(1i*(omega2*t+phi));

figure('Units', 'normalized', 'Position', [0.1, 0.1, 0.7, 0.6])

% magnitude of complex signal
subplot(2, 1, 1)
plot(t, abs(z), 'color', '#d62728', 'LineWidth', 1.5)
grid on;
title('Magnitude')
xlabel('Time')
ylabel('Magnitde')
set(gca, 'Fontsize', 16)
xlim([min(t), max(t)])


% phase of complex signal
subplot(2, 1, 2)
plot(t, angle(z), 'color', '#d62728', 'LineWidth', 1.5)
grid on;
title('Phase')
xlabel('Time')
ylabel('Phase')
set(gca, 'Fontsize', 16)
xlim([min(t), max(t)])