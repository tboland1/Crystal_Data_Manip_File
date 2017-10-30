%% FEFFtags is a program used to create atoms tags and add them to the 
% front and end of a list of atom basis vectors from POSCAR's. All data is
% in the form of cell arrays. FORMATTING:
% O   0.0000 0.0000 0.0000 O1
% 72 lines
function [FEFF]=FEFFadd(header)
%% ADD the Element Type ID 
% header format for atomID's being present (8):
% header={sysTag,univScaling,atomCount,spaceCoor,atomicElements}
% format for atomID's not being present (7):
% header={sysTag,univScaling,atomCount,spaceCoor}
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

%% ADD atom ID number to elements
atomtot=0;
if length(header)==5
% atoms are header{}
    for i=1:length(header{3})      % get the total number of atoms
        if i == 1;                 % get the first atoms in the series separated out
            num=[1:str2num(header{3}{1})];
            atomID(1,1:str2num(header{3}{1}))={header{5}{1}};
            for l=1:length(num);
                 atomID{l}=strcat(atom{l},num2str(l));
            end
            atomtot=str2num(header{3}{i})+atomtot;
        elseif i > 1;
            num=[1:(str2num(header{3}{i}))];
            CurAtomNum = str2num(header{3}{i});
            atomID(1,(str2num(header{3}{i-1})+1):atomtot)={header{5}{i}};
            for l=1:length(num);
                atomC=l+atomtot;
                atomID{atomC}=strcat(atom{atomC},num2str(l));
            end
            atomtot = atomtot+CurAtomNum;
        end
    end
else     
    for i=1:length(header{3})      % get the total number of atoms
        if i == 1;                 % get the first atoms in the series separated out
            atomID(1,1:str2num(header{3}{1}))={strcat('Atom',num2str(i))}; 
        elseif i > 1;
            CurAtomNum = str2num(header{3}{i});
            atomtot = atomtot+CurAtomNum;
            atomID(1,(str2num(header{3}{i-1})+1):atomtot)={strcat('Atom',num2str(i))}; 
        end
    end   
end
FEFF={atom,atomID};
end































