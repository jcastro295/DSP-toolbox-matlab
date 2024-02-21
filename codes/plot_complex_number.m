%% plot_complex_number.m 
%
% This script demonstrates how to plot a complex number in Cartesian and polar
% coordinates.

clear; close all; clc;

z = 4 + 3i;

figure('Units', 'normalized', 'Position', [0.1, 0.1, 0.7, 0.6])

% plot in cartesian coordinates
subplot(1, 2, 1)
hold on; 
grid on;
plot(real(z), imag(z), 'o', ...
    'color', '#d62728', 'LineWidth', 1.5)
plot([0,real(z)], [0 imag(z)], ...
    'color', '#1f77b4', 'LineWidth', 1.5)
plot([real(z), real(z)], [0 imag(z)], '--', ...
    'color', '#7f7f7f')
plot([0, real(z)], [imag(z) imag(z)], '--', ...
    'color', '#7f7f7f')
axis([0, real(z)+1, 0, imag(z)+1])
title(sprintf('z = %d + %dj in cartesian coordinates', real(z), imag(z)))
xlabel('Re\{z\}')
ylabel('Im\{z\}')
set(gca, 'Fontsize', 16)


% plot in polar coordinates
subplot(1, 2, 2)
compass(z)
title(sprintf('z in polar coordinates |z|=%d, angle(z)=%2.2f°', abs(z), rad2deg(angle(z))))
set(gca, 'Fontsize', 16)