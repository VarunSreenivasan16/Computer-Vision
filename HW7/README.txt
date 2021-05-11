Name: Varun Sreenivasan
Netid: vsreenivasan

Files Submitted

Program files

compute_bins.m (file that I have added), computeFlow.m, drawBox.m, runHw7.m, runTests.m, signAcademicHonestyPolicy.m,
trackingTester.m

Input files

simple1.png, simple2.png, flow1.png, flow2.png, flow3.png, flow4.png, flow5.png, flow6.png

Output files

simpleresult.png, result1_2.png, result2_3.png, result3_4.png, result4_5.png, result5_6.png, 
walking_person_result, rolling_ball_result, and basketball_result folders containing output videos

README


Design Implementation

Challenge 1a and Debug 1a)

Optical Flow Algorithm

The first image is divided into blocks based on the template window. I then iterate over each template block and find the
corresponding search window in the second image using the window size parameter. normxcorr2 is then used to find the peaks.
and the displacement is computed using these peaks. Noisy flows are also removed.


Challenge 2)

Object Tracking Algorithm

The index image is computed for the first frame. I computed a weighted histogram to prioritize points radially from the centre. 
The search window is utilized to find the object window in the subsequent frame that has maximum correlation with the object window
in the current frame. This process is repeated for all the frames.

Running time for 2a) - 1 min 30 s
                  b) - 35 s
                  c) - 1 min 30 s
