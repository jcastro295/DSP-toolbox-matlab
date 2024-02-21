function [freq,c] = computeComplexFourierCoef(y, fs, n_modes)
    % This function estimates the complex coef. for the 
    % complex Fourier transform using the trapezoid rule
    
    tc = 1/fs*(0:(length(y)-1));
    L = tc(end)/2; % The domain is assumed to be 2L
    nvec = -n_modes:n_modes;
    freq = nvec/(2*L); % Frequencies

    % Estimate coefficients using trapezoid rule
    c = zeros(numel(nvec), 1);
    for k = nvec + n_modes + 1
        c(k) = 1/(2*L)*trapz(tc, exp(-1i*nvec(k)*pi/L*tc).*y');
    end
end