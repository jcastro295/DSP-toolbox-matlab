%% convolution_animation.m
%
% This code is an animation of the convolution of two discrete-time signals
% x(n) and h(n). The code uses numpy to calculate the convolution of the two 
% signals and then animates the process of convolution. The code also compares 
% the result with the numpy's convolve function.
% adapted from: https://gist.github.com/xen0f0n/088d5fda244f72af1fcdfd3618dfba54

close all; clear; clc;

filename = 'convolution_animation.gif';
save_animation = false;

step_size = 0.1;
nt_x = 0:step_size:1;
nt_h =  0:step_size:2;

% x = [0 1 2 1 1 1 4 3 4 3 2 1 0];    % x(n) random signal
 %x = [1 1 1 1 1 1 1 1];             % square
%x = [1 2 3 4 5 6 7 8];             % ramp
x = exp(nt_x);                   %  exponential
 %h = [1, zeros(1,10)];               % Impulse
 
% h = [0 1 2 1 1 1 4 3 4 3 2 1 0];    % h(n) random signal
 h = [1 1 1 1 1 1 1 1];              % h(n) square
%h = exp(nt_h);                   % exponential
% h = nt_h;                             % ramp
 %h = [1, zeros(1,10)];               % impulse

m = length(x);
n = length(h);

k = 2*max(length(x), length(h));    % length of convolved signal

% Flips vector h(n)
hi = fliplr(h);
X = [x,zeros(1,2*k-m)]; % add zero padding because vectors are not the same size
X = X([ end-k+1:end 1:end-k ]); 
H = [h,zeros(1,2*k-n)]; % add zero padding
H = H([ end-k+1:end 1:end-k ]);
xn = (-k:k-1)*step_size;
Y = zeros(1,2*k);
p = zeros(1,2*k);

figure('Units', 'normalized', 'Position', [0.2 0.1 0.6 0.8])

h1 = subplot(3,1,1);
stem(xn, X, 'Color', '#2ca02c', 'MarkerFaceColor', '#2ca02c', ...
     'MarkerEdgeColor', '#2ca02c')
ylabel('Amplitude')
title('x(n)')
set(h1, 'YLim', [0 max(X)+1], 'FontSize', 12)

h2 = subplot(3,1,2);
stem(xn, H, 'Color', '#1f77b4', 'MarkerFaceColor', '#1f77b4', ...
    'MarkerEdgeColor', '#1f77b4')

h3 = subplot(3,1,3);
stem(xn, Y, 'Color', '#d62728', 'MarkerFaceColor', '#d62728', ...
    'MarkerEdgeColor', '#d62728')

pause(1)
Hi = [hi, zeros(1,2*k-n)];
for i = 1:2*k-n
    p = X.*Hi;
    Y(i+n-1) = sum(p);
    
    stem(h2, xn, Hi, 'Color', '#1f77b4', 'MarkerFaceColor', '#1f77b4', ...
    'MarkerEdgeColor', '#1f77b4')
    set(h2, 'YLim', [0 max(H)+1], 'FontSize', 12)
    ylabel(h2, 'Amplitude')
    title(h2, 'h(n)')

    stem(h3, xn, Y, 'Color', '#d62728', 'MarkerFaceColor', '#d62728', ...
    'MarkerEdgeColor', '#d62728')
    set(h3, 'YLim', [0 max(conv(x,h))+1], 'FontSize', 12)
    xlabel(h3, 'Time (n)')
    ylabel(h3, 'Amplitude')
    title('y(n) = x(n)*h(n)')

    Hi = Hi([end 1:end-1]);

    if i == 1
        pause(1)
    else
        pause(0.1)
    end
    drawnow
    if save_animation
        frame = getframe(1);
        im = frame2im(frame);
        [imind, cm] = rgb2ind(im, 256);
        if i == 1
            imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
        else
            imwrite(imind,cm,filename,'gif','WriteMode','append');
        end
    end
end

% Comparison with Matlab built-in function
figure('Units', 'normalized', 'Position', [0.3 0.1 0.4 0.6])

Y_conv = conv(x, h);
n_matlab = -k : k-1;
Y_matlab = zeros(1, 2*k); % zero padding
Y_matlab(round(length(n_matlab)/2)+1:round(length(n_matlab)/2)+length(Y_conv)) = Y_conv;

h1 = subplot(2,1,1);
stem(xn, Y, 'Color', '#d62728', 'MarkerFaceColor', '#d62728', ...
    'MarkerEdgeColor', '#d62728')
ylabel('Amplitude')
xlabel('x(n)')
title('y(n) calculated using this code')
set(h1, 'YLim', [0 max(Y_matlab)+1], 'FontSize', 12)

h2 = subplot(2,1,2);

stem(n_matlab, Y_matlab, 'Color', '#1f77b4', 'MarkerFaceColor', '#1f77b4', ...
    'MarkerEdgeColor', '#1f77b4')
ylabel('Amplitude')
xlabel('x(n)')
title('y(n) calculated using matlab')
set(h2, 'YLim', [0 max(Y_matlab)+1], 'FontSize', 12)

%% two exponentials comparison

% figure('Units', 'normalized', 'Position', [0.3 0.1 0.4 0.6])
% 
% subplot(2,1,1)
% 
% stem(xn, Y, 'Color', '#d62728', 'MarkerFaceColor', '#d62728', ...
%     'MarkerEdgeColor', '#d62728')
% ylabel('Amplitude')
% xlabel('x(n)')
% title('Convolved signal y(n)')
% 
% subplot(2,1,2)
% 
% f1 = xn.*exp(xn).*(xn >= 0 & xn <=1);
% f2 = exp(xn).*(xn >= 1 & xn <=2);
% f3 = (3-xn).*exp(xn).*(xn >= 2 & xn <=3);
% 
% stem(xn, f1, 'Color', '#2ca02c', 'MarkerFaceColor', '#2ca02c', ...
%      'MarkerEdgeColor', '#2ca02c')
% hold on;
% stem(xn, f2, 'Color', '#1f77b4', 'MarkerFaceColor', '#1f77b4', ...
%     'MarkerEdgeColor', '#1f77b4')
% stem(xn, f3, 'Color', '#d62728', 'MarkerFaceColor', '#d62728', ...
%     'MarkerEdgeColor', '#d62728')
% stem(xn, zeros(1,length(xn)), 'Color', '#7f7f7f', 'MarkerFaceColor', '#7f7f7f', ...
%     'MarkerEdgeColor', '#7f7f7f')
% xlabel('Time (n)')
% ylabel('Amplitude')
% title('Plot of interval functions resulting from integral')
% legend({'t*e^t from 0 < t < 1', 'e^t from 1 < t < 2', '(3-t)*e^t from 2 < t < 3'}, ...
%     'Location', 'northwest')