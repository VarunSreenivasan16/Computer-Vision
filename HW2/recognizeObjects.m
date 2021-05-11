function output_img = recognizeObjects(orig_img, labeled_img, obj_db)

[m1, n1] = size(obj_db);

[obj_db2, out_img2] = compute2DProperties(orig_img, labeled_img);

[m2, n2] = size(obj_db2);

output_img = orig_img;

color1 = {'blue'};
color2 = {'red'};


for i = 1 : n1
    for j = 1 : n2
        if(abs(obj_db(6,i) - obj_db2(6, j)) < 0.03)
            
            centroid = zeros(1,2);
            centroid(1,1) = obj_db2(3,j);
            centroid(1,2) = obj_db2(2,j);
            output_img = insertMarker(output_img, centroid,'*', 'color', color1, 'size', 10);
        
            lines = zeros(1,4);
            lines(1,1) = obj_db2(3,j);
            lines(1,2) = obj_db2(2,j);
            lines(1,3) = obj_db2(3,j) + cosd(obj_db2(5,j))*50;
            lines(1,4) = obj_db2(2,j) + sind(obj_db2(5,j))*50;
            output_img = insertShape(output_img, 'Line', lines, 'Color', color2, 'LineWidth',5);
   
        
        end
    end
end
 
    
