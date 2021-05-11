function [obj_db, out_img] = compute2DProperties(orig_img, labeled_img)



[m,n] = size(labeled_img);

max = 0;

for i = 1:m
    for j = 1:n
        
        if labeled_img(i,j) > max
            max = labeled_img(i,j);
        
        end
    end
end


obj_db = zeros(6,max);
centroid = zeros(max,2);
lines = zeros(max, 4);

for i = 1:max
    [r,c] = find(labeled_img==i);
    row_mean = mean(r);
    col_mean = mean(c);
    obj_db(1,i) = i;
    obj_db(2,i) = row_mean;
    obj_db(3,i) = col_mean;
    centroid(i,1) = col_mean;
    centroid(i,2) = row_mean;
    a = 0;
    b = 0;
    c = 0;
    
    
    for j = 1:m
        for k = 1:n
            if(labeled_img(j,k) == i)  
                a = a + ((k-col_mean)^2);
                b = b + ((j-row_mean)*(k-col_mean));
                c = c + ((j-row_mean)^2);
            end
        end
    end
    b = b*2;
   
    
    rad_min = atan2(b, a-c)/2;
    rad_max = rad_min + pi/2;
    
    lines(i,1) = col_mean;
    lines(i,2) = row_mean;
    lines(i,3) = col_mean + cos(rad_min)*50;
    lines(i,4) = row_mean + sin(rad_min)*50;
   
    
    E_min = ((a * (sin(rad_min)^2)) - (b * (sin(rad_min)*cos(rad_min))) + (c * (cos(rad_min)^2)));
    E_max = ((a * (sin(rad_max)^2)) - (b * (sin(rad_max)*cos(rad_max))) + (c * (cos(rad_max)^2)));
    obj_db(4,i) = E_min;
    obj_db(5,i) = (180/pi) * rad_min;
    obj_db(6,i) = E_min/E_max;
    
end


color1 = {'blue'};
color2 = {'red'};

out_img = insertMarker(orig_img, centroid, '*', 'color', color1, 'size', 10);

for i = 1:max
    out_img = insertShape(out_img, 'Line', [lines(i,1) lines(i,2) lines(i,3) lines(i,4)],....
    'Color', color2, 'LineWidth',5);
end




