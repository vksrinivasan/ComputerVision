function tilesOut = my_mat2tiles(orig_mat,dimensions)
    x_dim = [1:dimensions(1):size(orig_mat,1)];
    y_dim = [1:dimensions(2):size(orig_mat,2)];
    
    tilesOut = {};
    tilesOutIndex = 1;
    
    for ii = 2:size(x_dim,2)
        for jj = 2:size(y_dim,2)
            temp_section = orig_mat(x_dim(ii-1):x_dim(ii)-1,y_dim(jj-1):y_dim(jj)-1);
            tilesOut{tilesOutIndex} = temp_section;
            tilesOutIndex = tilesOutIndex + 1;
        end
    end
            
end