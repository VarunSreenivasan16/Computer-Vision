function out_mask = stitching_helper5(img,mask)

[m,n] = size(mask);

for i = 1:m
    for j = 1:n
        if(img(i,j,1) == 0 && img(i,j,2) == 0 && img(i,j,3) == 0)
            mask(i,j) = 0;
        else
            mask(i,j) = 1;
        end
    end
end

out_mask = mask;


end

