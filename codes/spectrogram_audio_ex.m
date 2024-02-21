%% spectrogram_audio_ex.m
% 
% This script computes the spectrogram of an audio signal using the FFT-based
% method. The audio signal is read from a .wav file and is normalized to the range
% [-1, 1]. The spectrogram is computed using the FFT-based method and is plotted.

clc; clear; close all;

addpath('tools')
addpath('../data/')

[x, fs] = audioread('chirping_sound.wav');

% using a single channel 
x = x(1:round(0.1*size(x,1)),1);

% resample signal 
resample_fs = 25000;
%x = double(bandpass(double(x),[fmin fmax],fs));
x = resample(x, resample_fs, fs);

fs = resample_fs;

N = length(x);  %  Number of time samples in x
t = (0:N-1)/fs;

%  Calculate spectrograms 
t_window = 0.05;              %  Integration time in seconds, ideally it is ns/fs
n_window = fs*t_window;      %  Window size, i.e., number of points to be considered in the FFT
window = hamming(n_window);  %  Apply the window you would like to use.
overlap = 0.9;               %  Overlap (0.0 - 0.99).Typical value: 0.5
ns = n_window;               %  number of samples for each FFT

%  The final time step will be: t_window*(1-overlap) in [sec]
%  The frequency step is: fs/ns
n_overlap = round(n_window*overlap);   %  Number of overlap points

[~, F, T, P] = spectrogram(x, window, n_overlap, ns, fs);
spec = 10*log10(abs(P))'; %  In dB

figure('Units', 'normalized', 'Position', [0.1, 0.1, 0.6, 0.5])

ax1 = subplot(2,1,1);
plot(t, x)
hold on
h1 = xline(t(1), 'r', 'LineWidth', 1.5);
set(gca,'Fontsize', 12)
xlabel('Time (s)', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)
title('Time Series', 'FontSize', 14)
xlim([t(1), t(end)])

% Plot spectrogram snapshots (ns samples spaced dt_save apart)
ax2 = subplot(2,1,2);
imagesc(T, F, spec');
hold on
h2 = xline(t(1), 'r', 'LineWidth', 1.5);
colormap('jet')
clim([-150 -50])
set(gca,'Fontsize', 12, 'YDir', 'normal')
cbar = colorbar();
cbar.Label.String = 'PSD (dB)';
cbar.Position = [0.9099, 0.1097, 0.0156, 0.342];
xlabel('Time (sec)', 'FontSize', 12)
ylabel('Frequency (Hz)', 'FontSize', 12)
title(sprintf('Spectrogram: %d freqs x %d times', length(F), length(T)), 'FontSize', 14)
xlim([t(1) t(end)])

player = audioplayer(x, fs);
player.TimerFcn = {@timerFcn, h1, h2};
player.TimerPeriod = 0.1;
player.playblocking()


frame_rate = 5;
n_audio_samples_per_frame = fs/frame_rate;

format = 'avi';
writerObj = vision.VideoFileWriter('video_test.avi','FileFormat',format,'FrameRate'...
                            ,frame_rate,'AudioInputPort', true);

function timerFcn(source, ~, h1, h2)
    position = (source.CurrentSample-1)/source.SampleRate;
    set(h1,'value', position);
    set(h2,'value', position);
end
