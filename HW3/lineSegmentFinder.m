function cropped_line_img = lineSegmentFinder(orig_img, edge_img, hough_img, hough_threshold)


[m,n] = size(hough_img);
[l,k] = size(edge_img);


fh1 = figure();
imshow(orig_img);
hold on;



for i = 1:m
    for j = 1:n
        if(hough_img(i,j) > hough_threshold)
            
            first_check = false;
            
            for iter1 = 1:m
                for iter2 = 1:n
                    if(iter1 == i && iter2 == j)
                        continue;
                    end
                    
                    if(hough_img(iter1, iter2) > hough_threshold && hough_img(iter1, iter2) > hough_img(i,j))
                        if((i-iter1) <= 7 && (i-iter1) >= 0 && abs(j-iter2) < 5)
                            first_check = true;
                        elseif((iter1-i) < 7 && (iter1 - i) >= 0 && abs(j-iter2) < 5)
                            first_check = true;
                        elseif((j >= 179) && (iter2<=2))
                            first_check = true;
                            break;
                      
                        end
                    elseif(hough_img(iter1, iter2) > hough_threshold && hough_img(iter1, iter2) == hough_img(i,j))
                        if(i-iter1 < 7 && i-iter1 >= 0 && abs(j-iter2) < 5)
                            first_check = true;
                            break;
                        end
                    end 
                            
                end
            end
            
            if(first_check == false)
                
                if(j == 91)
                    
                   x_1 = i-1-800;
                   x_2 = i-1-800;
                   y_1 = -1;
                   y_2 = -1;
                   for q = 1:l
                 
                      second_check = false;
                   
                       for r = x_1-3:x_1+3
                           if(edge_img(q,r) == 255)
                              second_check = true;
                           end
                       end
                   
                       if(second_check == true)
                           if(y_1 == -1)
                               y_1 = q;
                               y_2 = q;
                           else
                               y_2 = q;
                           end
                       else
                            if(y_1 ~= -1)
                               line([x_1 x_2],[y_1 y_2], 'LineWidth',2);
                               y_1 = -1;
                               y_2 = -1;
                            end
                       end
                  
                   end
                elseif(j > 80 && j < 100)
                    
                    x_1 = -1;
                    x_2 = -1;
                    y_1 = -1;
                    y_2 = -1;
                    
                    for it1 = 2:l-1
                        rad = ((j-1)*pi)/180;
                        value = (cos(rad)/sin(rad))*it1 - ((800-i+1)/sin(rad));
                        value = round(value);
                        
                        third_check = false;
                        
                        if(value >= 4 && value <= k-3)
                            
                            for t = value - 3: value + 3
                                for u = it1-1:it1+1
                                    if(edge_img(u,t) == 255)
                                        third_check = true;
                                        break;
                                    end
                                end
                                if(third_check == true)
                                    break;
                                end
                            end
                            
                            if(third_check == true)
                                if(x_1 == -1)
                                    x_1 = value;
                                    x_2 = value;
                                    y_1 = it1;
                                    y_2 = it1;
                                else
                                    x_2 = value;
                                    y_2 = it1;
                                end
                            else
                                if(x_1 ~= -1)
                                    line([x_1 x_2],[y_1 y_2], 'LineWidth',2);
                                    x_1 = -1;
                                    x_2 = -1;
                                    y_1 = -1;
                                    y_2 = -1;
                                end
                            end
                        end
                    end
                    
                    if(x_1 ~= -1)
                       line([x_1 x_2],[y_1 y_2], 'LineWidth',2);
                  
                    end
                        
                else
                    x_1 = -1;
                    x_2 = -1;
                    y_1 = -1;
                    y_2 = -1;
                    
                    for it1 = 3:k-2
                        
                        rad = ((j-1)*pi)/180;
                        value = (sin(rad)/cos(rad))*it1 + ((800-i+1)/cos(rad));
                        value = round(value);
                        
                        fourth_check = false;
                        if(value >= 4 && value <= l-3)
                            
                            for t = it1-1:it1+1
                                for u = value-3:value+3
                                    if(edge_img(u,t) == 255)
                                        fourth_check = true;
                                        break;
                                    end
                                end
                                
                                if(fourth_check == true)
                                    break
                                end
                                
                            end
                            
                            if(fourth_check == true)
                                if(x_1 == -1)
                                    x_1 = it1;
                                    x_2 = it1;
                                    y_1 = value;
                                    y_2 = value;
                                else
                                    x_2 = it1;
                                    y_2 = value;
                                end
                            else
                                if(x_1 ~= -1)
                                    line([x_1 x_2],[y_1 y_2], 'LineWidth',2);
                                    x_1 = -1;
                                    x_2 = -1;
                                    y_1 = -1;
                                    y_2 = -1;
                                end
                            end
                            
                        end
                    end
                    
                    if(x_1 ~= -1)
                       line([x_1 x_2],[y_1 y_2], 'LineWidth',2);
                  
                    end
                end
                
            end
            
        end
    end
end


         

figure(fh1); % Shift the focus back to the figure fh

% The figure needs to be undocked
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
% Because getframe tries to perform a screen capture. it somehow 
% has some platform depend issues. we should calling
% getframe twice in a row and adding a pause afterwards make getframe work
% as expected. This is just a walkaround. 
annotated_img = frame.cdata;

cropped_line_img = annotated_img;

 