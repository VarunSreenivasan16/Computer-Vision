function trackingTester(data_params, tracking_params)

disp("Frame 1");
first_img = imread(fullfile(data_params.data_dir,...
     data_params.genFname(data_params.frame_ids(1))));
xmin = tracking_params.rect(1);
ymin = tracking_params.rect(2);
width = tracking_params.rect(3);
height = tracking_params.rect(4);
 
[ind, map] = rgb2ind(first_img(ymin:ymin+height, xmin:xmin+width,1:3), tracking_params.bin_n);
[m,n] = size(ind);

weights = zeros(m,n);

center_y = (m+1)/2;
center_x = (n+1)/2;


for i = 1:m
    for j = 1:n
        y_comp = (i - center_y)/((m+1)/2);
        x_comp = (j - center_x)/((n+1)/2);
        weighted = sqrt((y_comp.^2) + (x_comp.^2)); 
        
        if(weighted < 1)
           weights(i,j) = 1 - (weighted.^2);
        end
    end
end


bins = compute_bins(weights,ind, tracking_params.bin_n);
mean_in = sum(bins)/tracking_params.bin_n;

init_img = drawBox(first_img, [xmin ymin width height], [0 0 0], 3);
imwrite(init_img, fullfile(data_params.out_dir,data_params.genFname(data_params.frame_ids(1))));

n_frames = numel(data_params.frame_ids);

for i = 2:n_frames
    disp("Frame " + i);
    curr_frame_id = data_params.frame_ids(i);
    I = imread(fullfile(data_params.data_dir,data_params.genFname(curr_frame_id)));
    
    search_window_x_min = max(1, xmin - tracking_params.search_half_window_size);
    search_window_y_min = max(1, ymin - tracking_params.search_half_window_size);
    search_window_x_max = min(size(I,2), xmin + width + tracking_params.search_half_window_size);
    search_window_y_max = min(size(I,1), ymin + height + tracking_params.search_half_window_size);
    
    translation_y = search_window_y_max - search_window_y_min - height;
    translation_x = search_window_x_max - search_window_x_min - width;
    
    saved_min_x = 0;
    saved_min_y = 0;
    max_corr = -1;
    
    for j = 0:translation_y
        for k = 0:translation_x
            [ind_temp, map_temp] = rgb2ind(I(search_window_y_min + j:search_window_y_min + j + height, ...
                   search_window_x_min + k: search_window_x_min + k + width,1:3), tracking_params.bin_n);
            
             bins_temp = compute_bins(weights, ind_temp, tracking_params.bin_n);
             mean_temp = sum(bins_temp)/tracking_params.bin_n;
             
             part1 = 0;
             part2 = 0;
             part3 = 0;
             
             for l = 1:tracking_params.bin_n
                 part1 = part1 + ((bins_temp(l) - mean_temp) * (bins(l) - mean_in));
                 part2 = part2 + ((bins_temp(l) - mean_temp)^2);
                 part3 = part3 + ((bins(l) - mean_in) ^2);
             end
              
             corr = part1 / (sqrt(part2) * sqrt(part3));
             
             if(corr > max_corr)
                 
                 max_corr = corr;
                 saved_min_x = search_window_x_min + k;
                 saved_min_y = search_window_y_min + j;
             end
            
        end
    end
    
    output_img = drawBox(I, [saved_min_x saved_min_y width height], [0 0 0], 3);
    imwrite(output_img, fullfile(data_params.out_dir,data_params.genFname(data_params.frame_ids(i))));
    xmin = saved_min_x;
    ymin = saved_min_y;

end

end