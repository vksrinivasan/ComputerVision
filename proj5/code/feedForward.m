function [output_mat, net] = feedForward(input_mat,weight_mat,bias_node_mat)

    net = [input_mat bias_node_mat]*weight_mat;
    output_mat = activationFunction(net);

end