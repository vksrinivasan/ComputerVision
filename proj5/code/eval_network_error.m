function [error,classification_error] = eval_network_error(input_mat,weight,...
    target_output_mat,target_class_mat,bias)

    threshold = 0.5;

    [output net] = feedForward(input_mat,weight,bias);

    error = sum(sum(((target_output_mat-output).^2)))/(size(target_output_mat,1)*...
        size(target_output_mat,2));

    classes = classes_from_output(output);
    
    classification_error = sum((classes ~= target_class_mat))/size(target_class_mat,1);

   
end