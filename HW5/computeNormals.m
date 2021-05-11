function [normals, albedo_img] = ...
    computeNormals(light_dirs, img_cell, mask)

curr_img1 = img_cell{1};
curr_img2 = img_cell{2};
curr_img3 = img_cell{3};
curr_img4 = img_cell{4};
curr_img5 = img_cell{5};

[m,n] = size(curr_img1);

normals = zeros(m,n,3);
albedo_img = zeros(m,n);

for i = 1:m
    for j = 1:n
        
        if(mask(i,j) == 1)
                        
    
            S_5x3 = zeros(5,3);
            I = zeros(5,1);
            
            I(1,1) = im2double(curr_img1(i,j)); 
            I(2,1) = im2double(curr_img2(i,j));
            I(3,1) = im2double(curr_img3(i,j));
            I(4,1) = im2double(curr_img4(i,j));
            I(5,1) = im2double(curr_img5(i,j));
            
            S_5x3(1,1) = light_dirs(1,1);
            S_5x3(1,2) = light_dirs(1,2);
            S_5x3(1,3) = light_dirs(1,3);
            S_5x3(2,1) = light_dirs(2,1);
            S_5x3(2,2) = light_dirs(2,2);
            S_5x3(2,3) = light_dirs(2,3);
            S_5x3(3,1) = light_dirs(3,1);
            S_5x3(3,2) = light_dirs(3,2);
            S_5x3(3,3) = light_dirs(3,3);
            S_5x3(4,1) = light_dirs(4,1);
            S_5x3(4,2) = light_dirs(4,2);
            S_5x3(4,3) = light_dirs(4,3);
            S_5x3(5,1) = light_dirs(5,1);
            S_5x3(5,2) = light_dirs(5,2);
            S_5x3(5,3) = light_dirs(5,3);
            
            
            S_T = S_5x3.';
            S_T_S = S_T * S_5x3;
            inverse_STS = inv(S_T_S);
            STS_inv_ST = inverse_STS * S_T;
            N = STS_inv_ST * I;
            
            albedo = sqrt(N(1,1)^2 + N(2,1)^2 + N(3,1)^2);
           
            normal_x = (N(1,1)) / sqrt(N(1,1)^2 + N(2,1)^2 + N(3,1)^2);
            normal_y = (N(2,1)) / sqrt(N(1,1)^2 + N(2,1)^2 + N(3,1)^2);
            normal_z = (N(3,1)) / sqrt(N(1,1)^2 + N(2,1)^2 + N(3,1)^2);
            
            albedo_img(i,j) = albedo;
            normals(i,j,1) = normal_x;
            normals(i,j,2) = normal_y;
            normals(i,j,3) = normal_z;
            
        else
            normals(i,j,1)= 0;
            normals(i,j,2) = 0;
            normals(i,j,3) = 1;
         end
    end
end

max_albedo = 0;

for i = 1:m
    for j = 1:n
        
        if(albedo_img(i,j) > max_albedo)
            max_albedo = albedo_img(i,j);
        end
        
    end
end


for i = 1:m
    for j = 1:n
        albedo_img(i,j) = albedo_img(i,j) / max_albedo;
    end
end



end
