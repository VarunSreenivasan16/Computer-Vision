function refocusApp(rgb_stack, depth_map)

[m,n] = size(depth_map);

init_index = randi([1 25], 1);
disp_img = rgb_stack(:,:, init_index*3-2:init_index*3);
fh1 = figure();
imshow(disp_img);

while 1
    
    [xs1,ys1,but] = ginput(1);
    xs1 = round(xs1);
    ys1 = round(ys1);
    
    
    if(xs1 <= 0 || xs1 > n || ys1 <= 0 || ys1 > m)
        delete(fh1);
        break
    end
    
    index = depth_map(ys1, xs1);
    disp_img = rgb_stack(:,:, index*3-2: index*3);
    imshow(disp_img);
    
    
end

end