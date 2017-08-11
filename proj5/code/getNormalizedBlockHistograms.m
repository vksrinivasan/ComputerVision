function hog_descriptor = getNormalizedBlockHistograms(cell_histograms)

    hog_descriptor = zeros(size(cell_histograms,1),size(cell_histograms,2),36);
    
    cell_histograms_adj = cell(size(cell_histograms,1)+2,size(cell_histograms,2)+2);
    cell_histograms_adj(2:size(cell_histograms_adj,1)-1,2:size(cell_histograms_adj,2)-1) = cell_histograms;
    zeros_array = zeros(1,9);
    
    for ii=1:size(cell_histograms_adj,1)
        cell_histograms_adj{ii,1} = zeros_array;
    end
    
    for ii=1:size(cell_histograms_adj,1)
        cell_histograms_adj{ii,end} = zeros_array;
    end
    
    for ii=1:size(cell_histograms_adj,2)
        cell_histograms_adj{1,ii} = zeros_array;
    end
    
    for ii=1:size(cell_histograms_adj,2)
        cell_histograms_adj{end,ii} = zeros_array;
    end
    
    
    for ii = 2:size(cell_histograms_adj,1)-1
        for jj = 2:size(cell_histograms_adj,2)-1
            
            temp_block_1 = cell_histograms_adj(ii-1:ii,jj-1:jj); % bottom right
            temp_block_2 = cell_histograms_adj(ii-1:ii,jj:jj+1); % bottom left
            temp_block_3 = cell_histograms_adj(ii:ii+1,jj-1:jj); % top right
            temp_block_4 = cell_histograms_adj(ii:ii+1,jj:jj+1); % top right
            
            cell_1 = normalizeme(temp_block_1,1);
            cell_2 = normalizeme(temp_block_2,2);
            cell_3 = normalizeme(temp_block_3,3);
            cell_4 = normalizeme(temp_block_4,4);
            
            hog_descriptor(ii-1,jj-1,:) = [cell_1 cell_2 cell_3 cell_4];
        end
    end
    
end