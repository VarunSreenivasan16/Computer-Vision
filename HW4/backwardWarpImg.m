function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)


width = dest_canvas_width_height(1);
height = dest_canvas_width_height(2);

[src_height, src_width, channel] = size(src_img);

result_img = zeros(height, width, 3);
mask = zeros(height, width);

for i = 1:height
    for j = 1:width
        point = [j i];
        result_pts = applyHomography(resultToSrc_H, point);
        
        x_val = result_pts(1);
        y_val = result_pts(2);
        
        if(x_val < 1 || x_val > src_width || y_val < 1 || y_val > src_height)
            continue;
        end
        
        mask(i,j) = 1;
     
        channel_1 = src_img(y_val, x_val, 1);
        channel_2 = src_img(y_val, x_val, 2);
        channel_3 = src_img(y_val, x_val, 3);
        
        result_img(i, j, 1) = channel_1;
        result_img(i, j, 2) = channel_2;
        result_img(i, j, 3) = channel_3; 
        
    end
end

