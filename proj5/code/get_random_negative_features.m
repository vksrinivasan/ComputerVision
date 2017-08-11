% Starter code prepared by James Hays for CS 4476, Georgia Tech
% This function should return negative training examples (non-faces) from
% any images in 'non_face_scn_path'. Images should be converted to
% grayscale because the positive training data is only available in
% grayscale. For best performance, you should sample random negative
% examples at multiple scales.

function features_neg = get_random_negative_features(non_face_scn_path, feature_params, num_samples)
% 'non_face_scn_path' is a string. This directory contains many images
%   which have no faces in them.
% 'feature_params' is a struct, with fields
%   feature_params.template_size (default 36), the number of pixels
%      spanned by each train / test template and
%   feature_params.hog_cell_size (default 6), the number of pixels in each
%      HoG cell. template size should be evenly divisible by hog_cell_size.
%      Smaller HoG cell sizes tend to work better, but they make things
%      slower because the feature dimensionality increases and more
%      importantly the step size of the classifier decreases at test time.
% 'num_samples' is the number of random negatives to be mined, it's not
%   important for the function to find exactly 'num_samples' non-face
%   features, e.g. you might try to sample some number from each image, but
%   some images might be too small to find enough.

% 'features_neg' is N by D matrix where N is the number of non-faces and D
% is the template dimensionality, which would be
%   (feature_params.template_size / feature_params.hog_cell_size)^2 * 31
% if you're using the default vl_hog parameters

% Useful functions:
% vl_hog, HOG = VL_HOG(IM, CELLSIZE)
%  http://www.vlfeat.org/matlab/vl_hog.html  (API)
%  http://www.vlfeat.org/overview/hog.html   (Tutorial)
% rgb2gray

image_files = dir( fullfile( non_face_scn_path, '*.jpg' ));
image_files = struct2cell(image_files);
num_images = length(image_files);
% features_neg = [];
features_neg_1 = [];
features_neg_2 = [];
features_neg_3 = [];
features_neg_4 = [];
features_neg_5 = [];

% note, we only have 274 images and we want num_samples (default 10,000)
% instances of non-faces. So we will need to get multiple features from one
% image (although maybe not uniformly since size may vary across images) -
% I am just going to randomly choose an image, a scale, and a 36x36 patch.
% It is possible that I choose the same patch twice, but unlikely. It is
% also possible that I don't sample from an image, but unlikely. 

curr_num_samples = 1;

while(curr_num_samples<=num_samples)
    
    fprintf('Curr num sample is: %d\n',curr_num_samples);
    
    % first choose random image to sample from
    img_indx = randi([1 num_images],1);
    temp_img = im2single(imread(image_files{1,img_indx}));
    
    % guarantee that this is grayscale
    temp_img = rgb2gray(temp_img);
    
    % then choose a scale to sample at
    scale = randi([1 3],1);
    temp_img_adj = rescaleImg(temp_img,scale);
    
    % check if the image is even big enough to sample from 
    if(size(temp_img_adj,1)<feature_params.template_size || ...
            size(temp_img_adj,2)<feature_params.template_size)
        continue;
    else
        % pick random place to sample from
        last_poss_row_idx = size(temp_img_adj,1)-feature_params.template_size+1;
        last_poss_col_idx = size(temp_img_adj,2)-feature_params.template_size+1;
        
        rand_row_start = randi([1 last_poss_row_idx],1);
        rand_col_start = randi([1 last_poss_col_idx],1);
        
        crop = temp_img_adj(rand_row_start:rand_row_start+36-1,...
            rand_col_start:rand_col_start+36-1);
        
        % calculate hog from this crop
        hog = vl_hog(crop, feature_params.hog_cell_size, 'verbose');
%         hog = my_hog(crop,feature_params.hog_cell_size);
%         features_neg = [features_neg;hog(:)'];
        if(curr_num_samples<2001)
            features_neg_1 = [features_neg_1;hog(:)'];
        elseif(curr_num_samples>=2001 && curr_num_samples<4001)
            features_neg_2 = [features_neg_2;hog(:)'];
        elseif(curr_num_samples>=4001 && curr_num_samples<6001)
            features_neg_3 = [features_neg_3;hog(:)'];
        elseif(curr_num_samples>=6001 && curr_num_samples<8001)
            features_neg_4 = [features_neg_4;hog(:)'];
        elseif(curr_num_samples>=8001 && curr_num_samples<10001)
            features_neg_5 = [features_neg_5;hog(:)'];
        end
            
        % increment curr num samples 
        curr_num_samples = curr_num_samples + 1;
    end

end

features_neg = [features_neg_1;features_neg_2;features_neg_3;features_neg_4;...
    features_neg_5];
