%% plot_continuous_discrete_signal.m
%
% This script demonstrates how to plot continuous, continuous with sampling, and
% discrete signals.

close all; clear; clc;

figure('Units', 'normalized', 'Position', [0.1, 0.25, 0.8, 0.5])

subplot(1,3,1)
t = 0:pi/100:2*pi;
y = sin(t);
plot(t, y)
title('Continuos signal')
xlabel('t')
ylabel('Amplitude')
set(gca, 'FontSize', 14)

subplot(1,3,2)
t = 0:pi/100:2*pi;
y = sin(t);
plot(t, y, '-o', 'MarkerIndices', 1:10:length(y), 'MarkerEdgeColor', 'r')
title('Continous signal sampling')
xlabel('t')
ylabel('Amplitude')
set(gca, 'FontSize', 14)

subplot(1,3,3)
t = 0:pi/10:2*pi;
y = sin(t);
stem(t,y)
title('Discrete signal')
xlabel('(nT)')
ylabel('Amplitude')
set(gca, 'FontSize', 14)



