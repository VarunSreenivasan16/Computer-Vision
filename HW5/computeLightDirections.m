function light_dirs_5x3 = computeLightDirections(center, radius, img_cell)

light_dirs_5x3 = zeros(5,3);

for k = 1:5
    
    curr_img = img_cell{k};
  
    [m,n] = size(curr_img);
   
    
    max_i = 0;
    max_j = 0;
    
    max_intensity = 0;
    
    for i = 1:m
        for j = 1:n
            if(curr_img(i,j) > max_intensity)
                max_intensity = curr_img(i,j);
                max_i = i;
                max_j = j;
            end
        end
    end
    
    
    x_val = max_j - center(1);
    y_val = max_i - center(2);
    
    
    z_val = sqrt(radius^2 - x_val^2 - y_val^2);
    
    scaled_x_val = x_val / radius;
    scaled_y_val = y_val / radius;
    scaled_z_val = z_val / radius;
    
    max_intensity = double(max_intensity);
    
    
    scaled_x_val = max_intensity * scaled_x_val;
    scaled_y_val = max_intensity * scaled_y_val;
    scaled_z_val = max_intensity * scaled_z_val;
    
    light_dirs_5x3(k,1) = scaled_x_val;
    light_dirs_5x3(k,2) = scaled_y_val;
    light_dirs_5x3(k,3) = scaled_z_val;
    
   
end


end