% Starter code prepared by James Hays for Computer Vision

%This function will train a linear SVM for every category (i.e. one vs all)
%and then use the learned linear classifiers to predict the category of
%every test image. Every test feature will be evaluated with all 15 SVMs
%and the most confident SVM will "win". Confidence, or distance from the
%margin, is W*X + B where '*' is the inner product or dot product and W and
%B are the learned hyperplane parameters.

function predicted_categories = svm_classify(train_image_feats, train_labels, test_image_feats,lambda)
    % image_feats is an N x d matrix, where d is the dimensionality of the
    %  feature representation.
    % train_labels is an N x 1 cell array, where each entry is a string
    %  indicating the ground truth category for each training image.
    % test_image_feats is an M x d matrix, where d is the dimensionality of the
    %  feature representation. You can assume M = N unless you've modified the
    %  starter code.
    % predicted_categories is an M x 1 cell array, where each entry is a string
    %  indicating the predicted category for each test image.

    %{
    Useful functions:
     matching_indices = strcmp(string, cell_array_of_strings)

      This can tell you which indices in train_labels match a particular
      category. This is useful for creating the binary labels for each SVM
      training task.

    [W B] = vl_svmtrain(features, labels, LAMBDA)
      http://www.vlfeat.org/matlab/vl_svmtrain.html

      This function trains linear svms based on training examples, binary
      labels (-1 or 1), and LAMBDA which regularizes the linear classifier
      by encouraging W to be of small magnitude. LAMBDA is a very important
      parameter! You might need to experiment with a wide range of values for
      LAMBDA, e.g. 0.00001, 0.0001, 0.001, 0.01, 0.1, 1, 10.

      Matlab has a built in SVM, see 'help svmtrain', which is more general,
      but it obfuscates the learned SVM parameters in the case of the linear
      model. This makes it hard to compute "confidences" which are needed for
      one-vs-all classification.

    %}

    %unique() is used to get the category list from the observed training
    %category list. 'categories' will not be in the same order as in proj4.m,
    %because unique() sorts them. This shouldn't really matter, though.

    unique_labels = unique(train_labels,'stable');
    train_image_feats = train_image_feats';
    train_labels = train_labels';
    test_image_feats = test_image_feats';

%     lambda = .0001;

    SVM_models = {};
    
    global K; 
    K = rbf(train_image_feats',train_image_feats',.35); %.23

    % Now for each label, train a 1 v all model and store it in the SVM_models
    % cell array

    for ii = 1:size(unique_labels,1)
        temp_y = -1*ones(1,size(train_labels,2));
        temp_y(strcmp(unique_labels{ii},train_labels))=1;

        [temp_w,temp_b] = vl_svmtrain(train_image_feats,temp_y,lambda);

%         [sol,b] = primal_svm(0,temp_y',1);
        

        SVM_models{ii,1} = temp_w;
        SVM_models{ii,2} = temp_b;
        
%         SVM_models{ii,1} = sol;
%         SVM_models{ii,2} = b;

    end

    % Now that the models have been trained, go through each model and
    % determine the score for each image

    test_Scores = [];
    
    global K_predict;
    K_predict = rbf(test_image_feats',train_image_feats',.35);

    for ii = 1:size(unique_labels,1)
        temp_Score = [SVM_models{ii,1}]' * test_image_feats + [SVM_models{ii,2}];
        test_Scores(ii,:) = temp_Score;

%         temp_Score = SVM_models{ii,1}'*K_predict + SVM_models{ii,2};
%         test_Scores(ii,:) = temp_Score;
    end

    % Get the max index for each column - this corresponds to the category
    % assigned for each test image

    [Max_val,Max_index] = max(test_Scores,[],1);
    predicted_categories = unique_labels(Max_index);

end



