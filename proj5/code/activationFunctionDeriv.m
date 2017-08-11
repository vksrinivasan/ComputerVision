function mat_out = activationFunctionDeriv(mat_in)

    % will be used for back propogation. again my activation function
    % is the hyperbolic tangent function, so I just take the derivative of
    % that f(x) = (tanh(x) + 1)/2, f'(x) = (1-tanh^2(x))/2 = sech^2(x)/2
    
    mat_out = (sech(mat_in).^2)/2;
    
end

