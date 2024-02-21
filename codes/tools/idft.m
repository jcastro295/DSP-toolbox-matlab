function [xn] = idft(Xk,N)

    % Computes Inverse Discrete Transform
    % [xn] = idft(Xk,N)
    % xn = N-point sequence over 0 <= n <= N-1
    % Xk = DFT coeff. array over 0 <= k <= N-1
    % N = length of DFT
    
    L = length(Xk); 

    if nargin < 2
        N = L;
    end
    
    if N < L 
        Xk = Xk(:,1:N);
    end
    
    Xk = [Xk, zeros(1,N-L)]; 

    n = 0:1:N-1;                  % row vector for n
    k = 0:1:N-1;                  % row vecor for k

    WN = exp(-1i*2*pi/N);         % Wn factor
    nk = n'*k;                    % creates a N by N matrix of nk values
    WNnk = WN .^ (-nk);           % IDFT matrix
    
    xn = (Xk * WNnk)/N;           % row vector for IDFT values

end