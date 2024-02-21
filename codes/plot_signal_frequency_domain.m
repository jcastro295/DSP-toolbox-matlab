%% plot_signal_frequency_domain.py
%
% This script demonstrates how to plot the magnitude and phase parts of a complex
% signal x(t) = 0.00772 + 0.122j - 0.08866 + 0.2805j + 0.48 - 0.08996j + 
% 0.01656 - 0.1352j + 0.04724, 0 <= t <= 2*pi.

clear; close all; clc;


f_k = 100 : 100: 1700;
a_k = [0, 0.00772 + 0.122i, 0, -0.08866+0.2805i, 0.48-0.08996i, ...
    zeros(1,10), 0.01656-0.1352i 0.04724+0i];

% The magnitude (a) is an even function
% with respect to f = 0; the phase (b) is odd since
% a_{−k} = a^{∗}_k

a = [flip(conj(a_k)) 0 a_k];
f = [-flip(f_k) 0 f_k];

figure('Units', 'normalized', 'Position', [0.1, 0.1, 0.6, 0.5])

subplot(2, 1, 1)
stem(f, abs(a), ...
     'LineWidth', 1.5, 'Color', '#1f77b4')
title('(a) Magnitude spectrum')
ylabel('|a_k|')
set(gca, 'FontSize', 14)

subplot(2, 1, 2)
stem(f, angle(a), ...
     'LineWidth', 1.5, 'Color', '#1f77b4')
title('(b) Phase angle spectrum (rad)')
xlabel('Frequency f (Hz)')
ylabel('angle(a_k) (rad)')
set(gca, 'FontSize', 14)

% generating table
fprintf('k\t f_k (Hz)\t a_k\t\t Mag\t Phase\n')
for k = 1 : length(a_k)
    fprintf('%d\t %d\t %2.4f+%2.4f\t%2.4f\t %2.4f\n', ...
        k, f_k(k), real(a_k(k)), imag(a_k(k)), abs(a_k(k)), angle(a_k(k)));
end
