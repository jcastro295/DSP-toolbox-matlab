function [xn] = ifft_coded(x)
    xn = ifft_core(x)/length(x);
end

function [xn] = ifft_core(x)

    %A recursive implementation of 
    %the 1D Cooley-Tukey IFFT, the 
    %input should have a length of 
    %power of 2. 

    N = length(x);

    if N == 1
        xn = x;
    else
        x_odd = ifft_core(x(1:2:end));  % recursive call for odd-indexed elements of x
        x_even = ifft_core(x(2:2:end));   % recursive call for even-indexed elements of x
        Wn = exp(2i*pi*(0:N-1)/ N);

        xn = horzcat(x_odd + Wn(1:round(N/2)).*x_even, ...
                     x_odd + Wn(round(N/2)+1:end).*x_even);

    end
end