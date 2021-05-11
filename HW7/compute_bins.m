function hist_out = compute_bins(weights,index, num_bins)

[m,n] = size(weights);

hist_out = zeros(num_bins,1);

for i = 1:m
    for j = 1:n
        val = index(i,j);
        weight = weights(i,j);
        hist_out(val+1,1) = hist_out(val+1,1) + weight;
    end
end


end

