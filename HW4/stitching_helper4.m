function common_x = stitching_helper4(inp_img1, inp_img2)

[xs, xd] = genSIFTMatches(inp_img1, inp_img2);
[inliers_id, H] = runRANSAC(xs, xd, 100, 1);


[m1,n1,c1] = size(inp_img1);

common_x = 0;
for i = 1:size(inliers_id,1)
    length_line = (n1 - xs(inliers_id(i),1)) + xd(inliers_id(i),1);
    common_x = common_x + length_line;
end

common_x = common_x / size(inliers_id,1);
common_x = round(common_x);




end


