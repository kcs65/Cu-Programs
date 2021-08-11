% Sections marked by the green % are notes that describe what each line of
% code represents, or explains what step needs to run the simulation
% smoothly. The x-axis of the CW-EPR spectra should be in Gauss. If spectra
% are in mT, then lines 77 and 84 in the last section will need 
% to be changed to include the factor of 10.

% Make sure that this code is in the easyspin folder.

%% Input experimental spectrum and parameters

% transfer .DTA and .DSC file into easyspin folder;

% Enter the filename for the EPR data
[BG,spc]=eprload('FileName.DTA');

% Experimental Parameters
    % Microwave Freq in GHz
Exp.mwFreq=9.677632;
    % Center and Sweep Width in mT
Exp.CenterSweep=[310 200];
    % Number of Points
Exp.nPoints=1024;
    % Harmonic, Keep at 1. This means we're simulating the first derivative
Exp.Harmonic=1;
    % Modulation Amplitude in mT
Exp.ModAmp=0.4;
    % Temperature in K
Exp.Temperature=80;

%% Parameters to simulate the EPR spectrum.
% This code includes parameters for a three component fit, labeled Sys1, 
% Sys2, and Sys3. If you want to simulate a component with one component, 
% then set the weight of component two and three to equal 0.

% First Component
    % Electron Spin
Sys1.S=1/2;
    % Nucleus electron is coordinated
Sys1.Nucs='Cu';    
    % [g_perpendicular g_parallel]
Sys1.g=[2.08 2.425];
    % [A_perpendicular A_parallel] This is in MHz. See the end of the code
    % for information on how to convert from Gauss to MHz.
Sys1.A=[20 500]; 
    % Weight of Component 1. Note that the weights do not need to add up 
    % to 1. The program will renormalize everything automatically.
Sys1.weight=.63;
    % Line Broadening parameters. HStrain broadens the energy levels. 
    % lwpp broadens the peak-to-peak linewidth.
Sys1.HStrain=[155 110];
Sys1.lwpp=[3.3355 0.7567];

% Second Component
Sys2.S=1/2;
Sys2.Nucs='Cu';
Sys2.g=[2 2.3];
Sys2.A=[0 0];
Sys2.weight=0;
Sys2.HStrain=[1 1];
Sys2.lwpp=[1 1];

% Third Component
Sys3.S=1/2;
Sys3.Nucs='Cu';
Sys3.g=[2 2.3];
Sys3.A=[0 0];
Sys3.weight=0;
Sys3.HStrain=[1 1];
Sys3.lwpp=[1 1];

% After running the code, save the simulation by typing 
% xlswrite('filename',Sim) in the commmand window

%% Everything below remains as is, this will plot the simulation

[Field,Spec]=pepper({Sys1,Sys2,Sys3},Exp);
B=BG/10;
Spectrap=cumtrapz(Spec);
Spectrapz=trapz(Spectrap);
plot(Field,Spec/max(Spec),'k--',B,spc/max(spc(1:700)),'r');
axis([min(B) max(B) min(spc/max(spc(1:700))) 1])
legend('Simulation','Experimental');
xlabel('Field (mT)');
Fields=Field(:)*10;
Sim=[Fields(:) Spec(:)];
AG1=mhz2mt(Sys1.A,Sys1.g)*10;AG2=mhz2mt(Sys2.A,Sys2.g)*10;
AG3=mhz2mt(Sys3.A,Sys3.g)*10;

%% Some useful lines of code

% If convert hyperfine values to Gauss, type AG1, AG2, or AG3 after running
% the simulation.

% To manually convert the hyperfine units from Gauss to MHz, type
% "mt2mhz([A_perp A_para],[g_perp g_para])/10" in the command window

