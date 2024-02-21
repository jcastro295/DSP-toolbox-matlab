%% spectrogram_implementation.m
%
% This script shows two examples of how to generate spectrograms using a
% cosine and upsweep chirp (Low Frequency Modulated signal). Also, it
% compares the hardcoded function with the matlab implementation.

clc; clear; close all;

addpath('tools')

fs = 200;       %  Hz, sampling frequency
fmin = 10;      %  Hz, minimum frequency to be saved
fmax = 100;     %  Hz, maximum freuqency to be saved
%  Freq_spacing = fs/ns. 25k/4096 = 6.103 Hz
ns = 2^12;      %  number of samples for each FFT
n_secs = 5;     %  sec, total time interval to save from the beginning of the signal
N = fs*n_secs;  %  Number of time samples in x
t = (0:N-1)/fs;

dt_save = ns/fs;

%  Calculate spectrograms 
t_window = 0.25;                %  Integration time in seconds, ideally it is ns/fs
n_window = fs*t_window;         %  Window size, i.e., number of points to be considered in the FFT
window = hamming(n_window);     %  Apply the window you would like to use.
overlap = 0.75;                 %  Overlap (0.0 - 0.99).Typical value: 0.5

%  The final time step will be: t_window*(1-overlap) in [sec]
%  The frequency step is: fs/ns
n_overlap = round(n_window*overlap);   %  Number of overlap points

%  Noisy sine wave example:
omega = 2*pi*(2*fmin+fmax)/2;
x = sin(omega*t) + 0.1*normrnd(0, .1, size(t));

[P, F, T] = spectrogram_coded(x,window,n_overlap,ns,fs);
spec = 10*log10(abs(P)); %  In dB
[~, F_matlab, T_matlab, P_matlab] = spectrogram(x,window,n_overlap,ns,fs, "yaxis");
spec_matlab = 10*log10(abs(P_matlab))'; %  In dB

%  The output spectrogram contains all the possible frequencies.
%  If you want to select a certain frequency band you can index the vector 'F' and matrix 'spec' :
f_idx = find((F > fmin) & (F < fmax));
F = squeeze(F(f_idx)); %  new list of frequencies
spec = squeeze(spec(:,f_idx)); %  band passed spectrogram
F_matlab = squeeze(F_matlab(f_idx)); %  new list of frequencies
spec_matlab = squeeze(spec_matlab(:,f_idx)); %  band passed spectrogram

figure('Units', 'normalized', 'Position', [0.1, 0.1, 0.9, 0.4])

subplot(1,3,1)
plot(t, x)
set(gca,'Fontsize', 12)
xlabel('Time (s)', 'FontSize', 12)
ylabel('Pressure (Pa)', 'FontSize', 12)
title('Time Series', 'FontSize', 14)
xlim([t(1), t(end)])

% Plot spectrogram snapshots (ns samples spaced dt_save apart)
subplot(1,3,2)
imagesc(T, F, spec');
set(gca,'Fontsize', 12, 'YDir', 'normal')
cbar = colorbar();
cbar.Label.String = 'Power Spectral Density (dB )';
xlabel('Time (sec)', 'FontSize', 12)
ylabel('Frequency (Hz)', 'FontSize', 12)
title(sprintf('Spectrogram (coded): %d freqs x %d times', length(F), length(T)), 'FontSize', 14)

subplot(1,3,3)
imagesc(T_matlab, F_matlab, spec_matlab')
set(gca,'Fontsize', 12, 'YDir', 'normal')
cbar = colorbar();
cbar.Label.String = 'Power Spectral Density (dB )';
xlabel('Time (sec)', 'FontSize', 12)
ylabel('Frequency (Hz)', 'FontSize', 12)
title(sprintf('Spectrogram (matlab): %d freqs x %d times', length(F), length(T)), 'FontSize', 14)

% second example
% Noisy chirp example
x = chirp(t, fmin, n_secs, fmax, 'linear');% + 0.2*normrnd(0, .1, size(t));

[P, F, T] = spectrogram_coded(x,window,n_overlap,ns,fs);
spec = 10*log10(abs(P)); %  In dB
[~, F_matlab, T_matlab, P_matlab] = spectrogram(x,window,n_overlap,ns,fs, "yaxis");
spec_matlab = 10*log10(abs(P_matlab))'; %  In dB

%  The output spectrogram contains all the possible frequencies.
%  If you want to select a certain frequency band you can index the vector 'F' and matrix 'spec' :
f_idx = find((F > fmin) & (F < fmax));
F = squeeze(F(f_idx)); %  new list of frequencies
spec = squeeze(spec(:,f_idx)); %  band passed spectrogram
F_matlab = squeeze(F_matlab(f_idx)); %  new list of frequencies
spec_matlab = squeeze(spec_matlab(:,f_idx)); %  band passed spectrogram

figure('Units', 'normalized', 'Position', [0.1, 0.1, 0.9, 0.4])

subplot(1,3,1)
plot(t, x)
set(gca,'Fontsize', 12)
xlabel('Time (s)', 'FontSize', 12)
ylabel('Pressure (Pa)', 'FontSize', 12)
title('Time Series', 'FontSize', 14)
xlim([t(1), t(end)])

%  Plot spectrogram snapshots (ns samples spaced dt_save apart)
subplot(1,3,2)
imagesc(T, F, spec')
set(gca,'Fontsize', 12, 'YDir', 'normal')
cbar = colorbar();
cbar.Label.String = 'Power Spectral Density (dB )';
xlabel('Time (sec)', 'FontSize', 12)
ylabel('Frequency (Hz)', 'FontSize', 12)
title(sprintf('Spectrogram (coded): %d freqs x %d times', length(F), length(T)), 'FontSize', 14)

subplot(1,3,3)
imagesc(T_matlab, F_matlab, spec_matlab')
set(gca,'Fontsize', 12, 'YDir', 'normal')
cbar = colorbar();
cbar.Label.String = 'Power Spectral Density (dB )';
xlabel('Time (sec)', 'FontSize', 12)
ylabel('Frequency (Hz)', 'FontSize', 12)
title(sprintf('Spectrogram (matlab): %d freqs x %d times', length(F), length(T)), 'FontSize', 14)