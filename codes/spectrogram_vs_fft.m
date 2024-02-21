%% spectrogram_vs_fft.m
%
% This code compares the spectrogram (time-frequency) representation vs the
% FFT (frequency-only) represention

clc; clear; close all;

fs = 100;
N = 2000;
n = (0:N-1)/fs;
freq = fs/N*(-N/2:N/2-1);

x1 = sin(2*2*pi*n);
x2 = sin(4*2*pi*n);

x = [x1(n<=10), x2(n>10)];

x_flipped = fliplr(x);

X = fft(x);
X_flipped = fft(x);

% spectrogram parameters 
t_window = 2;              %  Integration time in seconds, ideally it is ns/fs
n_window = fs*t_window;      %  Window size, i.e., number of points to be considered in the FFT
window = hamming(n_window);  %  Apply the window you would like to use.
overlap = 0.9;               %  Overlap (0.0 - 0.99).Typical value: 0.5
ns = n_window;               %  number of samples for each FFT

%  The final time step will be: t_window*(1-overlap) in [sec]
%  The frequency step is: fs/ns
n_overlap = round(n_window*overlap);   %  Number of overlap points


figure('Units', 'normalized', 'Position', [0.1, 0.1, 0.6, 0.6])

subplot(3,2,1)
plot(n,x)
xlabel('Time (s)', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)
title('Time series x_1(n)', 'FontSize', 14)

subplot(3,2,2)
plot(freq,fliplr(x))
xlabel('Time (s)', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)
title('Time series x_2(n)', 'FontSize', 14)

subplot(3,2,3)
plot(n,abs(fftshift(X)))
xlabel('Frequency (Hz)', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)
title('Magnitude FFT X_1(k)', 'FontSize', 14)

subplot(3,2,4)
plot(freq,abs(fftshift(X_flipped)))
xlabel('Frequency (Hz)', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)
title('Magnitude FFT X_2(k)', 'FontSize', 14)

[~, F, T, P] = spectrogram(x, window, n_overlap, ns, fs);
spec = 10*log10(abs(P))'; %  In dB

[~, F_flipped, T_flipped, P_flipped] = spectrogram(x_flipped, window, n_overlap, ns, fs);
spec_flipped = 10*log10(abs(P_flipped))'; %  In dB


subplot(3,2,5)
imagesc(T, F, spec')
set(gca,'Fontsize', 12, 'YDir', 'normal')
cbar = colorbar();
cbar.Label.String = 'PSD (dB)';
cbar.Position = [0.4703, 0.1099, 0.0156, 0.2061];
xlabel('Time (sec)', 'FontSize', 12)
ylabel('Frequency (Hz)', 'FontSize', 12)
title('Spectrogram x_1(n)', 'FontSize', 14)
colormap('jet')
clim([-40, 0])


subplot(3,2,6)
imagesc(T_flipped, F_flipped, spec_flipped')
set(gca,'Fontsize', 12, 'YDir', 'normal')
cbar = colorbar();
cbar.Label.String = 'PSD (dB)';
cbar.Position = [0.9099, 0.1099, 0.0156, 0.2061];
xlabel('Time (sec)', 'FontSize', 12)
ylabel('Frequency (Hz)', 'FontSize', 12)
title('Spectrogram x_2(n)', 'FontSize', 14)
colormap('jet')
clim([-40, 0])
