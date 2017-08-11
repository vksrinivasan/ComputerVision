function [cur_confidences,cur_bboxes,cur_image_ids] = findMatchesInLevel(hog,...
    scale,feature_params,threshold,w,b,test_scenes,ii,weights_neural_net,...
    kdtree,all_data,data_labels,linear_svm,neural_net,nearest_neighbor)

    % First make room for this images confidences, bboxes, and image id.

    cur_confidences = [];
    cur_bboxes = [];
    cur_image_ids = {};
    
    % so now iterate through every 6x6 hog window (corresponding to a 
    % 36x36 img pixel window) and calculate the SVM score
    for jj = 1:1:size(hog,1)-(feature_params.template_size/feature_params.hog_cell_size)+1
        for zz = 1:1:size(hog,2)-(feature_params.template_size/feature_params.hog_cell_size)+1
            temp_subwindow = hog(jj:jj+(feature_params.template_size/feature_params.hog_cell_size)-1,...
                zz:zz+(feature_params.template_size/feature_params.hog_cell_size)-1,:);
            
            if(linear_svm == 1 && neural_net == 0 && nearest_neighbor == 0)
                temp_score = w'*temp_subwindow(:)+b;
                if(temp_score>threshold)
                    thresholdconstr = 1 ;
                else
                    thresholdconstr = 0;
                end
                add_constr = 1;
            end
            
            if(neural_net == 1 && linear_svm == 0 && nearest_neighbor == 0)
                temp_score = [[temp_subwindow(:)'] 1]*weights_neural_net;
                
                [~,neural_net_classification] = max(temp_score,[],2);
                if(neural_net_classification==1)
                    thresholdconstr = 1;
                    temp_score = temp_score(1,1);
                else
                    thresholdconstr = 0;
                end
                add_constr = 1;
            end
            
            if(nearest_neighbor == 1 && linear_svm == 0 && neural_net == 0)
                [index,distance] = vl_kdtreequery(kdtree,all_data,temp_subwindow(:),'NumNeighbors',10,'MaxComparisons',15);
                nearest_neighbor_class = sum(data_labels(index));
                temp_score = 1/mean(distance);
                if(nearest_neighbor_class>=0)
                    thresholdconstr = 1;
                else
                    thresholdconstr = 0;
                end
                add_constr = 1;
            end
                
            if(linear_svm == 1 && neural_net == 1 && nearest_neighbor == 1)
                counter = 0;
                linear_svm_score = w'*temp_subwindow(:)+b;
                
                neural_net_score = [[temp_subwindow(:)'] 1]*weights_neural_net;
                [~,neural_net_classification] = max(neural_net_score,[],2);
                
                [index,distance] = vl_kdtreequery(kdtree,all_data,temp_subwindow(:),'NumNeighbors',10,'MaxComparisons',15);
                nearest_neighbor_score = 1/mean(distance);
                nearest_neighbor_class = sum(data_labels(index));
                
                if(linear_svm_score>=threshold)
                    counter = counter + 1;
                end
                
                if(neural_net_classification==1)
                    counter = counter + 1;
                end
                
                if(nearest_neighbor_class>=0)
                    counter = counter + 1;
                end
                
                thresholdconstr = 1;
                if(counter>=2)
                    add_constr = 1;
                else
                    add_constr = 0;
                end
                
                temp_score = linear_svm_score;
            end
                
            if(thresholdconstr && add_constr)

                cur_confidences = [cur_confidences;temp_score];
                
               
                % 'convert coordinates' from HoG output to actual image
                % pixel coordinates - may need to 'rescale' back to
                % original image size if we are operating with a scaled
                % version of the image
                temp_y_min = (1/scale)*(jj*feature_params.hog_cell_size-feature_params.hog_cell_size)+1;
                temp_x_min = (1/scale)*(zz*feature_params.hog_cell_size-feature_params.hog_cell_size)+1;
                
                temp_y_max = (1/scale)*(jj+(feature_params.template_size/feature_params.hog_cell_size)-1)*feature_params.hog_cell_size;
                temp_x_max = (1/scale)*(zz+(feature_params.template_size/feature_params.hog_cell_size)-1)*feature_params.hog_cell_size;
                
                cur_bboxes = [cur_bboxes;[temp_x_min temp_y_min temp_x_max ...
                    temp_y_max]];
                cur_image_ids = [cur_image_ids;test_scenes(ii).name];
            end
        end
    end


end

