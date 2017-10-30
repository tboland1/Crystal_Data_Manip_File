        %cellcombo1(cellChange,a,b,c,a1,a2,a3,header)
        cellChange=14;
        atomCount1=header{3};       % REMOVE FROM CODE
        % ADD IN THE EXTRA AMOUNT OF SPACE TO PLACE OTHER HALF OF CELL
        [an,a1] = cellChangeX(cellChange,a,a1);
        
        %% SEPARATES OUT THE ATOMS FROM a,b,c
        itt = 0;                        % initialize counter 
        totalAtoms=0;                   % get total atoms of 1st half cell
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
        basVecElement={};            % cell array for the basis vectors
        for i=1:length(atomNums)
            basVecElement{i}={a(atomRange{i}),b(atomRange{i}),c(atomRange{i})};    
        end
        % NOW SEPARATE OUT THE BASIS VECTORS FOR EACH ELEMENT 
        firstAtoms = totalAtoms - atomCount1(2);
        firstAtomsCounter = 0;
        secondAtomsCounter = 0;
        
        aFirstatoms = an([1:firstAtoms],1);
        bFirstatoms = b([1:firstAtoms],1);
        cFirstatoms = c([1:firstAtoms],1);
        
        aSecondatoms = an([firstAtoms+1:totalAtoms],1);
        bSecondatoms = b([firstAtoms+1:totalAtoms],1);
        cSecondatoms = c([firstAtoms+1:totalAtoms],1);
        
        % FIND ATOMS ON EDGES CORNERS AND FACES
        a_0 = [];               % list of atoms at a=0
        b_0 = [];
        c_0 = [];
        for i = 1:length(a)
            if an(i) == 0
                itt = itt + 1;
                a_0(itt) = i;        % return the indice of the 0
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
        
        
        
        