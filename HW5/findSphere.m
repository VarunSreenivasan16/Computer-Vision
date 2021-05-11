function [center, radius] = findSphere(img)



bw_img = im2bw(img, 0.000000001);
struct_center = regionprops(bw_img, 'centroid');
struct_area = regionprops(bw_img, 'Area');
area = struct_area.Area;
radius = sqrt(area/pi);
center = struct_center.Centroid;



