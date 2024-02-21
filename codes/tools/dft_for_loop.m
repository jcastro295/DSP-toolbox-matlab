function[Xk] = dft_for_loop(xn, N) 
    % Function to compute DFT
    % This function computes the N-point DFT of a signal x(n)
    % xn : Input signal in dicrete-time domain
    % N: length of transformed signal X(k)

    L = length(xn);

    if nargin < 2
        N = L;
    end
    
    if N < L 
        xn = xn(:,1:N);
    end
    
    x1 = [xn, zeros(1,N-L)]; 
    
    W = zeros(N);
    for k = 0:N-1 
        for n = 0:N-1 
            W(k+1,n+1) = exp(-1i*2*pi*n*k/N); 
        end
    end
    
    Xk = W*x1'; 
    
end
