Name: Varun Sreenivasan
NetID: vsreenivasan

Files Submitted

runHw3.m, runTests.m, signAcademicHonestyPolicy.m, 

Walkthrough: hw3_walkthrough1.m, flower.png, hello.png, blur_flowers.png, hello_edges.png

Challenge: 1a) hough_1.png, hough_2.png, hough_3.png, edge_hough_1.png, edge_hough_2.png, edge_hough_3.png

           1b) generateHoughAccumulator.m, accumulator_hough_1.png, accumulator_hough_2.png, accumulator_hough_3.png

           1c) lineFinder.m, line_hough_1.png, line_hough_2.png, line_hough_3.png

           1d) lineSegmentFinder.m, croppedline_hough_1.png, croppedline_hough_2.png, croppedline_hough_3.png


Design Implementation

Walkthrough:  Threshold for Sobel edge detection: 0.11

              Threshold for Canny edge detection: 0.2

Challenge:

          1a) Threshold for hough_1: 0.063

              Threshold for hough_2: 0.1
              
              Threshold for hough_3: 0.1


          1b) rho_num_bins: 1601 (represent range from -800 to 800 with a granularity of 1)
              theta_num_bins: 181 ( represent range from 0 to 180 with a granularity of 1)
              Note: the image diagonal is <= 800 for all images
            
              I initialize a 1601 by 181 matrix to represent the hough image. 

              For each pixel in the edge image of value 255, I compute the corresponding rho value for each theta from 0 to 180 (granularity 1).
              For this rho-theta combination I increase the number of votes by 1.

              I then scale the values to lie between 0-255 using the min-max normalization. 

              Discussion of results
 
              accumulator_hough_1.png: The peaks are clearly visible in the image.

              accumulator_hough_2.png: Although the peaks at theta = 0 and theta = 180 are present, they may not be clearly visible in 
                                       the png image. 
              
              accumulator_hough_3.png: The peaks are cleary visible in the image.

       
              
          1c) hough_threshold for first image: 83

              hough_threshold for second image: 60
 
              hough_threshold for third image: 55

              The first part of the algorithm is to extract the rho-theta combinations that will be used to plot corresponding lines.

              Non-Max Suppression is utilized on the hough_image to extract the local maxima (rho window - 15, theta window - 10). The local maxima must exceed
              the hough threshold. The case of lines with theta = 0 and theta = 180 is also handled. 

              The rho-theta combination that yields the local maxima is used to plot the line. There are two cases:
              - theta = 90
              - other theta values


              Discussion of results

              line_hough_1 - Generates all the lines as required
              line_hough_2 - Generates all the lines as required
              line_hough_3 - Generates all the horizontal lines but not the vertical lines. The hough thresholds associated with ther vertical boundaries of the book
                             are quite small. Thus adding these lines leads to a lot of noise being added. So, I avoided adding the lines associated with the vertical boundaries.
          

          1d) Note: edge_img is added as function argument.
 
              hough_threshold for first image: 83
 
              hough_threshold for second image: 58

              hough_threshold for third image: 55

              Like LineFinder, the first part of the algorithm is again to extract the rho-theta combinations. 
          
              Non-Max Supression is again utilized on the hough_image to extract the local maxima (rho window - 15, theta window - 10). The local maxima must exceed
              the hough threshold. The case of lines with theta = 0 and theta = 180 is also handled. 
              
              The next step is to correctly segment the line associated with the rho-theta combination. There are three cases to perform the segmenting operation:
              -theta = 90
              -other theta values greater than 80 and less than 100
              -all other theta values
              
              The line associated with the rho-theta combination is plotted in the following manner in each of the three cases:
              
              Depending on the case, x_1, x_2, y_1, y_2 variables are initialized appropriately.
              
              Again depending on the case, iteration is done on either the height or width of the edge image. Since one of x, y are known the equation  
              xsin(theta) - ycos(theta) + rho = 0 is used to compute the unknown variable. A window like that in NMS is utilized to check if a pixel of value 255 
              exists in the corresponding edge map region. If a line has not been started then x_1 and y_1 are updated to start it. Otherwise the line is extended by 
              updating x_2, y_2 appropriately. In case a line has been started and there is no pixel in the window during the iteration, the process
              of extending the line is stopped and the line is plotted.
           
              x_1, x_2, y_1, y_2 are re-initialized. We then continue iterating on either x or y depending on the case to find the correct boundaries for the line (rho-theta 
              combination) that we are currently using.

              This process is repeated for all selected rho-theta combinations. 

              Discussion of results
              
              croppedline_hough_1 - Generates boundaries as expected
              croppedline_hough_2 - Generates boundaries as expected
              croppedline_hough_3 - As mentioned above, horizontal boundaries of the book are captured but not the vertical boundaries. Trying to capture these adds noise, which
                                    I avoid. 
                         
           
              
 
