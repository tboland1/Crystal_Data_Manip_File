%% IMPORTPOSCAR: This file is called by callfunctions to import all the 
% from the POSCAR. 
%% All data from the POSCAR is parsed up in this file.
	% a1 a2 a3 are the bravais lattice vectors
	% a b c are the basis vectors
	% headline tells you if you have a specified atomic basis
	% data1 contains all array data
	% header contains the header parsed out structure array data
    % 65 lines

%% IMPORT DATA FUNCTION
function [basis,lattice,header] = importPOSCAR
% set up the import variables

% catch filename input error
count=0;
err_count=0;
while count == err_count;
	try
        filename = input( 'Import POSCAR function. What is the file name: ' );
    catch
		disp('Error with file name input. Try again.');
		err_count = err_count+1;
		filename = input( 'Import POSCAR function: What is the file name: ' );
	end
	count = count+1;
end
%% Start IMPORT DATA calling
delim=' ';
% catch headline error. no user input
try
    headline = 7;
    data1 = importdata(filename,delim,headline);
    % define the a b c ATOMIC BASIS VECTORS
    a = data1.data(:,1); b = data1.data(:,2); c = data1.data(:,3);
catch
    headline = 8;
    data1 = importdata(filename,delim,headline);
    % define the a b c ATOMIC BASIS VECTORS
    a = data1.data(:,1); b = data1.data(:,2); c = data1.data(:,3);
end
%% PARTITION BRAVIS LATTICE VECTORS
% writing now
a1p=cell2split(data1.textdata{3});
a2p=cell2split(data1.textdata{4});
a3p=cell2split(data1.textdata{5});
% basis vectors in the right arrangement
a1 = [a1p(1),a1p(2),a1p(3)]; 
a2 = [a2p(1),a2p(2),a2p(3)]; 
a3 = [a3p(1),a3p(2),a3p(3)];
if headline == 8
	sysTag={cell2split(data1.textdata{1})};
	univScaling=str2num(data1.textdata{2});
	atomicElements=arrayManipulation(data1.textdata{6}); 
	atomCount=arrayManipulation(data1.textdata{7});
	spaceCoor=strtrim(data1.textdata{8});
	header={sysTag,univScaling,atomCount,spaceCoor,atomicElements};
else
	sysTag={cell2split(data1.textdata{1})};
	univScaling=str2num(data1.textdata{2});
	atomCount=arrayManipulation(data1.textdata{7});
	spaceCoor=strtrim(data1.textdata{8});
	header={sysTag,univScaling,atomCount,spaceCoor};
end
basis={a,b,c};
lattice={a1,a2,a3};
end
 
