function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)

[m,n] = size(img);

matrix = zeros(rho_num_bins, theta_num_bins);
max_rho = 800;


for i = 1:m
    for j= 1:n
        if(img(i,j) == 255)
            for l = 1:theta_num_bins
                rad = ((l-1)*pi)/180;
                rho = round(i*cos(rad) - j*sin(rad));
                index = max_rho + 1 - rho;
                matrix(index,l) = matrix(index,l)+ 1;
            end
        end
    end
end



maximum = 0;

for i = 1:rho_num_bins
    for j = 1:theta_num_bins
       if(matrix(i,j) > maximum)
            maximum = matrix(i,j);
        end
    end
end


for i = 1:rho_num_bins
    for j = 1:theta_num_bins
        matrix(i,j) = round((matrix(i,j)/maximum)*255);
    end
end


   
hough_img = uint8(matrix);

