function final_histogram = computeHistogram(mat_mag,mat_orientation,bins)

    final_histogram = zeros(1,9);
    bin_centers = [10:20:170];
    mat_mag = mat_mag(:);
    mat_orientation = mat_orientation(:);
    w = 180/9;
    b = size(bins,2)-1;
    
    for ii = 1:size(mat_mag,1)
       vote_1_bin = discretize(mat_orientation(ii),bins);
       vote_1_bin_center = bin_centers(vote_1_bin);
       if(vote_1_bin_center-mat_orientation(ii)>0) % orientation falls to left of center
           if(vote_1_bin-1<1)
              final_histogram(vote_1_bin) = final_histogram(vote_1_bin) + mat_mag(ii);
              continue;
           end
           vote_2_bin_center = bin_centers(vote_1_bin-1);
           vote_2_bin = vote_1_bin-1;
       else
           if(vote_1_bin+1>b)
              final_histogram(vote_1_bin) = final_histogram(vote_1_bin) + mat_mag(ii);
              continue;
           end
           vote_2_bin_center = bin_centers(vote_1_bin+1);
           vote_2_bin = vote_1_bin+1;
       end
       
       vote_1 = mat_mag(ii)*(abs(vote_2_bin_center-mat_orientation(ii))/w);
       vote_2 = mat_mag(ii)*(abs(mat_orientation(ii)-vote_1_bin_center)/w);
       
       final_histogram(vote_1_bin) = final_histogram(vote_1_bin) + vote_1;
       final_histogram(vote_2_bin) = final_histogram(vote_2_bin) + vote_2;
       
    end
    
    assert(size(final_histogram,2)==9);

end