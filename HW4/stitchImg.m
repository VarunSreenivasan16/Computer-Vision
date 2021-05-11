function stitched_img = stitchImg(varargin)

var_size = size(varargin,2);

if(var_size == 1)
    stitched_img = varargin{1};
    
else
    
    if(mod(var_size,2) == 0)
        
        left_image = varargin{1};
        right_image = varargin{var_size};
        
        center = (var_size/2);
        
        for i = 2:center
            left_image = stitching_helper(left_image, varargin{i}, 1);
        end
        
        for i = var_size - 1:-1:center+1
            right_image = stitching_helper(varargin{i}, right_image, 2);
        end
        
        stitched_img = stitching_helper(left_image, right_image, 1);
        
    else
        
        center = ceil(var_size/2);
        center_image = varargin{center};
        
        left_image = varargin{1};
        right_image = varargin{var_size};
        
        for i = var_size-1:-1:center+1
            right_image = stitching_helper(varargin{i},right_image,2);
        end
        
        for i = 2:center-1
            left_image = stitching_helper(left_image, varargin{i}, 1);
        end
        
        out_img1 = stitching_helper(center_image, right_image,2);
        out_img2 = stitching_helper(left_image, out_img1,1);   
        
        stitched_img = out_img2;
    end
    
end

