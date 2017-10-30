%% Export data funciton
% This function will export the data for crystal manipuation scripts.
% 169
function exportCrystalData(exportOption,tagline,an,bn,cn,a1n,a2n,a3n,atoms,tag,FEFF,basisShift,header)
%% EXPORT THE DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% parse the data output
%%

if exportOption == 1
    ar = an';
    br = bn';
    cr = cn';
    tagliner1 = {};
    tagliner2 ={};
    for c = 1:length(88)
        tagliner1{c}='O';
    end
    for p = 1:length(48)
        tagliner2{p}='Ce';
    end
    databasis1 = [ar(1:88);br(1:88);cr(1:88)]; % column horz cat
    databasis2 = [ar(89:136);br(89:136);cr(89:136)];
    databasis = [databasis1;databasis2];
    datalattice = [ a1n ; a2n ; a3n ]; % row vert cat

    if tag == 0
        atomicScale = data1.textdata{2}; 
        atomicNumbers = header{3};
    else
        atomicNumbers = atoms;
        atomicScale = data1.textdata{2};
    end
    atomicNumbers1 = atomicNumbers(1);
    atomicNumbers2 = atomicNumbers(2);
    %% Ask the name of the file
    fileout = input( 'Name the manipulated data file ');
    %Return output in file form
    ExDatManip = fopen(fileout,'w');
    % header
    fprintf(ExDatManip, [' CeO2 \n' '       ' atomicScale '\n ']);
    % the bravais lattice vectors
    fprintf(ExDatManip, '       %4.6f   %4.6f  %4.6f \n', [datalattice]);
    % add in the number of atoms
    if tag == 1
        fprintf(ExDatManip, '%4.0f %4.0f \n', [atomicNumbers1 atomicNumbers2]);
    end
    if tag == 0
        fprintf(ExDatManip, [atomicNumbers '\n'])
    end
    % add the lattice type
    fprintf(ExDatManip, ['Direct \n']);
    % the atomic basis vectors
    fprintf(ExDatManip, '%4d %4.6f %4.6f %4.6f \n', [tagliner1 databasis1]);
    fprintf(ExDatManip, '%4d %4.6f %4.6f %4.6f \n', [tagliner2 databasis2]);
    fclose(ExDatManip);
elseif exportOption == 2;
    ar = an';
    br = bn';
    cr = cn';
    databasis = [ar;br;cr]; % column horz cat
    datalattice = [ a1n ; a2n ; a3n ]; % row vert cat

    if tag == 0
        atomicScale = header{2}; 
        atomicNumbers = header{3};
    else
        atomicNumbers = atoms;
        %atomicScale = data1.textdata{2};
    end
    atomicNumbers1 = atomicNumbers(1);
    atomicNumbers2 = atomicNumbers(2);
    %% Ask the name of the file
    fileout = input( 'Name the manipulated data file \n');
    %Return output in file form
    ExDatManip = fopen(fileout,'w');
    % header
    fprintf(ExDatManip, [' CeO2 \n' '       ' atomicScale '\n ']);
    % the bravais lattice vectors
    fprintf(ExDatManip, '      %4.6f   %4.6f  %4.6f \n', [datalattice]);
    % add in the number of atoms
%     if tag == 1
%         fprintf(ExDatManip, '%4.0f %4.0f \n', [atomicNumbers1 atomicNumbers2]);
%     end
%     if tag == 0
%         fprintf(ExDatManip, [atomicNumbers '\n'])
%     end
    % add the lattice type
    fprintf(ExDatManip, ['Direct \n']);
    % the atomic basis vectors
    fprintf(ExDatManip, '%4.6f %4.6f %4.6f \n', [databasis]);
    fclose(ExDatManip);
elseif exportOption == 3
    %% EXPORT THE FIRST POSCAR DATA SET
    ar = an';
    br = bn';
    cr = cn';
    tagliner = tagline';
    databasis = [tagliner;ar;br;cr]; % column horz cat
    datalattice = [ a1n ; a2n ; a3n ]; % row vert cat

    if tag == 0
        atomicScale = data1.textdata{2}; 
        atomicNumbers = data1.textdata{headline - 1};
    else
        atomicNumbers = atoms;
        atomicScale = data1.textdata{2};
    end
    atomicNumbers1 = atomicNumbers(1);
    atomicNumbers2 = atomicNumbers(2);
    %% Ask the name of the file
    fileout = input( 'Name the manipulated data file \n');
    %Return output in file form
    ExDatManip = fopen(fileout,'w');
    % header
    fprintf(ExDatManip, [' CeO2 \n' '       ' atomicScale '\n ']);
    % the bravais lattice vectors
    fprintf(ExDatManip, '      %4.6f   %4.6f  %4.6f \n', [datalattice]);
    % add in the number of atoms
    if tag == 1
        fprintf(ExDatManip, '%4.0f %4.0f \n', [atomicNumbers1 atomicNumbers2]);
    end
    if tag == 0
        fprintf(ExDatManip, [atomicNumbers '\n'])
    end
    % add the lattice type
    fprintf(ExDatManip, ['Direct \n']);
    % the atomic basis vectors
    fprintf(ExDatManip, '% 4d  %4.6f %4.6f %4.6f \n', [databasis]);
    fclose(ExDatManip);
    
    
    %% Export the second file without the tag lines
    ar = an';
    br = bn';
    cr = cn';
    databasis = [ar;br;cr]; % column horz cat
    datalattice = [ a1n ; a2n ; a3n ]; % row vert cat

    if tag == 0
        atomicScale = data1.textdata{2}; 
        atomicNumbers = data1.textdata{headline - 1};
    else
        atomicNumbers = atoms;
        atomicScale = data1.textdata{2};
    end
    atomicNumbers1 = atomicNumbers(1);
    atomicNumbers2 = atomicNumbers(2);
    
    %% MAKE THE SECOND EXPORT DATA FILE with no tag lines
    fileout2 = strcat( fileout,'no_AtomNumID');
    %Return output in file form
    ExDatManip = fopen(fileout2,'w');
    % header
    fprintf(ExDatManip, [' CeO2 \n' '       ' atomicScale '\n ']);
    % the bravais lattice vectors
    fprintf(ExDatManip, '      %4.6f   %4.6f  %4.6f \n', [datalattice]);
    % add in the number of atoms
    if tag == 1
        fprintf(ExDatManip, '%4.0f %4.0f \n', [atomicNumbers1 atomicNumbers2]);
    end
    if tag == 0
        fprintf(ExDatManip, [atomicNumbers '\n'])
    end
    % add the lattice type
    fprintf(ExDatManip, ['Direct \n']);
    % the atomic basis vectors
    fprintf(ExDatManip, '%4.6f %4.6f %4.6f \n', [databasis]);
    fclose(ExDatManip);

    
    
    
elseif exportOption == 4
    atom=FEFF{1};                   % partition out atom from FEFF cell array
    atomID=FEFF{2};                 % partition out atomID from FEFF cell array
    cells = {atom,an,bn,cn,atomID}; % combine with atom basis
    %% Ask the name of the file
    fileout = input( 'Name the manipulated data file. \n');
    %Return output in file form
    fileID = fopen(fileout,'w');        % open the file
    for i=1:length(cells{1})            % loop over every line of the cell array & print
        fprintf(fileID,'%s %10.6f %4.6f %4.6f %s \n', [cells{1}{i}],[cells{2}(i),cells{3}(i),cells{4}(i)],[cells{5}{i}]);
    end
    fclose(fileID);                     % close the file
elseif exportOption == 5                 
    %% Ask the name of the file
    fileout = input( 'Name the manipulated data file. \n');
    %Return output in file form
    fileID = fopen(fileout,'w');        % open the file
    % for the 2 cases of textdata
    if length(header)==5
        fprintf(fileID, '%s \n',[char(header{1}{1})]);  % system string
        fprintf(fileID, '%4.7f \n',[header{2}]);        % universal scaling factor
        fprintf(fileID, '%4.8f %4.8f %4.8f \n',[str2num(a1n{1}),str2num(a1n{2}),str2num(a1n{3})]);
        fprintf(fileID, '%4.8f %4.8f %4.8f \n',[str2num(a2n{1}),str2num(a2n{2}),str2num(a2n{3})]);
        fprintf(fileID, '%4.8f %4.8f %4.8f \n',[str2num(a3n{1}),str2num(a3n{2}),str2num(a3n{3})]);
        for i=1:length(header{3})                       % atomic element IDs
            fprintf(fileID, '%s %s %s',['  ',header{5}{i},'  ']);
        end
        fprintf(fileID,'\n');
        for i=1:length(header{3})                       % number of each element
            fprintf(fileID, '%5.0f ',[header{3}{i}]);   
        end
        fprintf(fileID,'\n');
        fprintf(fileID, '%5s \n',[header{4}]);          % the coordinate system you are in

    elseif length(header)==4
        fprintf(fileID, '%s \n',[char(header{1}{1})]);  % system string
        fprintf(fileID, '%4.7f \n',[header{2}]);        % universal scaling factor
        fprintf(fileID, '%4.8f %4.8f %4.8f \n',[str2num(a1n{1}),str2num(a1n{2}),str2num(a1n{3})]);
        fprintf(fileID, '%4.8f %4.8f %4.8f \n',[str2num(a2n{1}),str2num(a2n{2}),str2num(a2n{3})]);
        fprintf(fileID, '%4.8f %4.8f %4.8f \n',[str2num(a3n{1}),str2num(a3n{2}),str2num(a3n{3})]);
        for i=1:length(header{3})                       % number of each element
            fprintf(fileID, '%7.5f ',[header{3}{i}]);   
        end
        fprintf(fileID,'\n');
        fprintf(fileID, '%5s \n',[header{4}]);          % the coordinate system you are in
    end
    % for the basis
    for i=1:length(basisShift{1})            % loop over every line of the cell array & print
        fprintf(fileID,'%4.6f %4.6f %4.6f \n', [basisShift{1}(i,1),basisShift{1}(i,2),basisShift{1}(i,3)]);
    end
    fclose(fileID);                     % close the file
end


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    