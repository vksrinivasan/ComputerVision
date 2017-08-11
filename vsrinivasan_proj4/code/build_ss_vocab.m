function vocab_ss = build_ss_vocab(selfSimDesc,vocab_size)
	
	% cluster descriptors to form vocabulary for self similairty
	[centers, assignments] = vl_kmeans(single(selfSimDesc), vocab_size);
	
	% transpose matrix for the rest of the code
    vocab = centers';
    
end