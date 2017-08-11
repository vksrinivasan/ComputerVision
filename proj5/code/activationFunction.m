function mat_out = activationFunction(mat_in)
    
    % I use a hyperbolic tangent function for now. Unsure how different
    % functions would change my result
    
    mat_out = (tanh(mat_in)+1)/2;

end