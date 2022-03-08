% Number of source packets
K     = 20;
% Length of each packet (in bits)
L      = 128;
% Range of packet error probabilities
% between the source and the destination
e_dest = [0.001 0.025:0.025:0.5];
% Range of differences in the packet error probabilities
% between the source and the eavesdropper
delta  = [0 0.05 0.1]; 
% i.e., e_eavesdropper = e_destination + delta

%% PART 1

% ---- Run the simulations ----

for idx = 1:length(delta)
    
    % Execute simulations of RLC (fig. 3)
    sim_RLC_only_for_fig3(K, L, e_dest, delta(idx));
    
    % Execute simulations of RLC aided by Syndrome Decoding (fig. 3)
    sim_RLC_with_SD_for_fig3(K, L, e_dest, delta(idx))

end

%% PART 2

% ---- Calculate the value of N_max (transmitted coded packets)
% for a target decoding probability at the destination 
% and a given packet error probability at the destination ----

% Set the target decoding probability at the destination
% (could be a scalar or a row vector, e.g., [0.99 0.90])
target_decoding_prob = 0.99;

% Initialise the vector of N values
N_values_theory = zeros(length(target_decoding_prob), length(e_dest));

warning off

for idx_1 = 1:length(target_decoding_prob)
    
    for idx_2 = 1:length(e_dest)
        
        aggregate = 0;
        N_max = K;
           
        while func_cdf(K, N_max, e_dest(idx_2)) < target_decoding_prob(idx_1)     
            
            N_max = N_max + 1;
            
        end
        
        N_values_theory(idx_1, idx_2) = N_max;
        
    end
    
end

filename = ['theory_RLC_K',num2str(K),'_N_values_lowres.mat'];
save(filename, 'K', 'e_dest', 'target_decoding_prob', 'N_values_theory');

%% PART 3

% Re-run the same loop for a smaller step of e_dest in order to obtain 
% a higher resolution plot for e_dest (x-axis) vs N_max (y-axis)

% Re-define e_dest
e_dest = e_dest(1):0.001:e_dest(end);

% Initialise the vector of N values
N_values_theory = zeros(length(target_decoding_prob), length(e_dest));

for idx_1 = 1:length(target_decoding_prob)
    
    for idx_2 = 1:length(e_dest)
        
        aggregate = 0;
        N_max = K;
           
        while func_cdf(K, N_max, e_dest(idx_2)) < target_decoding_prob(idx_1)     
            
            N_max = N_max + 1;
            
        end
        
        N_values_theory(idx_1, idx_2) = N_max;
        
    end
    
end

filename = ['theory_RLC_K',num2str(K),'_N_values_highres.mat'];
save(filename, 'K', 'e_dest', 'target_decoding_prob', 'N_values_theory');

warning on
