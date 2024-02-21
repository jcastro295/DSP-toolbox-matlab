%% complex_number_animation.m
%
% This script demonstrates the animation of a complex number in 3D space. 
% The complex number is represented as z = exp(iwt+phi), where w is the angular
% frequency and phi is the phase. The real and imaginary parts of the complex
% number are plotted against time, and the real and imaginary parts are plotted
% against each other. The real part is also plotted against the imaginary part
% and the time.

close all; clear; clc;

figure('Units', 'normalized', 'Position', [0.1, 0.1, 0.8, 0.65])

fs = 10;                % Sampling frequency (Hz)
ts = 0:1/fs:20;         % time vector (s)
phi = 5;          % phase (rad)
omega = 1;              % angular frequency (rad/s)  

ax1 = subplot(2,4,[1,2,5,6]);
hold(ax1, 'on');
grid(ax1, 'on');
xlabel(ax1, 'Time');
zlabel(ax1, 'Imaginary Axis');
ylabel(ax1, 'Real Axis');
set(ax1, 'Fontsize', 14, 'Position', [0.1000, 0.1100, 0.3628, 0.8150]);
title(ax1, 'z=exp(i\omega t+\phi) : Blue   Re\{z\} : Red   Im\{z\} : Green');
axis(ax1, 'square');
view(ax1, 180-38,20);

ax2 = subplot(2,4,3);
hold(ax2, 'on');
grid(ax2, 'on');
xlabel(ax2, 'Real Axis');
ylabel(ax2, 'Imaginary Axis');
set(ax2, 'Fontsize', 14)

ax3 = subplot(2,4,4);
hold(ax3, 'on');
grid(ax3, 'on');
xlabel(ax3, 'Time');
ylabel(ax3, 'Imaginary Axis');
set(ax3, 'Fontsize', 14)

ax4 = subplot(2,4,7);
hold(ax4, 'on');
grid(ax4, 'on');
xlabel(ax4, 'Real Axis');
ylabel(ax4, 'Time');
set(ax4, 'Fontsize', 14)

for i = 1 : length(ts)
    
    t = ts(1:i);
    theta = omega*t;
    z = exp(1i*(theta+phi));


    % 3D plot
    plot3(ax1, t, real(z), imag(z), ...
         'color', '#1f77b4', ...
         'LineWidth', 2);
    marker_3d = plot3(ax1, t(i), real(z(i)), imag(z(i)), 'o', ...
                      'MarkerEdgeColor', '#ff7f0e', ...
                      'MarkerFaceColor', '#ff7f0e', ...
                      'MarkerSize', 10);
    plot3(ax1, (min(ts)-0.1)*ones(size(t)), real(z), imag(z), ...
          'color', '#bcbd22', 'LineWidth', 2);
    plot3(ax1, t, -1.1*ones(size(t)), imag(z), ...
         'color', '#2ca02c','LineWidth', 2);
    plot3(ax1, t, real(z), -1.1*ones(size(t)), ...
         'color', '#d62728', 'LineWidth',2);
    xlim(ax1, [min(ts)-0.1 max(ts)]);
    ylim(ax1, [-1.1 1]);
    zlim(ax1, [-1.1 1]);


    % Real vs time
    plot(ax4, real(z), t, ...
         'color', '#d62728', 'LineWidth', 2);
    axis(ax4, [-1, 1, min(ts), max(ts)])


    % Real vs imaginary
    plot(ax2, real(z), imag(z), ...
         'color', '#bcbd22', 'LineWidth', 2);
    plot(ax2, real(z), imag(z), '--', ...
         'color', '#1f77b4', 'LineWidth', 2);
    marker_2d = plot(ax2, real(z(i)), imag(z(i)), 'o',...
                    'MarkerEdgeColor', '#ff7f0e',...
                    'MarkerFaceColor', '#ff7f0e', ...
                    'MarkerSize', 10);
    axis(ax2, [-1, 1, -1, 1])
    

    % Time vs imaginary
    plot(ax3, t, imag(z), ...
         'color', '#2ca02c', 'LineWidth', 2);
    axis(ax3, [min(ts), max(ts), -1, 1])
    
    pause(0.01);

    if i ~= length(ts)
        delete(marker_2d);
        delete(marker_3d);
    end
end