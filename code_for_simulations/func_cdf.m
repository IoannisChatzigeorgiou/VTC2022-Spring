function cdf_val = func_cdf(K, N, e_R)
% --------------------------------------------------------------------
% This function computes equation (16) of the paper:
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
%       the transmitter and a receiver
%
% -- Output --
% cdf_val : Probability that the receiver will recover the K source
%           packets after N coded packets have been transmitted.
% --------------------------------------------------------------------

sum_val = 0;

for N_R = K:N
    sum_val = sum_val + ...
              nchoosek(N, N_R) .* ...
              ((1-e_R).^N_R) .* (e_R.^(N-N_R)) .* ...
              func_prob_sys(N_R, N, K); % This function is defined below

end

cdf_val = sum_val;

% --- Additional functions ---

function prob_sys = func_prob_sys(N_R, N, K)
% --------------------------------------------------------------------
% This function computes equation (4) in the afore-mentioned paper.
%
% -- Inputs --
% K   : Number of source packets
% N   : Number of trasmitted packets
% N_R : Number of error-free packets collected by a receiver
%
% -- Output --
% prob_sys : Probability that the receiver will recover the K source
%            packets upon receipt of N_R error-free packets.
% --------------------------------------------------------------------

Term1 = nchoosek(N-K, N_R-K);

Term2 = 0;
for h = max(0, N_R+K-N):K-1
    Term2 = Term2 + nchoosek(K,h).*nchoosek(N-K, N_R-h).* ...
            func_prob_nonsys(N_R-h, K-h); % This function is defined below

end

prob_sys = (Term1 + Term2) ./ nchoosek(N, N_R);

end

function prob_nonsys = func_prob_nonsys(N_R, K)
% --------------------------------------------------------------------
% This function computes equation (2) in the afore-mentioned paper
% for q=2.
%
% -- Inputs --
% K   : Number of source packets
% N_R : Number of error-free coded packets collected by a receiver
%
% -- Output --
% prob_nonsys : Probability that the receiver will recover the K source
%               from N_R received coded packets.
% --------------------------------------------------------------------

prod = 1;

for i=0:K-1
   prod = prod * (1-2^(-(N_R-i))); 
end

prob_nonsys = prod;

end

end

