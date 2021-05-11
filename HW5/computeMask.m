function mask = computeMask(img_cell)

[m,n] = size(img_cell{1});

mask = zeros(m, n);

curr_img1 = img_cell{1};
curr_img2 = img_cell{2};
curr_img3 = img_cell{3};
curr_img4 = img_cell{4};
curr_img5 = img_cell{5};

for i = 1:m
    for j = 1:n
        if(curr_img1(i,j) > 0 || curr_img2(i,j) > 0 || curr_img3(i,j) || ...
                curr_img4(i,j) > 0 || curr_img5(i,j) > 0)
                   mask(i,j) = 1;
        end
    end
end

end