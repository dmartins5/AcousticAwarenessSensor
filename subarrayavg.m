% THIS FUNCTION WILL TAKE AN VECTOR OF DATA AND SPLIT IT INTO SMALLER
% VECTORS AND AVERAGE THEM

% n = number of samples in subarray
%k = starting point for subarray 

%%


function [s_avg, subarray] = subarrayavg(samples_vec, n, k)

for c = k:n
    subarray([1,c]) = samples([]);
    
    s_avg = mean(subarray);
    
end
    