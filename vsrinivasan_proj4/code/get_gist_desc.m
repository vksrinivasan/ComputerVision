function out_image_feats = get_gist_desc(paths,in_image_feats)

    out_image_feats = [];
    param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale (from HF to LF)
    param.numberBlocks = 4;
    param.fc_prefilt = 4;
    
    for ii = 1:size(paths,1)
        ii
        temp_img = imread(paths{ii});
        
        [temp_gist] = LMgist(temp_img,'',param);
        temp_gist = normr(temp_gist);
        
        out_image_feats(ii,:) = [in_image_feats(ii,:) temp_gist];
        
    end
    
    out_image_feats = normr(out_image_feats);

end