%% MAIN CALLING SCRIPT
% functions which go alone with this in the order they are used:
% importPOSCAR.m w/in cell2split.m arrayManipulation.m
% 
% exportCrystalData.m 
% shiftbyX.m 
% 21 lines
clear all
close all
clc
fprintf(strcat('Welcome to Crystal Data Manipulation Program. This program\n',...
    'executes from any directory but can only access the files of the\n',...
    'present directory. Make sure you have the files you wish to access\n',...
    'present in pwd.\n'))
% Import the poscar you want
[basis,lattice,header] = importPOSCAR;

%% Call the Data manipulation function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[tagline,an,bn,cn,a1n,a2n,a3n,atoms,tag,FEFF,basisShift] = shiftbyX(basis,lattice,header);
%tagline tells you the number of the element. Resets at 1 for each element.

%% Export Data Options
fprintf('VESTA cannot read files with tag line in them. Keep this in mind when exporting data.');
fprintf('Export Options for export file? \nTag lines: 1 \nNo Taglines: 2 \nExport w/ & w/o Taglines: 3 \nExport FEFF: 4')
exportOption = input('Export Options for export file? (1 yes, 2 no, 3 both) ');
exportCrystalData(exportOption,tagline,an,bn,cn,a1n,a2n,a3n,atoms,tag,FEFF,basisShift,header);






