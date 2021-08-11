% Basic example of spectral fitting using EasySpin
%====================================================================

% Be sure to get an approximate fit with the manual code before running the
% automatic one.

[BG,spc]=eprload('FileName.DTA');

Exp.mwFreq=9.682776;
Exp.CenterSweep=[310 200];
Exp.nPoints=1024;
Exp.Harmonic=1;
Exp.ModAmp=0.4;
Exp.Temperature=80;

% First Component
Sys1.S=1/2;
Sys1.Nucs='Cu';
Sys1.g=[2.05862 2.27568];
Sys1.A=[21.7925 521.475];
Sys1.weight=.5;
Sys1.HStrain=[92.9825 104.153];
Sys1.lwpp=[4.33556 0.156786];

% These values represent the range around the above values in which you 
% want the simulation to search. Careful that the ranges do not allow the
% simulation to become negative, otherwise the simulation may break.
Vary1.g = [0.03 0.03];
Vary1.A = [10 100];
Vary1.HStrain=[100 100];
Vary1.lwpp=[3 2];
Vary1.weight=.0;

% Second Component
Sys2.S=1/2;
Sys2.Nucs='Cu';
Sys2.g=[2.1 2.3321];
Sys2.A=[31.7425 576.416];
Sys2.weight=0.0;
Sys2.HStrain=[200.1 200.1];
Sys2.lwpp=[3.1 2.1];

Vary2.g = [0. 0.0];
Vary2.A = [0 0];
Vary2.HStrain=[00 00];
Vary2.lwpp=[0 0];
Vary2.weight=.0;

% Third Component
Sys3.S=1/2;
Sys3.Nucs='Cu';
Sys3.g=[2.1 2.3321];
Sys3.A=[31.7425 576.416];
Sys3.weight=0.0;
Sys3.HStrain=[200.1 200.1];
Sys3.lwpp=[3.1 2.1];

Vary3.g = [0. 0.0];
Vary3.A = [0 0];
Vary3.HStrain=[00 00];
Vary3.lwpp=[0 0];
Vary3.weight=.0;


%% This section will perform the automatic simulation.

SimOpt.Method = 'perturb';
FitOpt.Method = 'levmar fcn';
FitOpt.Scaling = 'maxabs';

esfit('pepper',spc,{Sys1,Sys2,Sys3},{Vary1,Vary2,Vary3},Exp,SimOpt,FitOpt);