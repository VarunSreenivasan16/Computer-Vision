function out_img = blendImagePair(wrapped_imgs, masks, wrapped_imgd, maskd, mode)

[l,k] = size(maskd);
[m,n,channel] = size(wrapped_imgs);
out_img = zeros(m,n,3);
    

for i = 1:l
    for j = 1:k
        if(masks(i,j) > 0)
            masks(i,j) = 1;
        end
        if(maskd(i,j) > 0)
            maskd(i,j) = 1;
        end
    end
end


if(strcmp(mode, 'overlay') == 1)
    out_img = wrapped_imgs;
    [m,n,channel] = size(out_img);
    
    for i = 1:m
        for j = 1:n
            if(maskd(i,j) == 1)
                out_img(i,j,1) = wrapped_imgd(i,j,1);
                out_img(i,j,2) = wrapped_imgd(i,j,2);
                out_img(i,j,3) = wrapped_imgd(i,j,3);
            end
        end
    end
elseif(strcmp(mode, 'blend') == 1)
    
    out_img = wrapped_imgs;
    mask_left = masks;
    mask_right = maskd;
    
    [comp_1, comp_2] = size(masks);
    
    for i = 1:comp_1
        for j = 1:comp_2
            if(masks(i,j) == 1 && maskd(i,j) == 1)  
              mask_left(i,j) = 0;
              mask_right(i,j) = 0;
            end
        end
    end
   
    D1 = bwdist(mask_left);
    D2 = bwdist(mask_right);
  
    
    for i = 1:comp_1
        for j = 1:comp_2
            
            if(masks(i,j) == 0 && maskd(i,j) == 1)
                out_img(i,j,1) = wrapped_imgd(i,j,1);
                out_img(i,j,2) = wrapped_imgd(i,j,2);
                out_img(i,j,3) = wrapped_imgd(i,j,3);
                
            elseif(masks(i,j) == 1 && maskd(i,j) == 1)
                w1 = 1/double(D1(i,j));
                w2 = 1/double(D2(i,j));
                 
                alpha1 = w1/(w1+w2);
                alpha2 = 1-alpha1;
                
                out_img(i,j,1) = alpha1*wrapped_imgs(i,j,1) + alpha2*wrapped_imgd(i,j,1);
                out_img(i,j,2) = alpha1*wrapped_imgs(i,j,2) + alpha2*wrapped_imgd(i,j,2);
                out_img(i,j,3) = alpha1*wrapped_imgs(i,j,3) + alpha2*wrapped_imgd(i,j,3);
      
            end
        end
    end
            
end   

                
    

       
   
