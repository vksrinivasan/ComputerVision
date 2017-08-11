function hog_descriptor = my_hog(img_in,cell_size)

    d_x = [-1 0 1];
    d_y = d_x';
    I_x = conv2(img_in,d_x,'same');
    I_y = conv2(img_in,d_y,'same');
    
    magnitude = (I_x.^2 + I_y.^2).^(1/2);
    orientation = atan2d(I_y,I_x);
    
    orientation = orientation+(orientation<0)*180;
    
    % group magnitude and orientation matrices into 'cells' (cell size
    % given)
    
    cell_mat_mag = mat2tiles(magnitude,[cell_size cell_size]);
    cell_mat_orient = mat2tiles(orientation,[cell_size cell_size]);
    
    % Now create histograms for each cell
    bins = [0:20:180];
    cell_histograms = getCellHistograms(cell_mat_mag,cell_mat_orient,bins);
    
    % Now normalize using 'blocks'
    hog_descriptor = getNormalizedBlockHistograms(cell_histograms);
    
    % Now normalize the final total descriptor
    norm_factor = norm(hog_descriptor(:)');
    hog_descriptor = hog_descriptor./norm_factor;
    
end