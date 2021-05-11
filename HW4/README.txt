Name: Varun Sreenivasan
NetID: vsreenivasan


Files Submitted

runHw4.m, runTests.m, signAcademicHonestyPolicy.m, genSIFTMatches.m, sift_lib


Challenge: a) computeHomography.m, applyHomography.m, showCorrespondence.m, portrait.png, portrait_transformed.png, 
              homography_results.png

           b) backwardWarpImg.m, Osaka.png, portrait_small.png, Van_Gogh_in_Osaka.png

           c) runRANSAC.m, mountain_left.png, mountain_center.png, before_ransac.png, after_ransac.png

           d) bleanImagePair.m, escher_fish.png, escher_horsemen.png, blended_result.png, overlay_result.png

           e) stitchImg.m, stitching_helper.m, stitching_helper1.m, stitching_helper2.m, stitching_helper3.m,
              stitching_helper4.m, stitching_helper5.m, mountain_center.png, mountain_left.png, mountain_right.png,
              mountain_panorama.png

           f) img_1_f.png, img_2_f.png, img_3_f.png, stitched_custom.png
            

Design Implementation

            
           a) Computing Homography: The first part of the algorithm is to construct the matrix using the src_pts and 
              dest_pts. This matrix is then used to determine the eigenvectors and eigenvalues. Finally, the eigenvector
              corresponding to the lowest eigenvalue is selected and used to construct the homography matrix. 

              Applying Homography: The destination points are determined by performing matrix multiplication with
              the homography matrix and source points.

              Showing Correspondence: I used insertShape to draw the line.

           b) Used the Backward Warping algorithm to do this. 

           c) ransac_n: 30
              ransac_eps: 2

              The first part of the algorithm is to generate SIFT matches. ransac_n iterations are performed and in each iteration
              4 indices corresponding to a pair of source image points and destination image points are randomly chosen. The 
              homography is then computed using these points. After doing this, we then determine the number of inliers for the
              corresponding homography. Euclidean distance is utilized to measure the error and if the error is within ransac_eps
              an index referring to a pair of source points and destination points is considered an inlier. The homography
              that provides the maximum number of inliers is returned along with the inlier ids. 

           d) I first convert the masks to binary masks. 

              Overlay - Image 2 points replace Image 1 points wherever the mask corresponding to image 2 is 1.

              Blend - Two new masks are created. In the two new masks, the points where both the original mask for the first 
                      image and second image have value 1 are set to 0. bwdist is applied on these two new masks to get the distance
                      matrix for the two images. In the blended image, the weight for a point (i,j) associated with the  
                      the first image is 1/D1(i,j) and 1/D2(i,j) for the second image. These two weight are normalized to
                      ensure they sum to 1. When generating the blended images, the regions where both the original masks of
                      the first image and second image have value 1, the intensity is computed using w1 * img1(i,j) + w2 * img2(i,j)
                      Note: w1 + w2 = 1. In other regions, we don't need to apply this since only one or none of the masks have value
                      of 1.
               
           e) I have done stitching along the row.

              Note: When stitching two images, only one image is changed to create the panorama. Change refers to the 
              application of homography. 

              In my program, there are two cases when stitiching two images: either the left image is changed or the right image 
              is changed. 
              
              The case where there is an even number of images to stitch is handled slightly differently from the case where there is
              an odd number of images to stitch. In both cases, I start stitching images from the sides. In the case of even
              number of images, at the end there is a left stitched image and a right stitched image. So, I change the left 
              stitched image and create the panorama. In the case of odd number of images, at the end, there is a left stitched
              image, a center image, and a right stitched image. I first change the right stitched image and stitch it with
              the center image. Then I change the left stitched image and stitch it with the stitched image of the center and right 
              stitched image. 
       
              My algorithm to stitch two images is the following:

              1) Run Ransac to determine homography.
              2) Select whether the left or right image will be changed. Perform backward warping to the corresponding image.
              3) Run Ransac to determine the region of overlap along the x axis by computing the distance of line connecting
                 matching points along x-axis.
              4) Make sure both images have the same height.
              5) Run Ransac to determine the translation to perform along y axis to align images.
              6) Apply translation to the image that was made larger to have the same height. 
              7) Perform blending on the two images to generate stitched image.  

              I have made use of 6 helper functions: stitching_helper.m, stitching_helper1.m, stitching_helper2.m,
              stitching_helper3.m, stitching_helper4.m, stitching_helper5.m



           f) I have used two images of my room. Both are shot on my cell phone. 

              Captured images: img_1_f.png, img_2_f.png
              Stitched image: stitched_custom.png

                
