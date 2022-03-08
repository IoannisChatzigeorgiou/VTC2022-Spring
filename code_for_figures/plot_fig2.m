% --------------------------------------------------------------------
% This script plots Figure 2 of the paper:
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

load(['fig2_data',filesep,'data_RLC_only',filesep,'data_RLC_K20_0p1.mat']);
intercept_prob_0p1 = intercept_prob;
theory_0p1 = func_intercept_prob(20, 70, 0.01:0.01:0.1, 0.1);

load(['fig2_data',filesep,'data_RLC_only',filesep,'data_RLC_K20_0p15.mat']);
intercept_prob_0p15 = intercept_prob;
theory_0p15 = func_intercept_prob(20, 70, 0.01:0.01:0.1, 0.15);

load(['fig2_data',filesep,'data_RLC_only',filesep,'data_RLC_K20_0p2.mat']);
intercept_prob_0p2 = intercept_prob;
theory_0p2 = func_intercept_prob(20, 70, 0.01:0.01:0.1, 0.2);

load(['fig2_data',filesep,'data_RLC_SD',filesep,'data_RLC_SD_K20_L128_0p1.mat']);
intercept_prob_L128_0p1 = intercept_prob;

load(['fig2_data',filesep,'data_RLC_SD',filesep,'data_RLC_SD_K20_L128_0p15.mat']);
intercept_prob_L128_0p15 = intercept_prob;

load(['fig2_data',filesep,'data_RLC_SD',filesep,'data_RLC_SD_K20_L128_0p2.mat']);
intercept_prob_L128_0p2 = intercept_prob;

warning on

% Create figure
figure1 = figure('InvertHardcopy','off','Color',[1 1 1]);

% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.0886904761904762 0.103968253968254 0.893309523809523 0.87303174603176],...
    'FontSize',11);

xlim(axes1,[0.01 0.1]);
ylim(axes1,[0 1]);

hold(axes1,'on');

% dummy plot
plot(-1, -1, 'k-');
plot(-1, -1, 'kx');
plot(-1, -1, 'b--');

% Simulations (RLC without SD)
plot(0.01:0.01:0.1, intercept_prob_0p1, 'k-');
plot(0.01:0.01:0.1, intercept_prob_0p15, 'k-');
plot(0.01:0.01:0.1, intercept_prob_0p2, 'k-');

% Theory (RLC without SD)
plot(0.01:0.01:0.1, theory_0p1, 'kx');
plot(0.01:0.01:0.1, theory_0p15, 'kx');
plot(0.01:0.01:0.1, theory_0p2, 'kx');

% Simulations (RLC with SD)
plot(0.01:0.01:0.1, intercept_prob_L128_0p1, 'b--');
plot(0.01:0.01:0.1, intercept_prob_L128_0p15, 'b--');
plot(0.01:0.01:0.1, intercept_prob_L128_0p2, 'b--');

% Create ylabel
ylabel('Intercept probability, $P_\mathrm{int}$','Interpreter','latex','FontSize',12);

% Create xlabel
xlabel('Packet erasure probability at the destination, $\varepsilon_\mathrm{D}$',...
       'Interpreter','latex','FontSize',12);

box(axes1,'on');
grid(axes1,'on');

% Set the remaining axes properties
set(axes1,'FontSize',11);
   
draw_leg = legend('RLC only (sim.)', 'RLC only (theory)', ...
                  'RLC with SD for $L=128$ (sim.)', ...
                  'Interpreter', 'latex', 'Location', 'NorthWest');              
              
draw_leg.FontSize = 11;

% Create ellipse
annotation(figure1,'ellipse',...
    [0.606357142857142 0.227777777777778 0.0251904761904768 0.0746031746031757]);

% Create ellipse
annotation(figure1,'ellipse',...
    [0.808738095238095 0.532539682539683 0.0120952380952382 0.0492063492063515]);

% Create textbox
annotation(figure1,'textbox',...
    [0.662499999999999 0.566777777475028 0.144632793608166 0.0695238098265633],...
    'String',{'$\varepsilon_\mathrm{E}=0.1$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',12);

% Create arrow
annotation(figure1,'arrow',[0.780357142857143 0.814880952380952],...
    [0.605555555555556 0.580158730158732],'HeadWidth',8,'HeadLength',8);

% Create ellipse
annotation(figure1,'ellipse',...
    [0.698023809523808 0.354761904761906 0.0192380952380953 0.0619047619047629]);

% Create textbox
annotation(figure1,'textbox',...
    [0.532738095238093 0.384238094935345 0.158918553306943 0.0695238098265633],...
    'String',{'$\varepsilon_\mathrm{E}=0.15$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',12);

% Create arrow
annotation(figure1,'arrow',[0.664880952380952 0.705357142857143],...
    [0.427777777777778 0.416666666666667],'HeadWidth',8,'HeadLength',8);

% Create textbox
annotation(figure1,'textbox',...
    [0.458928571428569 0.12709523779249 0.144632793608166 0.0695238098265633],...
    'String',{'$\varepsilon_\mathrm{E}=0.2$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',12);

% Create arrow
annotation(figure1,'arrow',[0.581547619047619 0.618452380952381],...
    [0.170634920634921 0.226190476190476],'HeadWidth',8,'HeadLength',8);
