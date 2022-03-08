load('data_RLC_K20_0p.mat');

target_decoding_prob = 0.99;

e_dest = [0.001 0.025:0.025:0.5];

N_values_theory = zeros(length(target_decoding_prob), length(e_dest));

for idx_1 = 1:length(target_decoding_prob)
    
    for idx_2 = 1:length(e_dest)
        
        aggregate = 0;
        n_T = K;
           
        while func_cdf(K, n_T, e_dest(idx_2)) < target_decoding_prob(idx_1)     
            
            n_T = n_T + 1;
            
        end
        
        N_values_theory(idx_1, idx_2) = n_T;
        
    end
    
end

filename = ['theory_RLC_K',num2str(K),'_N_values.mat'];
save(filename, 'K', 'e_dest', 'target_decoding_prob', 'N_values_theory');
