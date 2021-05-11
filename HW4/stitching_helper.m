function out_img = stitching_helper(curr_image,append_image, option)


[m_curr, n_curr, c_curr] = size(curr_image);
[m_append, n_append, c_append] = size(append_image);
[H_3x3] = stitching_helper1(curr_image,append_image);


first_image = 0;
second_image = 0;
changed_image = 0;
common_x = 0;

if(option == 1)
    changed_image = stitching_helper2(curr_image,H_3x3);
    first_image = changed_image;
    second_image = append_image;
    [m_changed, n_changed, c_changed] = size(changed_image);
    common_x = stitching_helper4(first_image, second_image);
     
    if(m_changed > m_append)
        
        second_image = zeros(m_changed, n_append, 3);
     
        for i = 1:m_append
           for j = 1:n_append
              second_image(i,j,1) = append_image(i,j,1);
              second_image(i,j,2) = append_image(i,j,2);
              second_image(i,j,3) = append_image(i,j,3);
           end
        end
        
         t_val = stitching_helper3(first_image, second_image);
         
         translation = -t_val;
         
         opt1 = min(translation, m_changed-m_append);
        
         it_end = min(0, opt1 - translation); 
         
         it_start = 0;
         
         if(translation < 0)
             it_start = -translation;
         end
         
         second_image = zeros(m_changed, n_append,3);
         
    
         for i = 1+it_start:m_append+it_end
             for j = 1:n_append
                second_image(i+translation,j,1) = append_image(i,j,1);
                second_image(i+translation,j,2) = append_image(i,j,2);
                second_image(i+translation,j,3) = append_image(i,j,3);
             end
         end
        
         
         
    elseif(m_changed < m_append)
  
         first_image = zeros(m_append, n_changed,3);
            
         for i = 1:m_changed
             for j = 1:n_changed
                first_image(i,j,1) = changed_image(i,j,1);
                first_image(i,j,2) = changed_image(i,j,2);
                first_image(i,j,3) = changed_image(i,j,3);
             end
         end
    
         t_val = stitching_helper3(first_image, second_image);
      
         translation = t_val;
        
         
         
         opt1 = min(translation, m_append-m_changed);
    
         it_end = min(0, opt1 - translation); 
         
         it_start = 0;
         
         if(translation < 0)
             it_start = -translation;
         end         
         
         first_image = zeros(m_append, n_changed,3);
             
         for i = 1+it_start:m_changed + it_end
              for j = 1:n_changed
                   first_image(i+translation,j,1) = changed_image(i,j,1);
                   first_image(i+translation,j,2) = changed_image(i,j,2);
                   first_image(i+translation,j,3) = changed_image(i,j,3);
              end
         end
         
      
    end
    
    
else
    changed_image = stitching_helper2(append_image,inv(H_3x3));
    first_image = curr_image;
    second_image = changed_image;
    [m_changed, n_changed, c_changed] = size(changed_image);
    common_x = stitching_helper4(first_image, second_image);

    if(m_changed > m_curr)
        
         first_image = zeros(m_changed, n_curr, 3);
       
         for i = 1:m_curr
           for j = 1:n_curr
              first_image(i,j,1) = curr_image(i,j,1);
              first_image(i,j,2) = curr_image(i,j,2);
              first_image(i,j,3) = curr_image(i,j,3);
           end
         end
         
         t_val = stitching_helper3(first_image, second_image);  
  
       
         translation = t_val;
      
         opt1 = min(translation, m_changed-m_curr);
    
         it_end = min(0, opt1 - translation); 
         
         it_start = 0;
         
         if(translation < 0)
             it_start = -translation;
         end
         
         first_image = zeros(m_changed, n_curr,3);
         
         for i = 1+it_start:m_curr + it_end
             for j = 1:n_curr
                 first_image(i+translation,j,1) = curr_image(i,j,1);
                 first_image(i+translation,j,2) = curr_image(i,j,2);
                 first_image(i+translation,j,3) = curr_image(i,j,3);
             end
         end
        
         
    elseif(m_changed < m_curr)
        
        second_image = zeros(m_curr, n_changed, 3);
        
        for i = 1:m_changed
            for j = 1:n_changed
                 second_image(i,j,1) = changed_image(i,j,1);
                 second_image(i,j,2) = changed_image(i,j,2);
                 second_image(i,j,3) = changed_image(i,j,3);
            end
        end
        
        t_val = stitching_helper3(first_image, second_image);
        translation = -t_val;
      
        opt1 = min(translation, m_curr-m_changed);
     
        it_end = min(0, opt1 - translation); 
       
         
        it_start = 0;
         
        if(translation < 0)
            it_start = -translation;
        end
        
        
        
        second_image = zeros(m_curr, n_changed, 3);
        for i = 1+it_start:m_changed+it_end
            for j = 1:n_changed
                 second_image(i+translation,j,1) = changed_image(i,j,1);
                 second_image(i+translation,j,2) = changed_image(i,j,2);
                 second_image(i+translation,j,3) = changed_image(i,j,3);
            end
        end
        
    end
    
end    

[m_first, n_first, c_first] = size(first_image);
[m_second, n_second, c_second] = size(second_image);

bb_width = n_first + n_second - common_x;

new_img1 = zeros(m_first,bb_width,3);
new_img2 = zeros(m_second,bb_width,3);


for i = 1:m_first
    for j = 1:n_first
        new_img1(i,j,1) = first_image(i,j,1);
        new_img1(i,j,2) = first_image(i,j,2);
        new_img1(i,j,3) = first_image(i,j,3);
    end
end

for i = 1:m_second
    for j = bb_width-n_second+1:bb_width
        new_img2(i,j,1) = second_image(i,j-bb_width+n_second,1);
        new_img2(i,j,2) = second_image(i,j-bb_width+n_second,2);
        new_img2(i,j,3) = second_image(i,j-bb_width+n_second,3);
    end
end


mask1 = zeros(size(new_img1,1), bb_width);
mask2 = zeros(size(new_img2,1), bb_width);

mask1 = stitching_helper5(new_img1, mask1);
mask2 = stitching_helper5(new_img2, mask2);

out_img = blendImagePair(new_img1, mask1, new_img2, mask2, 'blend');

end

