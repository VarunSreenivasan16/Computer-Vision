function out_img = stitching_helper2(inp_img,H_3x3)

[m_img, n_img, c_img] = size(inp_img);


x_min = intmax;
x_max = intmin;
y_min = intmax;
y_max = intmin;


for i = 1:m_img
    for j=1:n_img
        src_pts = [j, i];
        dest_pts = applyHomography(H_3x3, src_pts);
        x = dest_pts(1);
        y = dest_pts(2);
        if(x < x_min)
            x_min = x;
        end
        if(x > x_max)
            x_max = x;
        end
        if(y < y_min)
            y_min = y;
        end
        if(y > y_max)
            y_max = y;
        end
        
    end
end
    

num_x_units = x_max - x_min+1;
num_y_units = y_max - y_min+1;

changed_img = zeros(num_y_units, num_x_units, 3);


inv_H = inv(H_3x3);

for i = 1:num_y_units
    for j = 1:num_x_units
     
        x_val = j + x_min - 1;
        y_val = i + y_min - 1;
        
        src_p = [x_val, y_val];
        des_p = applyHomography(inv_H, src_p);
        
        if(des_p(1) >= 1 && des_p(1) <= n_img && des_p(2) >= 1 && des_p(2) <= m_img)
            changed_img(i,j,1) = inp_img(des_p(2), des_p(1),1);
            changed_img(i,j,2) = inp_img(des_p(2), des_p(1),2);
            changed_img(i,j,3) = inp_img(des_p(2), des_p(1),3);
        end
        
    end
end


out_img = changed_img;

end

