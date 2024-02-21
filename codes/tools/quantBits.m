function [Q, q] = quantBits(input, N)

% Q = quantBits(input, N)
% 
% This functions quantizes the input according to the bit depth of N for a
% signal


% check if signal has more than one channel
max_peak = max(input, [], 'all');
min_peak = min(input, [], 'all');

% find quantization step size
q = (max_peak - min_peak)/(2^N);

Q = round(input/q)*q;
