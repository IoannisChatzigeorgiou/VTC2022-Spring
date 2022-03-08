function E_mat_est = func_SD_solver(K, N, B, Gen_mat, E_mat)
% --------------------------------------------------------------------
% This function implements Syndrome Decoding, which is described in 
% Section IV of the paper: 
% "The Impact of Partial Packet Recovery on the Inherent Secrecy 
% of Random Linear Coding", which will appear (or has appeared) 
% in the Proceedings of the 95th IEEE Vehicular Technology Conference 
% (IEEE VTC 2022 - Spring, Helsinki, Finland, 19-22 June 2022).
% 
% Author: Ioannis Chatzigeorgiou, Lancaster University, United Kingdom
%
% Syndrome Decoding was originally proposed by  
% M. S. Mohammadi, Q. Zhang, and E. Dutkiewicz, 
% in "Reading damaged scripts: Partial packet recovery based on 
% compressive sensing for efficient random linear coded transmission," 
% IEEE Trans. Commun., vol. 64, no. 8, pp. 3296–3310, Aug. 2016.
%
% If you use this code, please cite the VTC paper and 
% the IEEE Trans. Commun. paper above.
%
% If you modify this code, please cite the two papers above and 
% share your code with the research community.
% --------------------------------------------------------------------
%
% Syntax:
% > E_mat_est = func_SD_solver(K, N, B, Gen_mat, E_mat)
%
% --- Input arguments ---
% K : number of source packets
% N : number of coded packets
% B : bits in a packet
% E_mat   : error matrix (NxB matrix) [used in place of CRC verification]
% Gen_mat : generator matrix (NxK matrix)
%
% --- Output argument ---
% E_mat_est : estimated error matrix (NxB matrix)

% Initialise the estimate of the error matrix
E_mat_est = zeros(N, B);

% Identify packets that contain bit errors. Add the columns of
% the error matrix and focus on rows that give values larger than zero.
% Return the indices of rows of E_mat that contain errors (ones).
indices_of_erroneous_rows = find(sum(E_mat, 2)>0);
    
% Construction of the parity check matrix A, so that A*C=0.
% In systematic coding, the generator matrix has the form
% C = [I; C_mat] and the parity-check matrix takes the form
% A = [-C_mat I] so that A*C = 0.
% In full-rank non-systematic RLC, the generator matrix needs to be 
% converted into an equivalent generator matrix for systematic coding,
% - see expression (6) in the afore-mentioned paper - and then use 
% expression (8) to obtain the parity-check matrix.
equiv_Gen_mat = func_gauss_ref2rref(func_gauss_m2ref(Gen_mat'))';
C_mat         = equiv_Gen_mat(K+1:N, :);
A             = [C_mat eye(N-K)]; % -C_mat = C_mat in GF(2)

for bit_pos = 1:B
    
    % Construction of the syndrome, see expression (15)
    % Note that s and A are known by the receiver but
    % E_mat should be determined (estimated).
    s = mod(A*E_mat(:, bit_pos), 2); % Syndrome in GF(2)
    
    % Syndrome decoding (v2) is used to determine E_mat
    get_solution = estimate_error_matrix(A, s, indices_of_erroneous_rows);
    
    % The estimated binary solutions for
    % the specified bit position are stored.
    E_mat_est(:, bit_pos) = get_solution;
    
end

% -- Additional function(s) --

function sol = estimate_error_matrix(parity_check, syndrome, indices_of_erroneous_rows)
% Let K be the number of systematic packets, N-K be the number of coded
% packets, N be the total number of transmitted packets and B be the number
% of bits in each packet.
%
% <Input arguments>
%   parity_check   : The parity check matrix with dimensions (N-K)xN
%   syndrome       : (N-K)x1 vector obtained by the receiver.
%                    It is equal to the product of the (N-K)xN parity check 
%                    matrix and a Nx1 error vector for a specific bit
%                    position.
%   indices_of_erroneous_rows 
%                  : Rows of the error matrix that correspond to packets
%                    that were received with errors and did not pass CRC.
% <Output argument>
%   sol          : Estimated Nx1 error vector

% Determine the value of N (call it N_val in this function)
N_val = size(parity_check, 2);

% Determine the number of rows (out of the N) that contain errors
N_err = length(indices_of_erroneous_rows);

% Check if the all-zero column is a solution
expanded_current_combination = zeros(1, N_val);
if syndrome == mod(parity_check*expanded_current_combination', 2)
    
    sol = expanded_current_combination';
    return
    
else
    
    % Number of elements chosen
    % (try all posibilities until the most sparse is found)
    for M=1:N_err
        
        % Initialise variables
        current_combination          = zeros(1, N_err);
        expanded_current_combination = zeros(1, N_val);
        position                     = zeros(1, M);
        for i=1:M
            position(i) = N_err-i+1;
            current_combination(position(i))=1;
        end
        
        expanded_current_combination(indices_of_erroneous_rows) = current_combination;
        if syndrome == mod(parity_check*expanded_current_combination', 2)
            
            sol = expanded_current_combination';
            return
            
        else
            
            num_combinations = 1;
            
            while position(1)>M
                
                if (position(M)-1)>0
                    current_combination(position(M))=0;
                    position(M) = position(M) - 1;
                    current_combination(position(M))=1;
                elseif (M>1)
                    index = M-1;
                    not_shifted = 1;
                    while (index >= 1) && not_shifted
                        if (position(index)-1)>position(index+1)
                            current_combination(position(index))=0;
                            position(index) = position(index) - 1;
                            current_combination(position(index))=1;
                            not_shifted = 0;
                        else
                            index = index - 1;
                        end
                    end
                    for i=(index+1):M
                        current_combination(position(i))=0;
                        position(i) = position(i-1) - 1;
                        current_combination(position(i))=1;
                    end
                end
                
                num_combinations = num_combinations + 1;
                
                expanded_current_combination(indices_of_erroneous_rows) = current_combination;
                if syndrome == mod(parity_check*expanded_current_combination', 2)
                    
                    sol = expanded_current_combination';
                    return
                end
                
            end % WHILE loop for different combinations
            
        end
      
    end % FOR loop to reduce sparsity
    
end % if all-zero is solution

end % function estimate_error_matrix

end % function SD_solver
