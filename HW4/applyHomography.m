function dest_pts_nx2 = applyHomography(H_3x3, src_pts_nx2)

[m,n] = size(src_pts_nx2);

newCol = ones(m,1);

updated = [src_pts_nx2 newCol];

dest_pts_nx2 = zeros(m,2);

for i = 1:m
    
    C = H_3x3 * updated(i,:).';
    dest_pts_nx2(i,1) = round(C(1)/C(3));
    dest_pts_nx2(i,2) = round(C(2)/C(3));

end



