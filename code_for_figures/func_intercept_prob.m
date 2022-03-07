function int_value = func_intercept_prob(K, N_max, e_D, e_E)
% --------------------------------------------------------------------
% This function computes equation (19) of the paper:
% "The Impact of Partial Packet Recovery on the Inherent Secrecy 
% of Random Linear Coding", which will appear (or has appeared) 
% in the Proceedings of the 95th IEEE Vehicular Technology Conference 
% (IEEE VTC 2022 - Spring, Helsinki, Finland, 19-22 June 2022).
% 
% Author: Ioannis Chatzigeorgiou, Lancaster University, United Kingdom
%
% -- Inputs --
% K     : Number of source packets
% N_max : Number of trasmitted coded packets
% e_D   : Packet error probability between 
%         the source and the destination
% e_E   : Packet error probability between 
%         the source and the eavesdropper
%
% -- Output --
% int_val : Probability that the eavesdropper will recover the K source
%           packets after N_max coded packets have been transmitted.
% --------------------------------------------------------------------

term_1 = 0;

for N=K:N_max
    term_1 = term_1 + func_pmf(K, N, e_D) .* func_cdf(K, N, e_E);
end

term_2 = func_cdf(K, N_max, e_E) .* (1 - func_cdf(K, N_max, e_D)); 

int_value = term_1 + term_2;

end