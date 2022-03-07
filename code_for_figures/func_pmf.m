function pdf_val = func_pmf(K, N, e_R)
% --------------------------------------------------------------------
% This function computes equation (18) of the paper:
% "The Impact of Partial Packet Recovery on the Inherent Secrecy 
% of Random Linear Coding", which will appear (or has appeared) 
% in the Proceedings of the 95th IEEE Vehicular Technology Conference 
% (IEEE VTC 2022 - Spring, Helsinki, Finland, 19-22 June 2022).
% 
% Author: Ioannis Chatzigeorgiou, Lancaster University, United Kingdom
%
% -- Inputs --
% K   : Number of source packets
% N   : Number of trasmitted coded packets
% e_R : Packet error probability between 
%       the transmitter and the receiver
%
% -- Output --
% pdf_val : Probability that the receiver will recover the K source
%           packets after the N-th coded packet has been transmitted.
% --------------------------------------------------------------------

if N == K
    pdf_val = func_cdf(K, N, e_R);
elseif N > K
    pdf_val = func_cdf(K, N, e_R) - func_cdf(K, N-1, e_R);
else
    error('The number of transmitted packets should be greater than or equal to the number of source packets.');
end

end