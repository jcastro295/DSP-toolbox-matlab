%% linear_vs_circular_convolution.m
%
% This script computes and compare the linear convolution
% and circular convolution

clc; clear; close all;

% For two vectors, x and y, the circular convolution is equal to the 
% inverse discrete Fourier transform (DFT) of the product of the vectors' 
% DFTs. Knowing the conditions under which linear and circular convolution 
% are equivalent allows you to use the DFT to efficiently compute linear 
% convolutions. The linear convolution of an N-point vector, x, and an 
% L-point vector, y, has length N + L - 1.

% Create two vectors, x and y, and compute the linear 
% convolution of the two vectors.
x = [2 1 2 1];
y = [1 2 3];
clin = conv(x,y); % The output has length 4+3-1.

disp("Linear convolution of x and y:")
disp(clin)

% The circular convolution is the IDFT of the product of two DFT.
% Before computing, we have to make sure both vectors are the same size
max_length = max([length(x), length(y)]);
xp = [x, zeros(max_length-length(x))];
yp = [y, zeros(max_length-length(y))];
ccirc = ifft(fft(xp).*fft(yp));

disp("Circular convolution of x and y:")
disp(ccirc)

% Notice that due to the cyclic nature of DFT, the convolution operator 
% is not equal to the one we compute in continous time domain, as shown
% below. In this contex, both convolution are not equivalent.
figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.6])

subplot(2,2,1)
stem(0:length(xp)-1, xp, 'LineWidth', 1.5)
set(gca, 'FontSize', 12)
title('x(n)', 'FontSize', 14)
xlabel('Time', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)

subplot(2,2,2)
stem(0:length(yp)-1, yp, 'LineWidth', 1.5)
set(gca, 'FontSize', 12)
title('y(n)', 'FontSize', 14)
xlabel('Time', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)

subplot(2,2,3)
stem(0:length(clin)-1, clin, 'LineWidth', 1.5)
set(gca, 'FontSize', 12)
title('Linear Convolution of x and y', 'FontSize', 14)
xlabel('Time', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)

subplot(2,2,4)
stem(0:length(ccirc)-1, ccirc, 'LineWidth', 1.5)
set(gca, 'FontSize', 12)
title('Circular Convolution of x and y', 'FontSize', 14)
xlabel('Time', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)

N = length(x) + length(y) - 1;

% Pad both vectors with zeros to length 4+3-1. Obtain the DFT of both 
% vectors, multiply the DFTs, and obtain the inverse DFT of the product.
xpad = [x zeros(1,N-length(x))];
ypad = [y zeros(1,N-length(y))];
ccirc = ifft(fft(xpad).*fft(ypad));

disp("Circular convolution of x padded and y padded:")
disp(ccirc)

% The circular convolution of the zero-padded vectors, xpad and ypad, is 
% equivalent to the linear convolution of x and y. You retain all the 
% elements of ccirc because the output has length 4+3-1.

% Plot the output of linear convolution and the inverse of the DFT product 
% to show the equivalence.

figure('Units', 'normalize', 'Position', [0.1, 0.1, 0.6, 0.6])

subplot(2,2,1)
stem(0:length(xpad)-1, xpad, 'LineWidth', 1.5)
set(gca, 'FontSize', 12)
title('x(n)  (zero padding)', 'FontSize', 14)
xlabel('Time', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)

subplot(2,2,2)
stem(0:length(ypad)-1, ypad, 'LineWidth', 1.5)
set(gca, 'FontSize', 12)
title('y(n) (zero padding)', 'FontSize', 14)
xlabel('Time', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)

subplot(2,2,3)
stem(0:N-1, clin, 'LineWidth', 1.5)
set(gca, 'FontSize', 12)
title('Linear Convolution of x and y', 'FontSize', 14)
xlabel('Time', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)

subplot(2,2,4)
stem(0:N-1, ccirc, 'LineWidth', 1.5)
set(gca, 'FontSize', 12)
title('Circular Convolution of xpad and ypad', 'FontSize', 14)
xlabel('Time', 'FontSize', 12)
ylabel('Amplitude', 'FontSize', 12)

% We can pad as most any zeros we want, and retain only the 4+3-1 elements
% of the computed circular convolution.
% Pad the vectors to length 12 and obtain the circular convolution using 
% the inverse DFT of the product of the DFTs. Retain only the first 4+3-1 
% elements to produce an equivalent result to linear convolution.
N = length(x)+length(y)-1;
xpad = [x zeros(1,12-length(x))];
ypad = [y zeros(1,12-length(y))];
ccirc = ifft(fft(xpad).*fft(ypad));
ccirc = ccirc(1:N);

disp("Circular convolution of x padded and y padded:")
disp(ccirc)

% The Signal Processing Toolbox™ software has a function, cconv, that 
% returns the circular convolution of two vectors. You can obtain the 
% linear convolution of x and y using circular convolution with the 
% following code.
ccirc2 = cconv(x,y,N);

disp("Circular convolution of x and y using ccirc:")
disp(ccirc)