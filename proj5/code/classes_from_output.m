function classes = classes_from_output(output_mat)

    [~,classes] = max(output_mat,[],2);

end