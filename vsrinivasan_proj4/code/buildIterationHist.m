function out_Hist = buildIterationHist(distance)
    
    out_Hist = zeros(1,size(distance,2));
    sigma = 10000000000000;
    
    for ii = 1:size(distance,1)
        iteration_dist = distance(ii,:);
        [~,temp_idx] = sort(iteration_dist,'ascend');
        smallest_3_dist = iteration_dist(1,temp_idx(1,1:3));
        smallest_3_dist_adj = exp(-1*(smallest_3_dist.^5./(2*sigma.^2)));
        out_Hist(1,temp_idx(1:3)) = out_Hist(1,temp_idx(1:3)) + smallest_3_dist_adj;
    end

end