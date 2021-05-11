function result = computeFlow(img1, img2, win_radius, template_radius, grid_MN)

rows = grid_MN(1);
columns = grid_MN(2);

[img_rows, img_cols] = size(img1);

U = zeros(img_rows, img_cols);
V = zeros(img_rows, img_cols);

for i = 1:rows
    for j = 1:columns
        index_i = ((i-1)* (template_radius*2 + 1)) + template_radius + 1;
        index_j = ((j-1)* (template_radius *2 + 1)) + template_radius + 1;
        
        template = img1(index_i - template_radius: index_i+template_radius, ...
            index_j - template_radius : index_j + template_radius);
        
        temp = unique(template);
        
        if(size(temp,1) < 2)
            continue
        end
        
        search = img2(max(1, index_i - template_radius - win_radius): min(index_i + win_radius + template_radius, size(img2, 1)), ...
            max(1, index_j - win_radius - template_radius): min(index_j + win_radius + template_radius, size(img2, 2)));
        
        matching_center_y = index_i - max(1, index_i-template_radius - win_radius);
        matching_center_x = index_j - max(1, index_j - template_radius - win_radius);
        c = normxcorr2(template, search);
       
        [ypeak,xpeak] = find(c==max(c(:)));
       
        xpeak = xpeak - ceil(size(template,2)/2);
        ypeak = ypeak - ceil(size(template,1)/2);
        
        disp_x = xpeak - matching_center_x;
        disp_y = ypeak - matching_center_y;
       
        if(abs(disp_x) <= 10 && abs(disp_y) <= 10)
            U(index_i,index_j) = disp_x;
            V(index_i,index_j) = disp_y;
        end

    end
end

%fix top right
index_temp_i = template_radius + 1;
index_temp_j = ((columns-1)* (template_radius *2 + 1)) + template_radius + 1;
index_prev_j = ((columns-2)* (template_radius *2 + 1)) + template_radius + 1;
U(index_temp_i, index_temp_j) = U(index_temp_i, index_prev_j);
V(index_temp_i, index_temp_j) = V(index_temp_i, index_prev_j);


fh1 = figure();
int_result = img1;
imshow(int_result);
axis equal;
hold on;
quiver(U,V,15, 'Color', 'Yellow', 'LineWidth', 1);

figure(fh1); 
set(fh1, 'WindowStyle', 'normal');

% The following two lines just to make the figure true size to the
% displayed image. The reason will become clear later.
img = getimage(fh1);
truesize(fh1, [size(img, 1), size(img, 2)]);

% getframe does a screen capture of the figure window, as a result, the
% displayed figure has to be in true size. 
frame = getframe(fh1);
frame = getframe(fh1);
pause(0.5); 

result = frame.cdata;
delete(fh1);
