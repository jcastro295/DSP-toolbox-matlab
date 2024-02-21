function [xn] = idft_for_loop(Xk, N) 
    % Function to calculate IDFT 
	% This function computes the N-point IDFT of a signal x(n)
    % Xk : Input signal in dicrete-time domain
    % N: length of transformed signal x(n)

    L = length(Xk); 

    if nargin < 2
        N = L;
    end
    
    if N < L 
        Xk = Xk(:,1:N);
    end
    
    X1 = [Xk, zeros(1,N-L)]; 
    
    W = zeros(N);
    for k = 0:N-1 
        for n = 0:N-1 
	        W(k+1,n+1) = exp(1i*2*pi*n*k/N); 
        end
    end

    xn = (W'*X1')/N; 

end


