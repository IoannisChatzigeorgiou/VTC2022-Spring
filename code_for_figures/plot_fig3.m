% --------------------------------------------------------------------
% This script plots Figure 3 of the paper:
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

warning off

load(['fig3_data',filesep,'data_RLC_only',filesep,'theory_RLC_K20_N_values_highres.mat']);
e_dest_highres          = e_dest;
N_values_theory_highres = N_values_theory;
clear e_dest K target_decoding_prob N_values_theory

load(['fig3_data',filesep,'data_RLC_only',filesep,'theory_RLC_K20_N_values_lowres.mat']);
clear e_dest K target_decoding_prob

target_decoding_prob = 0.99;
    
% --------------- CASE 1a: e_eaves = e_dest ---------------

load(['fig3_data',filesep,'data_RLC_only',filesep,'data_RLC_K20_0p.mat']);

e_dest                      = [0.001 0.025:0.025:0.5];
intercept_prob_d0p00        = zeros(length(target_decoding_prob), length(e_dest));
intercept_prob_theory_d0p00 = zeros(length(target_decoding_prob), length(e_dest));

for idx_1 = 1:length(target_decoding_prob)
    
    for idx_2 = 1:length(e_dest)
        
        intercept_prob_d0p00(idx_1, idx_2) = ...
            sum(success_at_eavesdropper_for_tx_packets(idx_2, 1:N_values_theory(idx_1, idx_2))) / experiments;     

        intercept_prob_theory_d0p00(idx_1, idx_2) = ...
            func_intercept_prob(K, N_values_theory(idx_1, idx_2), e_dest(idx_2), e_eaves(idx_2));      
        
    end
    
end

% --------------- CASE 1b: e_eaves = e_dest + 0.05 ---------------

load(['fig3_data',filesep,'data_RLC_only',filesep,'data_RLC_K20_0p05.mat']);

e_dest                      = [0.001 0.025:0.025:0.5];
intercept_prob_d0p05        = zeros(length(target_decoding_prob), length(e_dest));
intercept_prob_theory_d0p05 = zeros(length(target_decoding_prob), length(e_dest));

for idx_1 = 1:length(target_decoding_prob)
    
    for idx_2 = 1:length(e_dest)
        
        intercept_prob_d0p05(idx_1, idx_2) = ...
            sum(success_at_eavesdropper_for_tx_packets(idx_2, 1:N_values_theory(idx_1, idx_2))) / experiments;
        
        intercept_prob_theory_d0p05(idx_1, idx_2) = ...
            func_intercept_prob(K, N_values_theory(idx_1, idx_2), e_dest(idx_2), e_eaves(idx_2));
        
    end
    
end

% --------------- CASE 1c: e_eaves = e_dest + 0.1 ---------------

load(['fig3_data',filesep,'data_RLC_only',filesep,'data_RLC_K20_0p1.mat']);

e_dest                      = [0.001 0.025:0.025:0.5];
intercept_prob_d0p10        = zeros(length(target_decoding_prob), length(e_dest));
intercept_prob_theory_d0p10 = zeros(length(target_decoding_prob), length(e_dest));

for idx_1 = 1:length(target_decoding_prob)
    
    for idx_2 = 1:length(e_dest)
        
        intercept_prob_d0p10(idx_1, idx_2) = ...
            sum(success_at_eavesdropper_for_tx_packets(idx_2, 1:N_values_theory(idx_1, idx_2))) / experiments;
        
        intercept_prob_theory_d0p10(idx_1, idx_2) = ...
            func_intercept_prob(K, N_values_theory(idx_1, idx_2), e_dest(idx_2), e_eaves(idx_2));
        
    end
    
end

% --------------- CASE 2a: e_eaves = e_dest ---------------

load(['fig3_data',filesep,'data_RLC_SD',filesep,'data_RLC_SD_K20_L128_0p.mat']);

e_dest                  = [0.001 0.025:0.025:0.5];
intercept_prob_SD_d0p00 = zeros(length(target_decoding_prob), length(e_dest));

for idx_1 = 1:length(target_decoding_prob)
    
    for idx_2 = 1:length(e_dest)
        
        intercept_prob_SD_d0p00(idx_1, idx_2) = ...
            sum(success_at_eavesdropper_for_tx_packets(idx_2, 1:N_values_theory(idx_1, idx_2))) / experiments;
               
    end
    
end

% --------------- CASE 2b: e_eaves = e_dest + 0.05 ---------------

load(['fig3_data',filesep,'data_RLC_SD',filesep,'data_RLC_SD_K20_L128_0p05.mat']);

e_dest                  = [0.001 0.025:0.025:0.5];
intercept_prob_SD_d0p05 = zeros(length(target_decoding_prob), length(e_dest));

for idx_1 = 1:length(target_decoding_prob)
    
    for idx_2 = 1:length(e_dest)
        
        intercept_prob_SD_d0p05(idx_1, idx_2) = ...
            sum(success_at_eavesdropper_for_tx_packets(idx_2, 1:N_values_theory(idx_1, idx_2))) / experiments;
               
    end
    
end

% --------------- CASE 2c: e_eaves = e_dest + 0.1 ---------------

load(['fig3_data',filesep,'data_RLC_SD',filesep,'data_RLC_SD_K20_L128_0p1.mat']);

e_dest                  = [0.001 0.025:0.025:0.5];
intercept_prob_SD_d0p10 = zeros(length(target_decoding_prob), length(e_dest));

for idx_1 = 1:length(target_decoding_prob)
    
    for idx_2 = 1:length(e_dest)
        
        intercept_prob_SD_d0p10(idx_1, idx_2) = ...
            sum(success_at_eavesdropper_for_tx_packets(idx_2, 1:N_values_theory(idx_1, idx_2))) / experiments;
               
    end
    
end

% ------------------------- PLOTS -------------------------

str_colour = 'kbrgm';
str_marker = 'x+.os';
str_type   = {'-', '--', '-.'};

% Create figure
figure1 = figure('InvertHardcopy','off','Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.0952380952380952 0.11 0.882142857142856 0.217195467422096],...
    'FontSize',12);
ylim(axes1,[20 70]);
set(axes1,'ytick',20:10:70)
xlim(axes1,[0 0.5]);
set(axes1,'xtick',0:0.05:0.5)
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'all');

for idx = 1:length(target_decoding_prob)
    
    plot(e_dest_highres, N_values_theory_highres(idx,:), 'r-')
    
end

% Create ylabel
ylabel('$N_\mathrm{max}$',...
       'Interpreter','latex','FontSize',13);

% Create xlabel
xlabel('Packet erasure probability at the destination, $\varepsilon_\mathrm{D}$',...
       'Interpreter','latex','FontSize',12);   
   
% Create axes
axes2 = axes('Parent',figure1,...
    'Position',[0.0952380952380952 0.453 0.882142857142856 0.532847699986517],...
    'FontSize',12);

xlim(axes2,[0 0.5]);
set(axes2,'xtick',0:0.05:0.5)
ylim(axes2,[0 1]);
box(axes2,'on');
grid(axes2,'on');
hold(axes2,'all');

% dummy plot
plot(-1, -1, 'k-');
plot(-1, -1, 'kx');
plot(-1, -1, 'b--');

for idx = 1:length(target_decoding_prob)
    
    plot(e_dest, intercept_prob_d0p00(idx,1:21), [str_colour(idx),str_type{idx}]);
    plot(e_dest, intercept_prob_theory_d0p00(idx,:), [str_colour(idx),str_marker(idx)]);    
   
end

for idx = 1:length(target_decoding_prob)
    
    plot(e_dest, intercept_prob_d0p05(idx,1:21), [str_colour(idx),str_type{idx}]);
    plot(e_dest, intercept_prob_theory_d0p05(idx,:), [str_colour(idx),str_marker(idx)]);
   
end

for idx = 1:length(target_decoding_prob)
    
    plot(e_dest, intercept_prob_d0p10(idx,1:21), [str_colour(idx),str_type{idx}]);
    plot(e_dest, intercept_prob_theory_d0p10(idx,:), [str_colour(idx),str_marker(idx)]);
   
end

for idx = 1:length(target_decoding_prob)
   
    plot(e_dest, intercept_prob_SD_d0p00(idx,:), 'b--');

end

for idx = 1:length(target_decoding_prob)
   
    plot(e_dest, intercept_prob_SD_d0p05(idx,:), 'b--');

end

for idx = 1:length(target_decoding_prob)
   
    plot(e_dest, intercept_prob_SD_d0p10(idx,:), 'b--');

end

% Create ylabel
ylabel('Intercept probability, $P_\mathrm{int}$','Interpreter','latex','FontSize',12);

% Create xlabel
xlabel('Packet erasure probability at the destination, $\varepsilon_\mathrm{D}$',...
       'Interpreter','latex','FontSize',12);

% Create legend
h = legend('RLC only (sim.)', 'RLC only (theory)', ...
           'RLC with SD for $L=128$ (sim.)', ...
           'Interpreter', 'latex');
set(h,'FontSize', 11, 'Location', 'SouthEast');


% Create ellipse
annotation(figure1,'ellipse',...
    [0.243857142857143 0.653968253968256 0.0192380952380952 0.0412698412698417]);

% Create ellipse
annotation(figure1,'ellipse',...
    [0.245047619047619 0.747619047619048 0.0192380952380952 0.0269841269841269]);

% Create ellipse
annotation(figure1,'ellipse',...
    [0.243857142857143 0.577777777777778 0.0192380952380951 0.0603174603174634]);

% Create arrow
annotation(figure1,'arrow',[0.202380952380952 0.244047619047619],...
    [0.700587301587302 0.674603174603175],'HeadWidth',6,'HeadLength',6);

% Create arrow
annotation(figure1,'arrow',[0.228571428571429 0.254761904761905],...
    [0.541269841269841 0.57936507936508],'HeadWidth',6,'HeadLength',6);

% Create arrow
annotation(figure1,'arrow',[0.239285714285714 0.252380952380952],...
    [0.820634920634921 0.776190476190476],'HeadWidth',6,'HeadLength',6);

% Create textbox
annotation(figure1,'textbox',...
    [0.172619047619047 0.489793650490902 0.190535763331822 0.0695238098265633],...
    'String',{'$\varepsilon_\mathrm{E}\!=\!\varepsilon_\mathrm{D}\!+\!0.1$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',12);

% Create textbox
annotation(figure1,'textbox',...
    [0.09047619047619 0.683444444141695 0.204821523030599 0.0695238098265633],...
    'String',{'$\varepsilon_\mathrm{E}\!=\!\varepsilon_\mathrm{D}\!+\!0.05$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',12);

% Create textbox
annotation(figure1,'textbox',...
    [0.178571428571428 0.799317460014711 0.138154474894206 0.0695238098265633],...
    'String',{'$\varepsilon_\mathrm{E}=\varepsilon_\mathrm{D}$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',12);