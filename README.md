This repository contains the MATLAB code that was used to run simulations and obtain the results that are presented in figures 2, 3 and 4 of the paper:
"The Impact of Partial Packet Recovery on the Inherent Secrecy of Random Linear Coding" by Ioannis Chatzigeorgiou, which will appear (or has appeared) in the Proceedings of the 95th IEEE Vehicular Technology Conference (IEEE VTC 2022 - Spring, Helsinki, Finland, 19-22 June 2022).

Content created by:
Ioannis Chatzigeorgiou, Lancaster University, United Kingdom

## Reproduce the figures using the available simulation data

To plot fig. 2, fig. 3 or fig. 4 of the paper, set the folder "code_for_figures" as the Current Folder in MATLAB and run `plot_fig2`, `plot_fig3` or `plot_fig4` in the Command Window to obtain the relevant figure. The simulation results stored in the sub-folders "fig2_data" and "fig3_and_fig4_data" will be used to reproduce the three figures of Section VI in the paper. 

Note that the scripts `plot_fig3` and `plot_fig4` re-define the variable `target_decoding_prob` (see line 27 of `plot_fig3` and line 22 of `plot_fig4`). This forces the scripts to plot the curves shown in fig. 3 and fig. 4 of the paper. If you wish to plot the curves for all considered values of target_decoding_prob, then:
- Comment out line 27 of `plot_fig3` and line 22 of `plot_fig4`.
- Change line 25 of `plot_fig3` and line 20 of `plot_fig4` from `clear e_dest K target_decoding_prob` to `clear e_dest K`.

## Re-run the simulations to obtain the data needed for fig. 2

If you do not want to use the readily available simulation results but you prefer to re-run the simulations in order to obtain the results shown in fig. 2, set the folder "code_for_simulations" as the Current Folder in MATLAB. Then run `run_simulations_for_fig2` in the Command Window.

A simulation, either for Random Linear Coding (RLC only) or for RLC with Syndrome Decoding (RLC with SD), runs 60,000 experiments. If you wish to increase or reduce this value, edit the MATLAB files "sim_intercept_RLC_only_for_fig2.m" (modify line 37) and "sim_intercept_RLC_with_SD_for_fig2.m" (modify line 39).

When the simulations are completed, the following six files will be created in the folder "code_for_simulations" (assuming that the file "run_simulations_for_fig2" has not been edited):
- data_RLC_K20_0p1.mat
- data_RLC_K20_0p15.mat
- data_RLC_K20_0p2.mat
- data_RLC_SD_K20_L128_0p1.mat
- data_RLC_SD_K20_L128_0p15.mat
- data_RLC_SD_K20_L128_0p2.mat

Move the top three files to the folder "code_for_figures\fig2_data\data_RLC_only". Similarly, move the bottom three files to the folder "code_for_figures\fig2_data\data_RLC_SD". The existing files will be overwritten. To plot fig. 2, follow the instructions in Section 1 above.

## Re-run the simulations to obtain the data needed for fig. 3 and fig. 4

If you do not want to use the readily available simulation results but you prefer to re-run the simulations in order to obtain the results shown in fig. 3 *and* fig. 4, set the folder "code_for_simulations" as the Current Folder in MATLAB. Then run `run_simulations_for_fig3` in the Command Window.

The script "run_simulations_for_fig3" is divided into three parts:

- Part 1 runs the simulations that obtain probability distributions when Random Linear Coding (RLC only) and when RLC with Syndrome Decoding (RLC with SD) are used. Each simulation runs 80,000 experiments. If you wish to increase or reduce this value, please edit the MATLAB files "sim_RLC_only_for_fig3.m" (modify line 36) and "sim_RLC_with_SD_for_fig3.m" (modify line 36). When the simulations are completed, the following six files will be created in the folder "code_for_simulations" (assuming that the file "run_simulations_for_fig3" has not been edited):
  - data_RLC_K20_0p1.mat
  - data_RLC_K20_0p15.mat
  - data_RLC_K20_0p2.mat
  - data_RLC_SD_K20_L128_0p1.mat
  - data_RLC_SD_K20_L128_0p15.mat
  - data_RLC_SD_K20_L128_0p2.mat

- Part 2 uses the theoretical expressions of the paper to compute the required value of N_max for a target decoding probability and a given packet error probability at the destination. The target decoding proability has been set to 0.99. If you wish to modify it, edit line 35 of the script "run_simulations_for_fig3". Part 2 will generate the file:
  - theory_RLC_K20_N_values_lowres.mat

- The files created by the execution of Part 1 and Part 2 are needed for the generation of the top plot of fig. 3 and both plots of fig. 4. For the generation of the bottom plot of fig. 3, the step of the packet error probability at the destination should be small (e.g. 0.001) to improve the resolution of the plot. Part 3 will generate the file:
  - theory_RLC_K20_N_values_highres.mat

When execution of "run_simulations_for_fig3" has been completed, move the following five files:
- data_RLC_K20_0p1.mat
- data_RLC_K20_0p15.mat
- data_RLC_K20_0p2.mat
- theory_RLC_K20_N_values_lowres.mat
- theory_RLC_K20_N_values_highres.mat

to the folder "code_for_figures\fig3_and_fig4_data\data_RLC_only". Similarly, move the following three files:
- data_RLC_SD_K20_L128_0p1.mat
- data_RLC_SD_K20_L128_0p15.mat
- data_RLC_SD_K20_L128_0p2.mat

to the folder "code_for_figures\fig3_and_fig4_data\data_RLC_SD". The existing files will be overwritten. To plot fig. 3 and fig. 4 follow the instructions in Section 1 above.
