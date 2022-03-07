% This script plots Figure 4 of the paper:
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

load(['fig4_data',filesep,'data_RLC_only',filesep,'theory_RLC_K20_N_values_highres.mat']);
e_dest_highres          = e_dest;
N_values_theory_highres = N_values_theory;
clear e_dest K target_decoding_prob N_values_theory

load(['fig4_data',filesep,'data_RLC_only',filesep,'theory_RLC_K20_N_values_lowres.mat']);
clear e_dest K target_decoding_prob

target_decoding_prob = 0.99;
    
% --------------- CASE 1: e_eaves = e_dest ---------------

load(['fig4_data',filesep,'data_RLC_SD',filesep,'data_RLC_SD_K20_L128_0p.mat']);

e_dest                      = [0.001 0.025:0.025:0.5];
intercept_prob_SD_d0p00     = zeros(1, length(e_dest));
intercept_prob_SD_d0p00_N25 = zeros(1, length(e_dest));
intercept_prob_SD_d0p00_N27 = zeros(1, length(e_dest));
intercept_prob_SD_d0p00_N29 = zeros(1, length(e_dest));
    
for idx = 1:length(e_dest)
    
    intercept_prob_SD_d0p00(idx) = ...
        sum(success_at_eavesdropper_for_tx_packets(idx, 1:N_values_theory(1, idx))) / experiments;
    
    intercept_prob_SD_d0p00_N25(idx) = ...
        sum(success_at_eavesdropper_for_tx_packets(idx, 1:25)) / experiments;
    
    intercept_prob_SD_d0p00_N27(idx) = ...
        sum(success_at_eavesdropper_for_tx_packets(idx, 1:27)) / experiments;

    intercept_prob_SD_d0p00_N29(idx) = ...
        sum(success_at_eavesdropper_for_tx_packets(idx, 1:29)) / experiments;    
    
end
  
% --------------- CASE 2: e_eaves = e_dest + 0.05 ---------------

load(['fig4_data',filesep,'data_RLC_SD',filesep,'data_RLC_SD_K20_L128_0p05.mat']);

e_dest                      = [0.001 0.025:0.025:0.5];
intercept_prob_SD_d0p05     = zeros(1, length(e_dest));
intercept_prob_SD_d0p05_N25 = zeros(1, length(e_dest));
intercept_prob_SD_d0p05_N27 = zeros(1, length(e_dest));
intercept_prob_SD_d0p05_N29 = zeros(1, length(e_dest));

for idx = 1:length(e_dest)
    
    intercept_prob_SD_d0p05(idx) = ...
        sum(success_at_eavesdropper_for_tx_packets(idx, 1:N_values_theory(1, idx))) / experiments;
    
    intercept_prob_SD_d0p05_N25(idx) = ...
        sum(success_at_eavesdropper_for_tx_packets(idx, 1:25)) / experiments;
    
    intercept_prob_SD_d0p05_N27(idx) = ...
        sum(success_at_eavesdropper_for_tx_packets(idx, 1:27)) / experiments;

    intercept_prob_SD_d0p05_N29(idx) = ...
        sum(success_at_eavesdropper_for_tx_packets(idx, 1:29)) / experiments;    
    
end

% --------------- CASE 3: e_eaves = e_dest + 0.1 ---------------

load(['fig4_data',filesep,'data_RLC_SD',filesep,'data_RLC_SD_K20_L128_0p1.mat']);

e_dest                      = [0.001 0.025:0.025:0.5];
intercept_prob_SD_d0p10     = zeros(1, length(e_dest));
intercept_prob_SD_d0p10_N25 = zeros(1, length(e_dest));
intercept_prob_SD_d0p10_N27 = zeros(1, length(e_dest));
intercept_prob_SD_d0p10_N29 = zeros(1, length(e_dest));
    
for idx = 1:length(e_dest)
    
    intercept_prob_SD_d0p10(idx) = ...
        sum(success_at_eavesdropper_for_tx_packets(idx, 1:N_values_theory(1, idx))) / experiments;
    
    intercept_prob_SD_d0p10_N25(idx) = ...
        sum(success_at_eavesdropper_for_tx_packets(idx, 1:25)) / experiments;

    intercept_prob_SD_d0p10_N27(idx) = ...
        sum(success_at_eavesdropper_for_tx_packets(idx, 1:27)) / experiments;    

    intercept_prob_SD_d0p10_N29(idx) = ...
        sum(success_at_eavesdropper_for_tx_packets(idx, 1:29)) / experiments;        
    
end
    
% ------------------------- PLOTS -------------------------

str_colour = 'kbrgm';
str_marker = 'x+.os';
str_type   = {'-', '--', '-.', '-', '--', '-.'};

% Create figure
figure1 = figure('InvertHardcopy','off','Color',[1 1 1]);
axes1 = axes('Parent',figure1,...
    'Position',[0.0952380952380952 0.11 0.882142857142856 0.217195467422096],...
    'FontSize',12);
ylim(axes1,[0 1]);
set(axes1,'ytick',0:0.2:1)
xlim(axes1,[0 0.5]);
set(axes1,'xtick',0:0.05:0.5)
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'all');

% --- PLOT THE DECODING PROBABILITY ---

probability_at_the_destination_N25 = zeros(1, length(e_dest));
probability_at_the_destination_N27 = zeros(1, length(e_dest));
probability_at_the_destination_N29 = zeros(1, length(e_dest));

for idx = 1:length(e_dest)

    probability_at_the_destination_N25(idx) = func_cdf(K, 25, e_dest(idx));
    probability_at_the_destination_N27(idx) = func_cdf(K, 27, e_dest(idx));
    probability_at_the_destination_N29(idx) = func_cdf(K, 29, e_dest(idx)); 
    
end

plot(e_dest, probability_at_the_destination_N25, 'r-')
plot(e_dest, probability_at_the_destination_N27, 'r--')
plot(e_dest, probability_at_the_destination_N29, 'r-.')

% ---

% Create ylabel
ylabel('$P_\mathrm{dec}$',...
       'Interpreter','latex','FontSize',13);

% Create xlabel
xlabel('Packet erasure probability at the destination, $\varepsilon_\mathrm{D}$',...
       'Interpreter','latex','FontSize',12);   
   
% Create axes
axes2 = axes('Parent',figure1,...
    'Position',[0.0952380952380952 0.453 0.882142857142856 0.532847699986517],...
    'FontSize',12);
%xlim(axes2,[K_size(1) K_size(end)]);
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

plot(e_dest, intercept_prob_SD_d0p00_N25, 'b-');
plot(e_dest, intercept_prob_SD_d0p00_N27, 'b--');
plot(e_dest, intercept_prob_SD_d0p00_N29, 'b-.');
%plot(e_dest, intercept_prob_SD_d0p00, 'b--');

plot(e_dest, intercept_prob_SD_d0p05_N25, 'm-');
plot(e_dest, intercept_prob_SD_d0p05_N27, 'm--');
plot(e_dest, intercept_prob_SD_d0p05_N29, 'm-.');
%plot(e_dest, intercept_prob_SD_d0p05, 'm--');

plot(e_dest, intercept_prob_SD_d0p10_N25, 'k-');
plot(e_dest, intercept_prob_SD_d0p10_N27, 'k--');
plot(e_dest, intercept_prob_SD_d0p10_N29, 'k-.');
%plot(e_dest, intercept_prob_SD_d0p10, 'k--');

% Create ylabel
ylabel('Intercept probability, $P_\mathrm{int}$','Interpreter','latex','FontSize',12);

% Create xlabel
xlabel('Packet erasure probability at the destination, $\varepsilon_\mathrm{D}$',...
       'Interpreter','latex','FontSize',12);

% Create textbox
annotation(figure1,'textbox',...
    [0.704166666666666 0.153968834077366 0.169940367199126 0.0696343405258107],...
    'String',{'$N_\mathrm{max}=25$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',12,...
    'FitBoxToText','off');

% Create textbox
annotation(figure1,'textbox',...
    [0.704166666666666 0.198413278521809 0.169940367199126 0.0696343405258107],...
    'String',{'$N_\mathrm{max}=27$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',12,...
    'FitBoxToText','off');

% Create textbox
annotation(figure1,'textbox',...
    [0.704166666666666 0.245238675347208 0.169940367199126 0.0696343405258109],...
    'String',{'$N_\mathrm{max}=29$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',12,...
    'FitBoxToText','off');

% Create arrow
annotation(figure1,'arrow',[0.710714285714286 0.603571428571429],...
    [0.287301587301587 0.212698412698413],'HeadWidth',6,'HeadLength',6);

% Create arrow
annotation(figure1,'arrow',[0.713095238095238 0.628571428571429],...
    [0.196825396825397 0.131746031746032],'HeadWidth',6,'HeadLength',6);

% Create arrow
annotation(figure1,'arrow',[0.708333333333333 0.608333333333333],...
    [0.241269841269841 0.168253968253968],'HeadWidth',6,'HeadLength',6);

% Create text
text('Parent',axes2,'FontSize',12,'Rotation',-16,'Interpreter','latex',...
    'String','$N_\mathrm{max}=29$',...
    'Position',[0.405263157894737 0.864880952380952 0]);

% Create text
text('Parent',axes2,'FontSize',12,'Rotation',-23,'Interpreter','latex',...
    'String','$N_\mathrm{max}=27$',...
    'Position',[0.405263157894737 0.582738095238095 0]);

% Create text
text('Parent',axes2,'FontSize',12,'Rotation',-16,'Interpreter','latex',...
    'String','$N_\mathrm{max}=25$',...
    'Position',[0.405263157894737 0.206845238095238 0]);

% Create ellipse
annotation(figure1,'ellipse',...
    [0.789095238095237 0.474603174603175 0.0216190476190475 0.0746031746031753]);

% Create ellipse
annotation(figure1,'ellipse',...
    [0.789095238095237 0.63015873015873 0.0216190476190475 0.120634920634922]);

% Create ellipse
annotation(figure1,'ellipse',...
    [0.789095238095237 0.803174603174605 0.0216190476190475 0.0888888888888875]);

% Create textbox
annotation(figure1,'textbox',...
    [0.187499999999999 0.770746031443283 0.138154474894206 0.0695238098265633],...
    'String',{'$\varepsilon_\mathrm{E}=\varepsilon_\mathrm{D}$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',12,...
    'FitBoxToText','off');

% Create textbox
annotation(figure1,'textbox',...
    [0.221428571428571 0.54693650763376 0.190535763331822 0.0695238098265635],...
    'String',{'$\varepsilon_\mathrm{E}\!=\!\varepsilon_\mathrm{D}\!+\!0.1$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',12,...
    'FitBoxToText','off');

% Create textbox
annotation(figure1,'textbox',...
    [0.10297619047619 0.685825396522648 0.204821523030599 0.0695238098265633],...
    'String',{'$\varepsilon_\mathrm{E}\!=\!\varepsilon_\mathrm{D}\!+\!0.05$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',12,...
    'FitBoxToText','off');

% Create ellipse
annotation(figure1,'ellipse',...
    [0.277785714285713 0.673015873015873 0.0216190476190475 0.0428571428571443]);

% Create ellipse
annotation(figure1,'ellipse',...
    [0.277785714285713 0.611904761904764 0.0216190476190474 0.0476190476190478]);

% Create ellipse
annotation(figure1,'ellipse',...
    [0.277785714285713 0.75 0.0216190476190475 0.0317460317460319]);