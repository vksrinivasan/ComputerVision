function cell_hist_out = normalizeme(block_in,region_needed)

    total_hist = [block_in{2,2},block_in{2,1},block_in{1,2},block_in{1,1}];
    total_hist = normr(total_hist);
    
    if(region_needed==1) % bottom right, first 9 spaces needed
        cell_hist_out = total_hist(1,1:9);
    elseif(region_needed==2) % bottom left next 9 spaces needed
        cell_hist_out = total_hist(1,10:18);
    elseif(region_needed==3) % top right
        cell_hist_out = total_hist(1,19:27);
    elseif(region_needed==4)
        cell_hist_out = total_hist(1,28:36);
    end

end