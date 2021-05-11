function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)

[m,n] = size(hough_img);
[l,k] = size(orig_img);


fh1 = figure();
imshow(orig_img);
hold on;

for i = 1:m
    for j=1:n
        
        if(hough_img(i,j) > hough_threshold)
            
            check = false;
            
            for it1 = 1:m
                for it2 = 1:n
                    
                    if(it1 == i && it2 == j)
                        continue;
                    end 
                   
                    if(hough_img(it1, it2) > hough_threshold)
                         
                        if(hough_img(it1, it2) > hough_img(i,j))
                             if((i-it1) >= 0 && (i-it1) < 8 && abs(j-it2) <5)
                                 check = true;
                                 break
                             elseif((it1-i) < 7 && (it1 - i) >= 0  && abs(j-it2) < 5)
                                check = true;
                                break;
                             elseif((j >= 179) && (it2<=2))
                                 check = true;
                                 break;
                             end
                        elseif(hough_img(it1, it2) == hough_img(i,j))
                           
                            if(i-it1 < 7 && i-it1 >= 0 && abs(j-it2) < 5)
                                check = true;
                                break;
                            end
                        
                        end
                        
                    end
                     
                   
                end
            end
                    
            
            if(check == false)
                
                 rad = ((j-1)*pi)/180;
            
                 if(j == 91)
                    y_1 = 0;
                    x_1 = i-1-800;
                    y_2 = l;
                    x_2 = i-1-800;
                    line([x_1 x_2],[y_1 y_2], 'LineWidth',2);
                 else
                    x_1 = 0;
                    x_2 = k;
                    y_1 = (800-i+1)/cos(rad);
                    y_2 = (sin(rad)/cos(rad))*x_2 + ((800-i+1)/cos(rad));
                    line([x_1 x_2],[y_1 y_2], 'LineWidth',2);
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

line_detected_img = annotated_img;







