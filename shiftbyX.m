function [atomsTAG,a,b,c,a1,a2,a3,atoms,tag,FEFF,basisShift,header] = shiftbyX(basis,lattice,header)
%%   atomsTAG
    % basis ---->       a=basis(1) b=basis(2) c=basis(3)  the atomic basis
    % lattice -->       a1 a2 a3                the bravais lattice vectors
    % atoms             is the number of atoms of each type. header{3}
    % atom              FEFF atom type variable
    % atomID            FEFF atom number variable
    % header            sysTag (system ID,string name), univScaling (universal
    %                   scaling factor, atomCount(amount of each type of element)
    %                   spaceCoor (direct or cart), if applicable
    %                   atomicElements (the atom type for each element in
    %                   system.
    % 543 lines ~700 lines
%% This function is for data manipulation code only. Calling it puts you 
% into a loop where you can manipulate the heck out of the atomic data in
% succession . . . Hopefully.
%
%% Parse the data from being condensed 
a=basis{1}; 
b=basis{2};
c=basis{3};
a2=[];a1=[];a3=[];
for i=1:length(lattice{1})
    a1(i)=str2num(lattice{1}{i});
end
for i=1:length(lattice{1})
    a2(i)=str2num(lattice{2}{i});
end
for i=1:length(lattice{1})
    a3(i)=str2num(lattice{3}{i});
end
atomsTAG=0;atoms=0;tag=0;atom=0;atomID=0;FEFF=0;basisShift=0;
disp('What would you like to do to the data? ');
disp(sprintf(strcat(['Shift basis by x (1) \nShift basis by y (2) \nShift basis by',...
    ' z (3) \nShrink the cell volume in X (4) \nShrink the cell volume in Z',...
    '(5) \nShrink the cell volume in Z (6) \nChange Cell Volume in X (7)',...
    '\nChange Cell Volume in Y (8) \nChange Cell Volume in Z (9) \nCombine',...
    '2 Supercells in X (10) \nAdd Atoms to POSCAR FEFF format (11) \nShift Layers (12) \n'])))
% Ask for information
% if headline1==8;
%     count=0;
%     err_count=0;
%     while count == err_count;
%         try
            do = input('Please select a number from the Menu ');
            %% El menu
            while ~isempty(do);
                if do == 1
                    x = input('What do you want to shift the cell by? (fractional coordinates x direction) ');
                    a = shiftbyX(x,a);
                elseif do == 2
                    x = input('What do you want to shift the cell by? (fractional coordinates y direction) ');
                    b = shiftbyY(x,b);
                elseif do == 3
                    x = input('What do you want to shift the cell by? (fractional coordinates z direction) ');
                    c = shiftbyZ(x,c);
                elseif do == 4
                    changeX = input('What do you want to shrink the cell by in X ? (enter value in A for x direction) ');
                    [a,a1] = cellShrinkX(changeX,a,a1);
                elseif do == 5
                    changeY = input('What do you want to shrink the cell by in Y? (enter value in A for y direction) ');
                    [b,a2] = cellShrinkY(changeY,b,a2); 
                elseif do == 6
                    changeZ = input('What do you want to shrink the cell by in Z? (enter value in A for z direction) ');
                    [c,a3] = cellShrinkZ(changeZ,c,a3);
                elseif do == 7
                    x = input('Change the cell by what length ( enter value in A for x direction) ' );
                    [a,a1] = cellChangeX(x,a,a1);
                elseif do == 8
                    x = input('Change the cell by what length ( enter value in A for y direction) ' );
                    [b,a2] = cellChangeY(x,b,a2);
                elseif do == 9
                    x = input('Change the cell by what length ( enter value in A for z direction) ' );
                    [c,a3] = cellChangeZ(x,c,a3);
                elseif do == 10
                    x = input('How much distance are you adding to the unit cell include the length of the unit cell in that(in Angstroms)? ');
                    [atomsTAG,a,b,c,a1,a2,a3,atoms,tag] = cellcombX(x,a,b,c,a1,a2,a3,header);
                elseif do == 11
                    [FEFF] = FEFFadd(header);
                elseif do == 12
                    disp('Please enter everything in quotes')
                    disp('')
                    layer=input('Which i-plane would you like shifted? (enter x, y, or z) ');
                    layerpull=input('What is the value of the layer you want to manipulate? (Direct coordinates) ');
                    layerShiftx=input('Enter a distance shifted x in fractional coordinates. ');
                    layerShifty=input('Enter a distance shifted y in fractional coordinates. ');
                    layerShiftz=input('Enter a distance shifted z in fractional coordinates. ');
                    [basisShift,header]=layerPull(a,b,c,layer,layerShiftx,layerShifty,layerShiftz,layerpull,header,basis);
                end
                do = input('What would you like to do now? (Press Enter to quit) ');
            end
% 
%             err_count=err_count+1;
%             disp('Enter a valid number')
%             do = input('Please select a number from the Menu ');
%             %% El menu
%             while ~isempty(do);
%                 if do == 1
%                     x = input('What do you want to shift the cell by? (fractional coordinates x direction) ');
%                     a = shiftbyX(x,a);
%                 elseif do == 2
%                     x = input('What do you want to shift the cell by? (fractional coordinates y direction) ');
%                     b = shiftbyY(x,b);
%                 elseif do == 3
%                     x = input('What do you want to shift the cell by? (fractional coordinates z direction) ');
%                     c = shiftbyZ(x,c);
%                 elseif do == 4
%                     changeX = input('What do you want to shrink the cell by in X ? (enter value in A for x direction) ');
%                     [a,a1] = cellShrinkX(changeX,a,a1);
%                 elseif do == 5
%                     changeY = input('What do you want to shrink the cell by in Y? (enter value in A for y direction) ');
%                     [b,a2] = cellShrinkY(changeY,b,a2);
%                 elseif do == 6
%                     changeZ = input('What do you want to shrink the cell by in Z? (enter value in A for z direction) ');
%                     [c,a3] = cellShrinkZ(changeZ,c,a3);
%                 elseif do == 7
%                     x = input('Change the cell by what length ( enter value in A for x direction) ' );
%                     [a,a1] = cellChangeX(x,a,a1);
%                 elseif do == 8
%                     x = input('Change the cell by what length ( enter value in A for y direction) ' );
%                     [b,a2] = cellChangeY(x,b,a2);
%                 elseif do == 9
%                     x = input('Change the cell by what length ( enter value in A for z direction) ' );
%                     [c,a3] = cellChangeZ(x,c,a3);
%                 elseif do == 10
%                     x = input('How much distance are you adding to the unit cell include the length of the unit cell in that(in Angstroms)? ');
%                     [atomsTAG,a,b,c,a1,a2,a3,atoms,tag] = cellcombX(x,a,b,c,a1,a2,a3,data1,headline1);
%                 elseif do ==11
%                     % takes the atomic basis and converts it to a FEFF format.
%                     [atom,atomID] = FEFFadd(header);
%                 end
%                 do = input('What would you like to do now? (Press Enter to quit) ');
%             end
%         end
%         count = count+1;
%     end
% else
%     count=0;
%     err_count=0;
%     while count == err_count;
%         try
%             do = input('Please select a number from the Menu ');
%             %% El menu
%             while ~isempty(do);
%                 if do == 1
%                     x = input('What do you want to shift the cell by? (fractional coordinates x direction) ');
%                     a = shiftbyX(x,a);
%                 elseif do == 2
%                     x = input('What do you want to shift the cell by? (fractional coordinates y direction) ');
%                     b = shiftbyY(x,b);
%                 elseif do == 3
%                     x = input('What do you want to shift the cell by? (fractional coordinates z direction) ');
%                     c = shiftbyZ(x,c);
%                 elseif do == 4
%                     changeX = input('What do you want to shrink the cell by in X ? (enter value in A for x direction) ');
%                     [a,a1] = cellShrinkX(changeX,a,a1);
%                 elseif do == 5
%                     changeY = input('What do you want to shrink the cell by in Y? (enter value in A for y direction) ');
%                     [b,a2] = cellShrinkY(changeY,b,a2);
%                 elseif do == 6
%                     changeZ = input('What do you want to shrink the cell by in Z? (enter value in A for z direction) ');
%                     [c,a3] = cellShrinkZ(changeZ,c,a3);
%                 elseif do == 7
%                     x = input('Change the cell by what length ( enter value in A for x direction) ' );
%                     [a,a1] = cellChangeX(x,a,a1);
%                 elseif do == 8
%                     x = input('Change the cell by what length ( enter value in A for y direction) ' );
%                     [b,a2] = cellChangeY(x,b,a2);
%                 elseif do == 9
%                     x = input('Change the cell by what length ( enter value in A for z direction) ' );
%                     [c,a3] = cellChangeZ(x,c,a3);
%                 elseif do == 10
%                     x = input('How much distance are you adding to the unit cell include the length of the unit cell in that(in Angstroms)? ');
%                     [atomsTAG,a,b,c,a1,a2,a3,atoms,tag] = cellcombX(x,a,b,c,a1,a2,a3,data1,headline1,header);
%                 elseif do == 11
%                     [atom,atomID] = FEFFadd(header);
%                 end
%                 do = input('What would you like to do now? (Press Enter to quit) ');
%             end
%         catch
%             err_count=err_count+1;
%             disp('Enter a valid number\n')
%             do = input('Please select a number from the Menu ');
%             %% El menu
%             while ~isempty(do);
%                 if do == 1
%                     x = input('What do you want to shift the cell by? (fractional coordinates x direction) ');
%                     a = shiftbyX(x,a);
%                 elseif do == 2
%                     x = input('What do you want to shift the cell by? (fractional coordinates y direction) ');
%                     b = shiftbyY(x,b);
%                 elseif do == 3
%                     x = input('What do you want to shift the cell by? (fractional coordinates z direction) ');
%                     c = shiftbyZ(x,c);
%                 elseif do == 4
%                     changeX = input('What do you want to shrink the cell by in X ? (enter value in A for x direction) ');
%                     [a,a1] = cellShrinkX(changeX,a,a1);
%                 elseif do == 5
%                     changeY = input('What do you want to shrink the cell by in Y? (enter value in A for y direction) ');
%                     [b,a2] = cellShrinkY(changeY,b,a2); 
%                 elseif do == 6
%                     changeZ = input('What do you want to shrink the cell by in Z? (enter value in A for z direction) ');
%                     [c,a3] = cellShrinkZ(changeZ,c,a3);
%                 elseif do == 7
%                     x = input('Change the cell by what length ( enter value in A for x direction) ' );
%                     [a,a1] = cellChangeX(x,a,a1);
%                 elseif do == 8
%                     x = input('Change the cell by what length ( enter value in A for y direction) ' );
%                     [b,a2] = cellChangeY(x,b,a2);
%                 elseif do == 9
%                     x = input('Change the cell by what length ( enter value in A for z direction) ' );
%                     [c,a3] = cellChangeZ(x,c,a3);
%                 elseif do == 10
%                     x = input('How much distance are you adding to the unit cell include the length of the unit cell in that(in Angstroms)? ');
%                     [atomsTAG,a,b,c,a1,a2,a3,atoms,tag] = cellcombX(x,a,b,c,a1,a2,a3,data1,headline1);
%                 elseif do ==11
%                     [atom,atomID] = FEFFadd(header);
%                 end
%                 do = input('What would you like to do now? (Press Enter to quit) ');
%             end
%         end
%         count=count+1;
%     end
% end

%% funciton creation and editing


            
    
function [atomsTAG,an,bn,cn,a1,a2,a3,atoms,tag] = cellcombX(cellChange,a,b,c,a1,a2,a3,header)
        %% This function returns the total number of each type of atom and a tag to tell
        % the  export data function to use that atomic number in place of
        % the other atomic data read in initially. the number of headlines
        % in has to (right now) be equal to the initial POSCAR but you
        % should always use the same POSCAR to combine data since shiftbyI
        % always results in a reflection about the I axis. 
        % expand/contract the first half of the cell & move atoms
        %% IMPORT THE First half of cell denote by the number 1
        tag = 1;                                
        % The original First POSCAR cell length
        a1Origin = a1(1);
        % The atomic information
        atomCount1=header{3};
        % ADD IN THE EXTRA AMOUNT OF SPACE TO PLACE OTHER HALF OF CELL
        [an,a1] = cellChangeX(cellChange,a,a1);
        
        itt = 0;                        % initialize counter 
        totalAtoms=0;                   % get total atoms of 1st half cell
        for i=1:length(header{3})
            totalAtoms=totalAtoms+str2num(header{3}{i});
        end
        %now we have totalAtoms of first cell
        atomtot=0;
        if length(header)==5
            % atoms are header{}
            for i=1:length(header{3})      % get the total number of atoms
                if i == 1;                 % get the first atoms in the series separated out
                    atom(1,1:str2num(header{3}{1}))={header{5}{1}}; 
                    atomtot=str2num(header{3}{i})+atomtot;
                elseif i > 1;
                    CurAtomNum = str2num(header{3}{i});
                    atomtot = atomtot+CurAtomNum;
                    atom(1,(str2num(header{3}{i-1})+1):atomtot)={header{5}{i}}; 
                end
            end
        else     
            for i=1:length(header{3})      % get the total number of atoms
                if i == 1;                 % get the first atoms in the series separated out
                    atom(1,1:str2num(header{3}{1}))={strcat('Atom',num2str(i))}; 
                elseif i > 1;
                    CurAtomNum = str2num(header{3}{i});
                    atomtot = atomtot+CurAtomNum;
                    atom(1,(str2num(header{3}{i-1})+1):atomtot)={strcat('Atom',num2str(i))}; 
                end
            end
        end
        % SEPARATE OUT THE TOTAL 
        firstAtoms = totalAtoms - atomCount1(2);
        firstAtomsCounter = 0;
        secondAtomsCounter = 0;
        
        aFirstatoms = an([1:firstAtoms],1);
        bFirstatoms = b([1:firstAtoms],1);
        cFirstatoms = c([1:firstAtoms],1);
        
        aSecondatoms = an([firstAtoms+1:totalAtoms],1);
        bSecondatoms = b([firstAtoms+1:totalAtoms],1);
        cSecondatoms = c([firstAtoms+1:totalAtoms],1);
        a_0 = [];
        for i = 1:length(a)
            % find all the zeros @ a=0
            if an(i) == 0
                itt = itt + 1;
                a_0(itt) = i;       % return the indice of the 0
                b_0(itt) = b(i);     % return the b value @ that 0
                c_0(itt) = c(i);     % return the c value @ that 0
            end
        end
        % now find out their multiplicity and add the atoms
 
        % WHAT TYPE OF ATOM ARE WE AND WHERE AM I @ w.r.t. B AND C? 
        for i = 1:length(a_0)
            if a_0(i) <= firstAtoms    % is it in the first set of atoms YES
                firstAtomsCounter = firstAtomsCounter + 1;
                aAdd = a1Origin/(a1Origin*(1+cellChange/a1Origin));
                bAdd = b_0(i);
                cAdd = c_0(i);
                aFirstatoms = [aFirstatoms;aAdd];
                bFirstatoms = [bFirstatoms;bAdd];
                cFirstatoms = [cFirstatoms;cAdd];
            % you are in the second set
            else
                secondAtomsCounter = secondAtomsCounter + 1;
                aAdd = a1Origin/(a1Origin*(1+cellChange/a1Origin)); % gives the oringinal length of the first cell in fractional coordinates. 
                bAdd = b_0(i);
                cAdd = c_0(i);
                aSecondatoms = [aSecondatoms;aAdd];
                bSecondatoms = [bSecondatoms;bAdd];
                cSecondatoms = [cSecondatoms;cAdd];
            end
        end
        totalAtoms = totalAtoms + firstAtomsCounter + secondAtomsCounter;

        
        %% %% import second POSCAR atoms %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [aT,bT,cT,a1T,a2T,a3T,headlineT,data1T] = importPOSCAR;
        
        % original cell length
        aTorigin = a1T(1);
        % CHANGE THE VOLUME OF THE CELL 
        [anT,a1T] = cellChangeX(cellChange,aT,a1T);
        % is good length(anT);
        [atoms2,crap] = str2num(data1T.textdata{headlineT-1});
        
        itt2 = 0;    % initialize counter 
        % START THE ATOM COUNTERS GET TOTAL ATOM COUNT
        totalatoms2 = length(aT);
        firstAtomsCounter2 = 0;
        secondAtomsCounter2 = 0;
        
        % separate the data for second POSCAR
        aFirstatoms2 = anT([1:atoms2(1)],1);  
        bFirstatoms2 = bT([1:atoms2(1)],1);
        cFirstatoms2 = cT([1:atoms2(1)],1); 
        
        aSecondatoms2 = anT([atoms2(1)+1:totalatoms2],1);
        bSecondatoms2 = bT([atoms2(1)+1:totalatoms2],1);
        cSecondatoms2 = cT([atoms2(1)+1:totalatoms2],1);
                      
        % FIND THE ATOMS TO ADD
        for i = 1:length(aT)
            % find all the zeros @ a=0
            if aT(i) == 0
                itt2 = itt2 + 1;
                a_02(itt2) = i;       % return the indice of the 0
                b_02(itt2) = bT(i);     % return the b value @ that 0
                c_02(itt2) = cT(i);     % return the c value @ that 0
            end
        end
        
        % SHIFT THE ATOMS TO THE END OF THE NEW SUPERCELL
        [aFirstatoms2] = shiftbyX(-1,aFirstatoms2); %% ASSUME YOU WANT THE SECOND POSCAR AT THE OTHER END OF THE CELL
        [aSecondatoms2] = shiftbyX(-1,aSecondatoms2);
        
        % ADD THE ATOMS INTO THE SUPERCELL STRUCTURE @ 1- length of the old unit cell
        for i = 1:length(a_02)
            if a_02(i) <= atoms2(1)    % is it in the first set of atoms YES
                firstAtomsCounter2 = firstAtomsCounter2 + 1;
                aAdd2 = 1 - aTorigin/(aTorigin*(1+cellChange/aTorigin));
                bAdd2 = b_02(i);
                cAdd2 = c_02(i);
                aFirstatoms2 = [aFirstatoms2;aAdd2];
                bFirstatoms2 = [bFirstatoms2;bAdd2];
                cFirstatoms2 = [cFirstatoms2;cAdd2];
            % you are in the second set
            else
                secondAtomsCounter2 = secondAtomsCounter2 + 1;
                aAdd2 = 1 - aTorigin/(aTorigin*(1+cellChange/aTorigin)); % gives the oringinal length of the first cell in fractional coordinates. 
                bAdd2 = b_02(i);
                cAdd2 = c_02(i);
                aSecondatoms2 = [aSecondatoms2;aAdd2];
                bSecondatoms2 = [bSecondatoms2;bAdd2];
                cSecondatoms2 = [cSecondatoms2;cAdd2];
            end
        end
        
        % get the total number of atoms from the second poscar
        totalatoms2 = totalatoms2  + firstAtomsCounter2 + secondAtomsCounter2;
    
        %% combine all the manipulated data together and return the atom number
        an1c = [aFirstatoms;aFirstatoms2];
        bn1c = [bFirstatoms;bFirstatoms2];
        cn1c = [cFirstatoms;cFirstatoms2]; 
        
        an2c = [aSecondatoms;aSecondatoms2];
        bn2c = [bSecondatoms;bSecondatoms2];
        cn2c = [cSecondatoms;cSecondatoms2];
        
        an = [an1c;an2c];
        bn = [bn1c;bn2c];
        cn = [cn1c;cn2c];
        
        %% get atomic data to write out to the final POSCAR
        totalatoms = totalAtoms + totalatoms2;
        firstKindAtoms = atomCount1(1) + atoms2(1) + firstAtomsCounter + firstAtomsCounter2 ;
        secondKindAtoms = atomCount1(2) + atoms2(2) +  secondAtomsCounter + secondAtomsCounter2;
        atoms = [firstKindAtoms;secondKindAtoms];       % concat the added atoms
        atomsTAG = [(1:firstKindAtoms)';(1:secondKindAtoms)'];
        % display information
        disp( strcat('The function added ', num2str(firstAtomsCounter + firstAtomsCounter2), ' of the first atom ', num2str(secondAtomsCounter + secondAtomsCounter2), ' of the second atom '));
        disp( strcat('There is a total of ', num2str(totalatoms), ' atoms in this supercell. '));
        
end

function [an,bn,cn,a1,a2,a3,atoms,tag] = addAtoms(a,b,c,a1,a2,a3,data1,headlines,cellChange)
        
        % PARSE AND DEFINE DATA
        [atoms,crap] = str2num(data1.textdata{headlines-1});     % get the number of atoms data
        OriginAtomCount = atoms(1) + atoms(2);                      % the total number of atoms
        aTorigin = a1(1);
        % START THE ATOM COUNTERS 
        itt2 = 0;    % initialize counter 
        firstAtomsCounter = 0;
        secondAtomsCounter = 0;
        
        % separate the data for second POSCAR
        aAtom1 = a([1:atoms(1)],1);  
        bAtom1 = b([1:atoms(1)],1);
        cAtom1 = c([1:atoms(1)],1); 
        
        aAtom2 = a([atoms(1)+1:OriginAtomCount],1);
        bAtom2 = b([atoms(1)+1:OriginAtomCount],1);
        cAtom2 = c([atoms(1)+1:OriginAtomCount],1);
        
        %% FIND ALL THE ATOMS APPEARING AT THE a BOUNDARY
        for i = 1:OriginAtomCount
            % find all the zeros @ a=0
            if a(i) == 0
                itt2 = itt2 + 1;
                a_0(itt2) = i;       % return the indice of the 0
                b_0(itt2) = b(i);     % return the b value @ that 0
                c_0(itt2) = c(i);     % return the c value @ that 0
            end
        end
        
        % SHIFT THE ATOMS TO THE END OF THE NEW SUPERCELL
        [aAtom1] = shiftbyX(-1,aAtom1); %% ASSUME YOU WANT THE SECOND POSCAR AT THE OTHER END OF THE CELL
        [aAtom2] = shiftbyX(-1,aAtom2);
        
        % ADD THE ATOMS INTO THE SUPERCELL STRUCTURE @ 1 - length of the old unit cell
        for i = 1:length(a_0)
            if a_0(i) <= atoms(1)    % is it in the first set of atoms YES
                firstAtomsCounter = firstAtomsCounter + 1;
                aAdd = 1 - aTorigin/(aTorigin*(1+cellChange/aTorigin));
                bAdd = b_0(i);
                cAdd = c_0(i);
                aAtom1 = [aAtom1;aAdd];
                bAtom1 = [bAtom1;bAdd];
                cAtom1 = [cAtom1;cAdd];
            % you are in the second set
            else
                secondAtomsCounter = secondAtomsCounter + 1;
                aAdd2 = 1 - aTorigin/(aTorigin*(1+cellChange/aTorigin)); % gives the oringinal length of the first cell in fractional coordinates. 
                bAdd2 = b_0(i);
                cAdd2 = c_0(i);
                aAtom2 = [aAtom2;aAdd2];
                bAtom2 = [bAtom2;bAdd2];
                cAtom2 = [cAtom2;cAdd2];
            end
        end
        
        % TEST FOR ADDED ATOMS
        if firstAtomsCounter + secondAtomsCounter > 0
            tag = 1;
        else
            tag = 0;
        end
        
        % COLLECT THE RETURN DATA
        atoms = [ atoms(1) + firstAtomsCounter, atoms(2) + secondAtomsCounter ];
        % TAG has been set
        an = [aAtom1;aAtom2];
        bn = [bAtom1;bAtom2];
        cn = [cAtom1;cAtom2];
        
end



%% All my completely finished functions for data manipulation

function [base,header]=layerPull(a,b,c,layer,layerShiftx,layerShifty,layerShiftz,layerpull,header,basisOriginal)
    basis = {};
    pull=[]; itt=0;
    % find the indices which need to be pulled for the layer
    % make the shifts positive
    if layerShiftz < 0
        layerShiftz=layerShiftz+1;
    elseif layerShifty < 0
        layerShifty=layerShifty+1;
    elseif layerShiftx < 0
        layerShiftx=layerShiftx+1;
    end
    
    if layer == 'z'
        for l = 1:length(a)
            if c(l) == layerpull
                itt=itt+1;
                pull(itt)=l;
            end
        end
    elseif layer == 'y'
        for l = 1:length(a)
            if b(l) == layerpull
                itt=itt+1;
                pull(itt)=l;
            end
        end
    elseif layer == 'x'
        for l = 1:length(a)
            if a(l) == layerpull
                itt=itt+1;
                pull(itt)=l;
            end
        end  
    end
    % pull the data from a,b,c and place into basis with the shift
    % applied
    % THE SHIFTED BASIS
    for i=1:3
        if i == 1
            basis(i)={shiftbyX(layerShiftx,a(pull))};
        elseif i == 2
            basis(i)={shiftbyY(layerShifty,b(pull))};
        elseif i == 3
            basis(i)={shiftbyZ(layerShiftz,c(pull))};
        end
    end
    % THE CODE TO GET ATOM SEPARATED LISTS
    itt = 0;                        % initialize counter 
    totalAtoms=0;                   % get total atoms of the cell
    atomNums=[];                    % get the total atom number of each type of atom
    atomRange={};                   % the matrix which holds the atom ranges for each element
    % gets total atom count + 
    for i=1:length(header{3})
        itt=itt+1;
        totalAtoms=totalAtoms+str2num(header{3}{i});        % adds up the total amount of atoms in the supercell
        atomNums(itt)=str2num(header{3}{i});                % pull atoms and places the number into atomNums
    end
    % loop which updates atomRange and provides a matrix to call each
    % elements basis range.
    atomSum=0;
    for i=1:length(header{3})
       if i == 1
           atomSum=atomSum+str2num(header{3}{i});        % adds up the total amount of atoms in the supercell
           atomRange(1)={1:str2num(header{3}{1})};
       elseif i > 1 && i < length(header{3})
           atomRange(i)={atomSum+1:str2num(header{3}{i+1})};
           atomSum=atomSum+str2num(header{3}{i});        % adds up the total amount of atoms in the supercell
       elseif i == length(header{3})
           atomRange(i)={atomSum+1:totalAtoms};
       end
    end
    % re-initialize dummy variables for later use
    atomSum=0; I=0; itt=0;
    % now we have totalAtoms, Atom Range for each element and Numver of each Element type within the first cell
    basVecElement={};            % cell array for the CHANGED basis vectors
    basVecElementOriginal={};
    aOR=basisOriginal{1};bOR=basisOriginal{2};cOR=basisOriginal{3};
    for i=1:length(atomNums)
        basVecElement{i}={[basis{1}(atomRange{i}),basis{2}(atomRange{i}),basis{3}(atomRange{i})]};
        basVecElementOriginal{i}={[aOR(atomRange{i}),bOR(atomRange{i}),cOR(atomRange{i})]};
    end
    atomnum={};
    % PUT THE TWO TOGETHER
    for i=1:length(atomNums)
        atomnum{i}=length(basVecElementOriginal{i}{1})+length(basVecElement{i}{1});
        basis{i}={[basVecElementOriginal{i}{1};basVecElement{i}{1}]};
    end
    base={};
    for i=1:length(atomNums)
        if i==1
            base={basis{1}{1}};
        elseif i>1
            base={[base{1};basis{i}{1}]};
        end
    end
    header{3}=atomnum;
end

function [an,a1n] = cellChangeX(changeX,a,a1)
        if changeX < 0
            a1n = a1;
            percent = 1 - changeX/a1(1);
            a1n(1) =  a1(1) * percent;
            an = a ./ percent;
        elseif changeX > 0
            a1n = a1;
            percent = 1 + changeX/a1(1);
            a1n(1) = a1(1) * percent;
            an = a ./ percent;
        end
        
end
function [bn,a2n] = cellChangeY(changeY,b,a2)
           if changeY < 0
                a2n = a2;
                percent = 1 - changeY/a2(2);
                a2n(2) =  a2(2) * percent;
                bn = b ./ percent;
            elseif changeY > 0
                a2n = a2;
                percent = 1 + changeY/a2(2);
                a2n(2) = a2(2) * percent;
                bn = b ./ percent;
           end
            
end
function [cn,a3n] = cellChangeZ(changeZ,c,a3)
        if changeZ < 0
            a3n = a3;
            percent = 1 - changeZ/a3(3);
            a3n(3) =  a3(3) * percent;
            cn = c ./ percent;
        elseif changeZ > 0
            a3n = a3;
            percent = 1 + changeZ/a3(3);
            a3n(3) = a3(3) * percent;
            cn = c ./ percent;
        end
        
 end
function [a] = shiftbyX(x,a)
    for i = 1:length(a)
        if x < 0
            a(i) = 1 - a(i);
            if a(i) >= 1
                a(i) = a(i) - 1;
            end
        else
            a(i) = a(i) + x;
            if a(i) >= 1
                a(i) = a(i) - 1;
            end
        end 
    end
    
end
function [b] = shiftbyY(y,b)
    
    for i = 1:length(b)
        if y < 0
            b(i) = 1 - b(i);
            if b(i) >= 1
                b(i) = b(i) - 1;
            end
        else
            b(i) = b(i) + y;
            if b(i) >= 1
                b(i) = b(i) - 1;
            end
        end
    end
  
end
function [c] = shiftbyZ(z,c)
     
     for i = 1:length(c)
         if z < 0
            c(i) = 1 - c(i);
            if c(i) >= 1
                c(i) = c(i) - 1;
            end
         else
             c(i) = c(i) + z;
             if c(i) >= 1
                 c(i) = c(i) - 1;
             end
         end
     end

end
function [an,a1n] = cellShrinkX(changeX,a,a1)
            a1n = a1;
            percent = 1 - changeX ./ a1(1);
            a1n(1) =  a1(1) * percent;
            an = a ./ percent;     
end
function [bn,a2n] = cellShrinkY(changeY,b,a2)
            a2n = a2;
            percent = 1 - changeY ./ a2(2);
            a2n(2) =  a2(2) * percent;
            bn = b ./ percent;      
end
function [cn,a3n] = cellShrinkZ(changeZ,c,a3)
            a3n = a3;
            percent = 1 + changeZ ./ a3(3);
            a3n(3) =  a3(3) * percent;
            cn = c ./ percent;   
end

end