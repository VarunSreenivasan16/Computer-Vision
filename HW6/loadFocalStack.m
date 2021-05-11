function [rgb_stack, gray_stack] = loadFocalStack(focal_stack_dir)

file = dir(focal_stack_dir +"\*.jpg");
l = length(file);

dictionary = {file.name};

[sorted_order, indices] = sort_files(dictionary);


gray_stack = 1;
rgb_stack = 1;


for i=1:l
    file_name = sorted_order(i);
    orig_img = imread(focal_stack_dir + "\" + file_name);
    gray_img = rgb2gray(orig_img);
    
    if(i == 1)
        rgb_stack = orig_img;
        gray_stack = rgb2gray(orig_img);
    end
    
    gray_stack = cat(3, gray_stack, gray_img);
    rgb_stack = cat(3, rgb_stack, orig_img);
    
end

end