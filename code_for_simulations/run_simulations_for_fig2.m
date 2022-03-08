% Number of source packets
K   = 20;
% Length of each packet (in bits)
L   = 128;
% Range of packet error probabilities
% between the source and the destination
e_D = 0.01:0.01:0.1;
% Range of packet error probabilities
% between the source and the eavesdropper
e_E = [0.1 0.15 0.2];

for idx = 1:length(e_E)
    
    % Execute simulations of RLC (fig. 2)
    sim_intercept_RLC_only_for_fig2(K, L, e_D, e_E(idx));
    
    % Execute simulations of RLC aided by Syndrome Decoding (fig. 2)
    sim_intercept_RLC_with_SD_for_fig2(K, L, e_D, e_E(idx));
    
end