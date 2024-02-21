function [Gxx_all, f, t] = spectrogram_coded(x, window, noverlap, nfft, fs)
% This function uses the same Matlab implementation to return the power spectral density from the time series x
% Args:
%     x (np.ndarray): Time series
%     fs (float): sampling frequency, Hz
%     nfft (int): number of samples for each FFT
%         frequency bin size, df = nfft/fs
%     window (np.ndarray): Time window. Use window to divide the signal into segments.
% 
% Returns:
%     Gxx : ndarray of float
%         PSD in in linear units
%     t : ndarray of float
%         t is the time array corresponding to the time steps
%     f : ndarray of float
%         f is the frequency array

    W = mean(window.*window); % normalizing factor
    nx = length(window);  % Window size
    time_step = nx/fs; % Time spacing
    total_time = length(x)/fs;
    % determine how many unique times will be in the final spectrogram
    perc_noverlap = noverlap/nx;             % Overlap in percentage 0-99
    time_step = time_step*(1-perc_noverlap); % Time spacing
    nt = floor(total_time/time_step);   % Number of time points
    % make time array of final spectrogram
    t = (1:nt-2)*time_step + time_step;
    % make nt an integer
    nt = int16(nt);
    f = fftfreq(nfft,1/fs);
    f = f(1:ceil(nfft/2)+1);
    
    % number of frequencies returned from the FFT
    nf = length(f);
    
    Gxx_all = zeros(nt,nf);
    nstart=1;

    for time_idx = 1 : nt-1
        % beginning at index nstart sample, do the FFT on a signal ns samples in length
        nstop = nstart + nx;
        
        x1 = x(nstart:min(nstop-1,length(x)));

        if length(x1) == nx
            % apply the window
            x1 = x1'.*window;
            if nx > nfft % If the number of time steps is greater than nfft then do a cyclic average
                n_aux = int16(ceil(nx/nfft)) ;
                new_size = n_aux*nfft;
                x1 = reshape(x1, new_size);
                if new_size > nx
                    x1(nx:end) = 0;
                end
                x1 = reshape(n_aux,nfft);
                x1 = sum(x1);
            end
        
            % calculate the fft for a single change and the time_idx time sample
            % and extract the single sided part
            Xss = fft(x1, nfft);
            Xss = Xss(1:int16(nfft/2)+1);
            
            % create scale value
            Scale = (2/nfft/fs/W)/(nx/nfft);
            
            % multiply by our scale value and force the dtype back to original dtype
            Gxx1 = Scale.*(conj(Xss).*Xss);
            
            Gxx_all(time_idx,:) = real(Gxx1);
            
            % update nstart to the next time step
            nstart = nstart + nx - noverlap;
        else
            Gxx_all = Gxx_all(1:nt-3,:);
            t = t(1:nt-3);
        end
    end
    Gxx_all(:,1) = Gxx_all(:,1)/2;       % Unscale the factor of two. Don't double unique Nyquist point
    Gxx_all(:,nf-1) = Gxx_all(:,nf-1)/2; % Unscale the factor of two. Don't double unique Nyquist point
    end

function f=fftfreq(npts,dt,alias_dt)
% returns a vector of the frequencies corresponding to the length
% of the signal and the time step.
% specifying alias_dt > dt returns the frequencies that would
% result from subsampling the raw signal at alias_dt rather than
% dt.
    
    
  if (nargin < 3)
      alias_dt = dt;
  end
  fmin = -1/(2*dt);
  df = 1/(npts*dt);
  f0 = -fmin;
  alias_fmin = -1/(2*alias_dt);
  f0a = -alias_fmin;
  
  ff = mod(linspace(0, 2*f0-df, npts)+f0,  2*f0)  - f0;
  fa = mod(                        ff+f0a, 2*f0a) - f0a;
  %  return the aliased frequencies
  f = fa;
end