function runHw4(varargin)
% runHw4 is the "main" interface that lists a set of 
% functions corresponding to the problems that need to be solved.
%
% Note that this file also serves as the specifications for the functions 
% you are asked to implement. In some cases, your submissions will be autograded. 
% Thus, it is critical that you adhere to all the specified function signatures.
%
% Before your submssion, make sure you can run runHw4('all') 
% without any error.
%
% Usage:
% runHw4                       : list all the registered functions
% runHw4('function_name')      : execute a specific test
% runHw4('all')                : execute all the registered functions

% Settings to make sure images are displayed without borders
orig_imsetting = iptgetpref('ImshowBorder');
iptsetpref('ImshowBorder', 'tight');
temp1 = onCleanup(@()iptsetpref('ImshowBorder', orig_imsetting));

fun_handles = {@honesty,...
    @challenge1a, @challenge1b, @challenge1c,...
    @challenge1d, @challenge1e, @challenge1f,...
    @demoMATLABTricks};

% Call test harness
runTests(varargin, fun_handles);

%--------------------------------------------------------------------------
% Academic Honesty Policy
%--------------------------------------------------------------------------
%%
function honesty()
% Type your full name and uni (both in string) to state your agreement 
% to the Code of Academic Integrity.
signAcademicHonestyPolicy('Varun Sreenivasan', 'vsreenivasan');

%--------------------------------------------------------------------------
% Tests for Challenge 1: Panoramic Photo App
%--------------------------------------------------------------------------

%%
function challenge1a()
% Test homography

orig_img = imread('portrait.png'); 
warped_img = imread('portrait_transformed.png');

% Choose 4 corresponding points (use ginput)

% fh1 = figure();
% imshow(orig_img);
% [xs1,ys1,but] = ginput(1);
% xs1 = round(xs1);
% ys1 = round(ys1);
% delete(fh1);
% 
% fh1 = figure();
% imshow(warped_img);
% [xd1, yd1, but] = ginput(1);
% xd1 = round(xd1);
% yd1 = round(yd1);
% delete(fh1);
% 
% fh1 = figure();
% imshow(orig_img);
% [xs2,ys2,but] = ginput(1);
% xs2 = round(xs2);
% ys2 = round(ys2);
% delete(fh1);
% 
% fh1 = figure();
% imshow(warped_img);
% [xd2,yd2,but] = ginput(1);
% xd2 = round(xd2);
% yd2 = round(yd2);
% delete(fh1);
% 
% fh1 = figure();
% imshow(orig_img);
% [xs3,ys3,but] = ginput(1);
% xs3 = round(xs3);
% ys3 = round(ys3);
% delete(fh1);
% 
% fh1 = figure();
% imshow(warped_img);
% [xd3,yd3,but] = ginput(1);
% xd3 = round(xd3);
% yd3 = round(yd3);
% delete(fh1);
% 
% fh1 = figure();
% imshow(orig_img);
% [xs4,ys4,but] = ginput(1);
% xs4 = round(xs4);
% ys4 = round(ys4);
% delete(fh1);
% 
% fh1 = figure();
% imshow(warped_img);
% [xd4,yd4,but] = ginput(1);
% xd4 = round(xd4);
% yd4 = round(yd4);
% delete(fh1);


xs1 = 160;
ys1 = 100;

xs2 = 160;
ys2 = 698;

xs3 = 640;
ys3 = 698;

xs4 = 640;
ys4 = 100;

xd1 = 138;
yd1 = 140;

xd2 = 114;
yd2 = 593;

xd3 = 663;
yd3 = 774;

xd4 = 621;
yd4 = 28;


src_pts_nx2  = [xs1 ys1; xs2 ys2; xs3 ys3; xs4 ys4];
dest_pts_nx2 = [xd1 yd1; xd2 yd2; xd3 yd3; xd4 yd4];

H_3x3 = computeHomography(src_pts_nx2, dest_pts_nx2);
% src_pts_nx2 and dest_pts_nx2 are the coordinates of corresponding points 
% of the two images, respectively. src_pts_nx2 and dest_pts_nx2 
% are nx2 matrices, where the first column contains
% the x coodinates and the second column contains the y coordinates.
%
% H, a 3x3 matrix, is the estimated homography that 
% transforms src_pts_nx2 to dest_pts_nx2. 


% Choose another set of points on orig_img for testing.
% test_pts_nx2 should be an nx2 matrix, where n is the number of points, the
% first column contains the x coordinates and the second column contains
% the y coordinates.

% fh1 = figure();
% imshow(orig_img)
% [xt1,yt1,but] = ginput(1);
% xt1 = round(xt1);
% yt1 = round(yt1);
% 
% disp(xt1 + " " + yt1);
% 
% delete(fh1);
% 
% fh1 = figure();
% imshow(orig_img)
% [xt2,yt2,but] = ginput(1);
% xt2 = round(xt2);
% yt2 = round(yt2);
% 
% disp(xt2 + " " + yt2);
% 
% delete(fh1);
% 
% fh1 = figure();
% imshow(orig_img)
% [xt3,yt3,but] = ginput(1);
% xt3 = round(xt3);
% yt3 = round(yt3);
% 
% disp(xt3 + " " + yt3);
% delete(fh1);
% 
% fh1 = figure();
% imshow(orig_img)
% [xt4,yt4,but] = ginput(1);
% xt4 = round(xt4);
% yt4 = round(yt4);
% 
% disp(xt4 + " " + yt4);
% 
% delete(fh1);

xt1 = 362;
yt1 = 235;

xt2 = 504;
yt2 = 342;

xt3 = 406;
yt3 = 493;

xt4 = 356;
yt4 = 683;

test_pts_nx2 = [xt1 yt1; xt2 yt2; xt3 yt3; xt4 yt4];

% Apply homography

dest_pts_nx2 = applyHomography(H_3x3, test_pts_nx2);
%disp(test_pts_nx2);
%disp(dest_pts_nx2);
% test_pts_nx2 and dest_pts_nx2 are the coordinates of corresponding points 
% of the two images, and H is the homography.

% Verify homography 
result_img = showCorrespondence(orig_img, warped_img, test_pts_nx2, dest_pts_nx2);
imshow(result_img);
imwrite(result_img, 'homography_result.png');

%%
function challenge1b()
% Test wrapping 

bg_img = im2double(imread('Osaka.png')); %imshow(bg_img);
portrait_img = im2double(imread('portrait_small.png')); %imshow(portrait_img);

xp1 = 1;
yp1 = 1;
 
xp2 = 1;
yp2 = 400;

xp3 = 327;
yp3 = 400;

xp4 = 327;
yp4 = 1;


xb1 = 99.75;
yb1 = 20;

xb2 = 83.5;
yb2 = 437.5;

xb3 = 283.75;
yb3 = 424;

xb4 = 275;
yb4 = 72;
% Estimate homography
portrait_pts = [xp1 yp1; xp2 yp2; xp3 yp3; xp4 yp4];
bg_pts = [xb1 yb1; xb2 yb2; xb3 yb3; xb4 yb4];

H_3x3 = computeHomography(portrait_pts, bg_pts);

dest_canvas_width_height = [size(bg_img, 2), size(bg_img, 1)];


% Warp the portrait image
[mask, dest_img] = backwardWarpImg(portrait_img, inv(H_3x3), dest_canvas_width_height);
% mask should be of the type logical
mask = ~mask;
% Superimpose the image
result = bg_img .* cat(3, mask, mask, mask) + dest_img;
figure, imshow(result);
imwrite(result, 'Van_Gogh_in_Osaka.png');

%%  
function challenge1c()
% Test RANSAC -- outlier rejection

imgs = imread('mountain_left.png'); imgd = imread('mountain_center.png');
[xs, xd] = genSIFTMatches(imgs, imgd);
% xs and xd are the centers of matched frames
% xs and xd are nx2 matrices, where the first column contains the x
% coordinates and the second column contains the y coordinates

before_img = showCorrespondence(imgs, imgd, xs, xd);
%figure, imshow(before_img);
imwrite(before_img, 'before_ransac.png');

% Use RANSAC to reject outliers
ransac_n = 30; % Max number of iteractions
ransac_eps = 2; %Acceptable alignment error 

[inliers_id, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);

after_img = showCorrespondence(imgs, imgd, xs(inliers_id, :), xd(inliers_id, :));
figure, imshow(after_img);
imwrite(after_img, 'after_ransac.png');

%%
function challenge1d()
% Test image blending

[fish, fish_map, fish_mask] = imread('escher_fish.png');
[horse, horse_map, horse_mask] = imread('escher_horsemen.png');
blended_result = blendImagePair(fish, fish_mask, horse, horse_mask,...
    'blend');

figure, imshow(blended_result);
imwrite(blended_result, 'blended_result.png');

overlay_result = blendImagePair(fish, fish_mask, horse, horse_mask, 'overlay');
figure, imshow(overlay_result);
imwrite(overlay_result, 'overlay_result.png');

%%
function challenge1e()
% Test image stitching

% stitch three images
imgc = im2single(imread('mountain_center.png'));
imgl = im2single(imread('mountain_left.png'));
imgr = im2single(imread('mountain_right.png'));

% You are free to change the order of input arguments
stitched_img = stitchImg(imgl, imgc, imgr);
figure, imshow(stitched_img);
imwrite(stitched_img, 'mountain_panorama.png');

%%
function challenge1f()
% Your own panorama

imgl = im2single(imread('img_1_f.png'));
imgr = im2single(imread('img_2_f.png'));

stitched_img = stitchImg(imgl,imgr);
figure, imshow(stitched_img);

imwrite(stitched_img, 'stitched_custom.png');
