function cell_histograms = getCellHistograms(cell_mat_mag,cell_mat_orient,bins)

    % create empty cell array to hold the 1x9 histograms for each cell
    cell_histograms = cell(size(cell_mat_mag,1),size(cell_mat_mag,2));
    
    for ii = 1:size(cell_mat_mag,1)
        
        for jj = 1:size(cell_mat_mag,2)
            
            cell_histograms{ii,jj} = computeHistogram(cell_mat_mag{ii,jj},...
                cell_mat_orient{ii,jj},bins);
            
        end
        
    end


end