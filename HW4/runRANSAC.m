function [inliers_id, H] = runRANSAC(Xs, Xd, ransac_n, eps)

num_rows = size(Xs,1);


max_inliers = 0;
inliers_id = [];
H = zeros(3,3);


for i = 1:ransac_n
    
    samp_index = randperm(num_rows, 4);
   
    src_pts = [Xs(samp_index(1), 1) Xs(samp_index(1),2);...
        Xs(samp_index(2),1) Xs(samp_index(2), 2); Xs(samp_index(3),1) Xs(samp_index(3), 2);...
        Xs(samp_index(4),1) Xs(samp_index(4), 2)];
    dest_pts = [Xd(samp_index(1), 1) Xd(samp_index(1),2);...
        Xd(samp_index(2),1) Xd(samp_index(2), 2); Xd(samp_index(3),1) Xd(samp_index(3), 2);...
        Xd(samp_index(4),1) Xd(samp_index(4), 2)];
    
   H_3x3 = computeHomography(src_pts, dest_pts);

   num_inliers = 0;
   inlier_check = zeros(num_rows, 1);
   
   for j = 1:num_rows
       
       temp = [Xs(j,1) Xs(j,2)];
       output = applyHomography(H_3x3, temp);
       
       error = sqrt((output(1) - Xd(j,1))^2 + (output(2) - Xd(j,2))^2);
       if(error <= eps)
           num_inliers = num_inliers + 1;
           inlier_check(j) = 1;
       end
       
   end
   
   if(num_inliers > max_inliers)
      max_inliers = num_inliers;
      H = H_3x3;
      inliers_id = zeros(num_inliers, 1);
      num_added = 1;
           
      for k = 1:size(inlier_check,1)
          if(inlier_check(k) == 1)
               inliers_id(num_added) = k;
               num_added = num_added + 1;
          end
      end
           
    end

end

end