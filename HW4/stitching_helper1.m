function H_3x3 = stitching_helper1(inp_img1,inp_img2)

[xs, xd] = genSIFTMatches(inp_img1, inp_img2);

ransac_n = 100; % Max number of iteractions
ransac_eps = 1; %Acceptable alignment error 

[inliers_id, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);


end

