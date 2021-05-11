Name: Varun Sreenivasan
NetID: vsreenivasan

Files Submitted: stack folder, sort_files.m, loadFocalStack.m, generateIndexMap.m, refocusApp.m, runHw6.m, runTests.m,
signAcademicHonestyPolicy.m, index_map.png, README.txt


Design Implementation

Part a)

This program requires the files to be accessed in the following order: frame1, frame2, ..., frame10, frame11, frame20, .. frame25.
However, MATLAB's dir order is frame1, frame10, frame11, frame2, frame20, frame21, .., frame3, frame4, frame5, ..., frame9.

To get the natural sorting order I have used a function called sort_files defined in the file sort_files.m. 
To do this, I'm using code directly from:
https://www.mathworks.com/matlabcentral/fileexchange/10959-sort_nat-natural-order-sort 

Once the sorted order is obtained, the stacks are generated using the cat operation.

Part b)

First, the modifield Laplacian is obtained. I applied two sobel filters (one corresponding to the x component 
and the other one corresponding to the y component) twice. I then summed the absolute values of the two matrices to 
obtain the modified laplacian. Then I computed the focus measure (sum of the square of modified laplacian) using a 
window of size 3. I then applied the gaussian filter to smooth and mitigate noise. The window dimension and sigma were 
decided based on trial and error.

Note: I have prioritised getting rid of noisy points to ensure that the index map is smooth. 

Part c)

The initial image is selected randomly. The following frame depends on the point the user selects to focus on. This repeats until 
the selects a point outside the image frame. The program terminates once the user does that. 