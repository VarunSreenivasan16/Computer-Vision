function translation = stitching_helper3(inp_img1, inp_img2)

[xs, xd] = genSIFTMatches(inp_img1, inp_img2);
[inliers_id, H] = runRANSAC(xs, xd, 100, 1);

translation = 0;

for i = 1:size(inliers_id,1)
        y_length = xd(inliers_id(i),2) - xs(inliers_id(i),2);
        translation = translation + y_length;
end

translation = translation/size(inliers_id,1);
translation = round(translation);


end

