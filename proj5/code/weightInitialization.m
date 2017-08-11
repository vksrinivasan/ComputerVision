function initialized_Weights = weightInitialization(max_weight,num_row,num_columns)

    initialized_Weights = rand(num_row,num_columns)*(max_weight+max_weight)-max_weight;

end

