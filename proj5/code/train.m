function [weights,error_train] = train(training_set,target_output_train,...
    target_class_train)

plot_data = 0;
weights = weightInitialization(0.5,size(training_set,2)+1,2);
bias_training = ones(size(training_set,1),1);
% bias_validate = ones(size(validation_set,1),1);
% bias_test = ones(size(testing_set,1),1);

epoch_count = 1;
max_iterations = 20000;

while(epoch_count<max_iterations)
    epoch_count
    weights = backpropogation(training_set,weights,0.10,bias_training,target_output_train);
    
    [error_train(epoch_count),ce_train(epoch_count)] = eval_network_error(...
        training_set,weights,target_output_train,target_class_train,bias_training);
    
%     [error_test(epoch_count),ce_test(epoch_count)] = eval_network_error(...
%         testing_set,weights,target_output_testing,target_class_testing,bias_test);
%     
%     [error_validate(epoch_count),ce_validate(epoch_count)] = eval_network_error(...
%         validation_set,weights,target_output_validation,target_class_validate,bias_validate);
%     
    epoch_count = epoch_count + 1;
end

if(plot_data==1)
%     figure();
%     plot([error_train' ce_train' error_test' ce_test' error_validate' ce_validate']);
%     legend('error train','ce train','error test','ce test', 'error validate','ce validate');
end

end