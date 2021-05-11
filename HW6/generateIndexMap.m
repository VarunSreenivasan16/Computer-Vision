function index_map = generateIndexMap(gray_stack, w_size)

[m,n,c] = size(gray_stack);

i = 1:1:c;
 
h_x = [-1 0 1; -2 0 2; -1 0 1];
h_y = [1 2 1; 0 0 0; -1 -2 -1];

sb_x_1 = imfilter(gray_stack(:,:,i), h_x);
sb_x_2 = imfilter(sb_x_1(:,:,i), h_x);

sb_y_1 = imfilter(gray_stack(:,:,i), h_y);
sb_y_2 = imfilter(sb_y_1(:,:,i), h_y);

after_laplacian = abs(sb_y_2(:,:,i)) + abs(sb_x_2(:,:,i));

window_size = w_size * 2 + 1;

h = ones(window_size,window_size);

focus_measure = imfilter(after_laplacian, h, 'conv');

h1 = fspecial('gaussian', [101 101], 38);

focus_measure = imfilter(focus_measure, h1);

[max_array, index] = max(focus_measure, [],3);
index_map = index;
     
%imshow(index_map, [1 25]);

end
