Name: Varun Sreenivasan
NetID: vsreenivasan

Files Submitted

runHw2.m

Walkthrough: hw2_walkthrough1.m, binary_coins.png, noise_removal_coins.png, and morphological_operations_coins.png

Challenge: 1a) generateLabeledImage.m, rgb_labeled_two_objects.png, rgb_labeled_many_objects_1.png, 
                       and rgb_labeled_many_objects_2.png

           1b) compute2DProperties.m, obj_db, annotated_two_objects.png

           1c) recognizeObjects.m, testing_1c1 (Folder that contains testing1c1_many_objects_1.png, 
                      testing1c1_many_objects_2.png), testing_1c2 (Folder that contains testing1c2_two_objects.png,
                      testing1c2_two_objects.png)


Design Implementation

Walkthrough: Threshold to convert image into binary: 0.5
             K value for removing noises in the binary image: 15
             K value for removing the rices: 15


Challenge

       a) Used function im2bw to convert a gray-level image to a binary image using a threshold value.
          Used function bwlabel using 8-connected objects to segment the binary image into several connected regions.

       b) No additional properties added. 

       c) Only one parameter used: Roundness  Threshold: 0.03
          An object is recognized if the difference in roundness is less than 0.03.

          Note: My algorithm implements a nested for loop (2 for loops) to iterate through the original obj_db and
          the obj_db of the image that is being tested. If the difference between the roundness of two objects (one
          object from the original image, and one from the image that is being tested) then the object in the image
          used to test is recognized. 

          Results: The algorithm works perfectly when the original image is two_objects.png and the tests are done on
          many_objects_1.png and many_objects_2.png. The trapezoid and blade are recognized in both the tests. 

          The results are also correct when the original image is many_objects_1.png and the test is done on
          two_objects.png (the blade and trapezoid are recognized). 

          when the test is done on many_objects_2.png, the trapezoid and blade are correctly recognized. However
          the fork and knife are incorrectly recognized as a spoon since the difference in roundness falls within 
          the threshold.


