% Starter code prepared by James Hays for CS 4476, Georgia Tech
% This function returns detections on all of the images in a given path.
% You will want to use non-maximum suppression on your detections or your
% performance will be poor (the evaluation counts a duplicate detection as
% wrong). The non-maximum suppression is done on a per-image basis. The
% starter code includes a call to a provided non-max suppression function.
function [bboxes, confidences, image_ids] = .... 
    run_detector(test_scn_path, w, b, feature_params,weights_neural_net,kdtree,all_data,dt_labels,...
        linear_svm,neural_net,nearest_neighbor)
% 'test_scn_path' is a string. This directory contains images which may or
%    may not have faces in them. This function should work for the MIT+CMU
%    test set but also for any other images (e.g. class photos)
% 'w' and 'b' are the linear classifier parameters
% 'feature_params' is a struct, with fields
%   feature_params.template_size (default 36), the number of pixels
%      spanned by each train / test template and
%   feature_params.hog_cell_size (default 6), the number of pixels in each
%      HoG cell. template size should be evenly divisible by hog_cell_size.
%      Smaller HoG cell sizes tend to work better, but they make things
%      slower because the feature dimensionality increases and more
%      importantly the step size of the classifier decreases at test time.

% 'bboxes' is Nx4. N is the number of detections. bboxes(i,:) is
%   [x_min, y_min, x_max, y_max] for detection i. 
%   Remember 'y' is dimension 1 in Matlab!
% 'confidences' is Nx1. confidences(i) is the real valued confidence of
%   detection i.
% 'image_ids' is an Nx1 cell array. image_ids{i} is the image file name
%   for detection i. (not the full path, just 'albert.jpg')

% The placeholder version of this code will return random bounding boxes in
% each test image. It will even do non-maximum suppression on the random
% bounding boxes to give you an example of how to call the function.

% Your actual code should convert each test image to HoG feature space with
% a _single_ call to vl_hog for each scale. Then step over the HoG cells,
% taking groups of cells that are the same size as your learned template,
% and classifying them. If the classification is above some confidence,
% keep the detection and then pass all the detections for an image to
% non-maximum suppression. For your initial debugging, you can operate only
% at a single scale and you can skip calling non-maximum suppression. Err
% on the side of having a low confidence threshold (even less than zero) to
% achieve high enough recall.

test_scenes = dir( fullfile( test_scn_path, '*.jpg' ));

%initialize these as empty and incrementally expand them.
bboxes = zeros(0,4);
confidences = zeros(0,1);
image_ids = cell(0,1);
threshold = 0; % Use 0 for best result, used 0.7 for class photo

for ii = 1:length(test_scenes)
      
    fprintf('Detecting faces in %s\n', test_scenes(ii).name)
    img = imread( fullfile( test_scn_path, test_scenes(ii).name ));
    img = single(img)/255;
    if(size(img,3) > 1)
        img = rgb2gray(img);
    end
    
    % First make room for this images confidences, bboxes, and image id.
    
    cur_confidences = [];
    cur_bboxes = [];
    cur_image_ids = {};
    
    % define all possible scales - go from 1 to the smallest possible scale
    % (scale at which each dimension is at least 36 pixels)
    
    scales = [1;0.9;0.8;0.7;0.6;0.5;0.4;0.3;0.2;0.1];
%     scales = 1.0;
    
    for jj = 1:size(scales,1)
        jj
        temp_img = imresize(img,scales(jj,1));
        
        % if the size of either dimension is smaller than 36 pixels, then
        % just continue until you're out of the loop
        if(size(temp_img,1)<feature_params.template_size || ...
                size(temp_img,2)<feature_params.template_size)
            continue;
        end

        % get the hog for this scale image
        hog = vl_hog(temp_img, feature_params.hog_cell_size);
%         hog = my_hog(temp_img,feature_params.hog_cell_size);
        
        [temp_confidences,temp_bboxes,temp_image_ids] = findMatchesInLevel(...
            hog,scales(jj,1),feature_params,threshold,w,b,test_scenes,ii,...
            weights_neural_net,kdtree,all_data,dt_labels,linear_svm,...
            neural_net,nearest_neighbor);
        
        cur_confidences = [cur_confidences;temp_confidences];
        cur_bboxes = [cur_bboxes;temp_bboxes];
        cur_image_ids = [cur_image_ids;temp_image_ids];
        
    end


    if(~isempty(cur_confidences))

        %non_max_supr_bbox can actually get somewhat slow with thousands of
        %initial detections. You could pre-filter the detections by confidence,
        %e.g. a detection with confidence -1.1 will probably never be
        %meaningful. You probably _don't_ want to threshold at 0.0, though. You
        %can get higher recall with a lower threshold. You don't need to modify
        %anything in non_max_supr_bbox, but you can.
        [is_maximum] = non_max_supr_bbox(cur_bboxes, cur_confidences, size(img));

        cur_confidences = cur_confidences(is_maximum,:);
        cur_bboxes      = cur_bboxes(     is_maximum,:);
        cur_image_ids   = cur_image_ids(  is_maximum,:);

        bboxes      = [bboxes;      cur_bboxes];
        confidences = [confidences; cur_confidences];
        image_ids   = [image_ids;   cur_image_ids];

    end
      
end