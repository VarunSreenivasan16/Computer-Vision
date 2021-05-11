function result_img = ...
    showCorrespondence(orig_img, warped_img, src_pts_nx2, dest_pts_nx2)

[m,n, t] = size(orig_img);
[it1, it2] = size(src_pts_nx2);
color2 = {'red'};

result_img = cat(2, orig_img, warped_img);

for i = 1:it1
    x_1 = src_pts_nx2(i,1);
    x_2 = dest_pts_nx2(i,1)+n;
    y_1 = src_pts_nx2(i,2);
    y_2 = dest_pts_nx2(i,2);
    
    lines = zeros(1,4);
    lines(1) = x_1;
    lines(2) = y_1;
    lines(3) = x_2;
    lines(4) = y_2;
    result_img = insertShape(result_img, 'Line', lines, 'Color', color2, 'LineWidth',5);

end


