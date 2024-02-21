function [dirac] = diracseq(n, a)
    % return the delta(n-a)
    dirac = double(n == a);
end