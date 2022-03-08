function sim_intercept_RLC_only_for_fig2(K, L, e_dest, e_eaves)
% --------------------------------------------------------------------
% This function simulates a system that consists of a source, 
% a destination and an eavesdropper. The source uses random linear coding 
% (RLC) to encode K source packets. Both the destination and the
% eavesdropper use RLC decoding to recover the K source packets.
% *** The source ceases transmission when the destination recovers the 
% source packets. ***
%
% The system is described in 
% "The Impact of Partial Packet Recovery on the Inherent Secrecy 
% of Random Linear Coding", which will appear (or has appeared) 
% in the Proceedings of the 95th IEEE Vehicular Technology Conference 
% (IEEE VTC 2022 - Spring, Helsinki, Finland, 19-22 June 2022).
% 
% Author: Ioannis Chatzigeorgiou, Lancaster University, United Kingdom
%
% If you use this code or the simulation results, 
% please cite the paper above.
%
% If you modify this code, please cite the paper above and 
% share your code with the research community.
% --------------------------------------------------------------------
%
% Syntax:
% > sim_intercept_RLC_only_for_fig2(K, L, e_dest, e_eaves)
%
% --- Input arguments ---
% K       : Number of source packets
% L       : Length of transmitted/received source/coded packet in bits
% e_dest  : Packet error probability at the destination
% e_eaves : Packet error probability at the eavesdropper

% --- Definition of variables ---

% Number of experiments
experiments = 6*10^4;

% --- Initialisation ---

% Probability that the eavesdropper will recover the source packets
intercept_prob = zeros(1, length(e_dest));

% Compute the bit error_probability at the eavesdropper
e_eaves_b = 1-nthroot(1-e_eaves, L);  

% Consider all values of the packet error probability at the destination
for idx = 1:length(e_dest)
    
    disp(['Packet error probability at the destination = ', num2str(e_dest(idx))]);
    disp(['Packet error probability at the eavesdropper = ', num2str(e_eaves)]);
    
    % Compute the bit error_probability at the destination
    e_dest_b = 1-nthroot(1-e_dest(idx), L);    
    
    for experiment = 1:experiments
           
        if rem(experiment, 5000) == 0
            disp(['Completed ', num2str(experiment),' experiments']);
        end
        
        % Find a full rank KxK random matrix
        rank_pfx_matrix = 0;
        while rank_pfx_matrix < K
            pfx_matrix = randi([0 1], K);
            [rank_pfx_matrix, ~] = func_bin_m2ref(pfx_matrix);
        end           
               
        get_rank_dest = 0;
        get_rank_eaves = 0;
        N = K - 1;
        
        % Stop when the destination recovers the data or 
        % the eavesdropper recovers the data
        while (get_rank_dest < K) && (get_rank_eaves < K)
            
            % --- SOURCE ---
            
            % Transmit one more packet
            N = N + 1;
            
            if N == K
                coding_matrix = [];
                % Generate the KxL error matrix (effect of the channel)
                % at the destination and the eavesdropper
                error_matrix_dest  = rand(K, L);
                error_matrix_eaves = rand(K, L);                
            else
                % Generate the (N-K)xK coding matrix for the last (N-K) coded packets
                coding_matrix = [coding_matrix; randi([0 1], 1, K)];
                % Add rows to obtain the NxL error matrix (effect of the channel)
                % at the destination and the eavesdropper
                error_matrix_dest  = [error_matrix_dest; rand(1, L)];
                error_matrix_eaves = [error_matrix_eaves; rand(1, L)];                   
            end
            
            % Similarly, the NxK generator matrix is composed of the
            % KxK identity matrix and the (N-K)xK coding matrix
            generator_matrix = [pfx_matrix; coding_matrix];
            
            % --- DESTINATION ---                      
   
            % Change all values greater than (1-e_dest_b) to 'one' and keep all other
            % values to 'zero'. A value of 'one' implies that the bit in the
            % respective packet will be 'flipped'. Example: if e_dest_b = 0.3, then any
            % entries that take values between 0.7 and 1 will be mapped to 1.
            error_matrix_dest = error_matrix_dest > 1-e_dest_b;
            
            % Identify packets that do not contain bit errors. 
            % Add the columns of the error_matrix, isolate the rows that 
            % give zero, i.e. no errors, and use the indices of these rows 
            % to build the generator matrix at the destination
            genator_matrix_dest = generator_matrix(sum(error_matrix_dest, 2)<1, :);
            
            % Check the rank of the generator matrix at the destination
            [get_rank_dest, ~] = func_bin_m2ref(genator_matrix_dest);

            % --- EAVESDROPPER ---         
                 
            error_matrix_eaves = error_matrix_eaves > 1-e_eaves_b;
            generator_matrix_eaves = generator_matrix(sum(error_matrix_eaves, 2)<1, :);
            
            % Check the rank of the generator matrix at the eavesdropper
            [get_rank_eaves, ~] = func_bin_m2ref(generator_matrix_eaves);
            
            % If the rank is equal to the number of source packets, the original
            % source packets can be recovered by the eavesdropper.
            if (get_rank_eaves == K)
                intercept_prob(idx) = intercept_prob(idx) + 1;
            end
            
        end
        
    end % experiment
    
    intercept_prob(idx) = intercept_prob(idx) / experiments;
    
end % N

% Convert the packet error probability to a string and replace the dot with
% 'p', i.e., 0.002 will become '0p002'.
str_e_eaves    = num2str(e_eaves, '%f');
str_len        = find(str_e_eaves~='0', 1, 'last');
str_e_eaves    = str_e_eaves(1:str_len);
str_e_eaves(2) = 'p';

filename = ['data_RLC_K',num2str(K),'_',str_e_eaves,'.mat'];
save(filename, 'experiments', 'K', 'L', 'intercept_prob', 'e_dest', 'e_eaves');

end % function
