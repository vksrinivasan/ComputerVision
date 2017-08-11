function updated_Weights = backpropogation(input_mat,weights,learning_rate,...
    bias,target_outputs)

    random_sample = randi([1,size(input_mat,1)],1);

    [output,net] = feedForward(input_mat(random_sample,:),weights,bias(random_sample,:));
    error_vector = target_outputs(random_sample,:)-output;
    
    delta_sensitivity = error_vector.*activationFunctionDeriv(net);
    weights_delta = learning_rate.*kron([input_mat(random_sample,:) bias(random_sample,:)]',delta_sensitivity);
    
    updated_Weights = weights + weights_delta;

end