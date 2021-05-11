function H_3x3 = computeHomography(src_pts_nx2, dest_pts_nx2)

[m,n] = size(src_pts_nx2);

matrix = zeros(m * 2, 9);

for i = 1:m
    
    first_index = i*2 - 1;
    second_index = i*2;
    matrix(first_index, 1) = src_pts_nx2(i,1);
    matrix(first_index, 2) = src_pts_nx2(i,2);
    matrix(first_index, 3) = 1;
    matrix(first_index, 4) = 0;
    matrix(first_index, 5) = 0;
    matrix(first_index, 6) = 0;
    matrix(first_index, 7) = -(src_pts_nx2(i,1) * dest_pts_nx2(i,1));
    matrix(first_index, 8) = -(src_pts_nx2(i,2) * dest_pts_nx2(i,1));
    matrix(first_index, 9) = -dest_pts_nx2(i,1);
    
    matrix(second_index,1) = 0;
    matrix(second_index,2) = 0;
    matrix(second_index,3) = 0;
    matrix(second_index,4) = src_pts_nx2(i,1);
    matrix(second_index,5) = src_pts_nx2(i,2);
    matrix(second_index,6) = 1;
    matrix(second_index,7) = -(src_pts_nx2(i,1) * dest_pts_nx2(i,2));
    matrix(second_index,8) = -(src_pts_nx2(i,2) * dest_pts_nx2(i,2));
    matrix(second_index,9) = -dest_pts_nx2(i,2);
    
end


[V,D] = eig(matrix'*matrix);

[l,k] = size(D);

min_val = intmax;
min_index = -1;

for i = 1:l
    if(D(i,i) < min_val)
        min_val = D(i,i);
        min_index = i;
    end
end


eigen_vector = V(:,min_index);

H_3x3 = zeros(3,3);

H_3x3(1,1) = eigen_vector(1);
H_3x3(1,2) = eigen_vector(2);
H_3x3(1,3) = eigen_vector(3);
H_3x3(2,1) = eigen_vector(4);
H_3x3(2,2) = eigen_vector(5);
H_3x3(2,3) = eigen_vector(6);
H_3x3(3,1) = eigen_vector(7);
H_3x3(3,2) = eigen_vector(8);
H_3x3(3,3) = eigen_vector(9);

