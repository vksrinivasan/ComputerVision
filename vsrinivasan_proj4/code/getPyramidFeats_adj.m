function numHistCounts = getPyramidFeats_adj(image,vocab,pyramid_indices,...
    SIFT_size,SIFT_step,kernel_codebook_encoding)
    
    % probably should preallocate this for speed
    numHistCounts = [];
    pyramid_level_weights = [1/4;1/4;1/2];
    total_pyramid_dim = 128*21;
    
    % Do most 'fine' level of pyramid first. We can then just aggregate up
    % the histogram to get the higher pyramid histograms. 
    
    for ii = 3
        
        for jj = 2:1:size(pyramid_indices{ii},2)
            
            for zz = 2:1:size(pyramid_indices{ii},2)
                
                % clearly designate pyramid indices

                start_x_index = pyramid_indices{ii}(1,jj-1);
                end_x_index = pyramid_indices{ii}(1,jj)-1;
                start_y_index = pyramid_indices{ii}(2,zz-1);
                end_y_index = pyramid_indices{ii}(2,zz)-1;
                
                % get sift features
                
                [~, SIFT_features] = vl_dsift(single(image(start_y_index:end_y_index,...
                    start_x_index:end_x_index)),'size',SIFT_size,'step',SIFT_step,'fast');
                
                % take distance of each feature to the vocabulary to
                % determine the histogram
                
                D = vl_alldist2(double(SIFT_features),vocab);
                if(kernel_codebook_encoding)
                    N_adj = buildIterationHist(D);
                    numHistCounts = [numHistCounts;N_adj];
                else
                    [M,I] = min(D,[],2);
                    edges = 1:1:size(vocab,2);
                    [N,chk_ind] = histc(I,edges);
                    numHistCounts = [numHistCounts;N'];
                end

            end
            
        end
        
    end
    
    % Now aggregate up the finer histograms to get the higher level
    % histograms
    
    % First level 1 (we already have level 2)
    
    L_1_1 = sum(numHistCounts([1 2 5 6],:),1);
    L_1_2 = sum(numHistCounts([9 13 10 14],:),1);
    L_1_3 = sum(numHistCounts([3 7 4 8],:),1);
    L_1_4 = sum(numHistCounts([11 15 12 16],:),1);
    
    % then level 0
    
    L_0 = sum(numHistCounts(:,:));
    
    numHistCounts = [numHistCounts;L_1_1;L_1_2;L_1_3;L_1_4;L_0]';
    numHistCounts = reshape(numHistCounts,[1 size(vocab,2)*21]);
    
    % Then 'normalize' by number of elements
    
    numHistCounts = numHistCounts./size(numHistCounts,2);
    
    % Now weight the various histograms correctly (L2 gets a weight of .5,
    % L1 and L0 get weights of .25 each)
    
    numHistCounts(1,1:size(vocab,2)*16) = numHistCounts(1,1:size(vocab,2)*16)*.5;
    numHistCounts(1,size(vocab,2)*16+1:end) = numHistCounts(1,size(vocab,2)*16+1:end)*.25;
    
    % Lastly just do L1 normalization as suggested by paper
    
    numHistCounts = numHistCounts./norm(numHistCounts,1);
                
end