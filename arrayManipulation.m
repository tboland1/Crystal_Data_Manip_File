function atomicelements=arrayManipulation(spaces)
% ArrayManipulation removes the spaces from a set of data imported from a 
% text file and returns a cell array with the data. Function only works on
% variables with a max of 2 character elements. Used with crystal
% manipulation data. For arbitary spaces and list size used cell2split
% 118 lines
spaces=strtrim(spaces);
array = isspace(spaces);              % get the space matrix, 0=char 1=space
indexSpace=[];                        % initialize the space index matrix
l=0;                                  % initialize count to place the index for 0's into space array
for i=1:length(spaces)
    if array(i)==1 
        l = l+1;
        indexSpace(l)=i;
    end
end

% Remove double spaces. Return a matrix of double spaces to be removed
doubleSpace=[];countSpace=0; p=1;       % initialize all loop/array variables
while p < length(array);
    if array(p) == array(p+1) && array(p)==1;
        countSpace=countSpace+1;
        doubleSpace(countSpace)=p;
        p=p+1;
    else
        p=p+1;
    end 
end

spaces(doubleSpace)=[];              % remove all the spaces at the same time
array = isspace(spaces);             % redo index array count, 0=char 1=space

% Find the double & single elements
singleE=[];                          % indicies of the single elements in spaces array  
countS=0;                            % counter for matrix above
doubleE={};                          % indicies of double elements in the spaces array
countD=0;                            % counter for matrix above
l=1;                                 % counter for looping over # of spaces in spaces
pull=[]; pul=1;                      % tells the order in which to assign the elements after data manipulation

%% PUTS THE DATA INTO THE CELL ARRAY
while l < length(array) 
    if l==1;
        if array(l) == array(l+1);
            countD=countD+1;
            doubleE{countD}=[l;l+1];
            l=l+1;
            pull(pul)=2;
            pul=pul+1;
        elseif array(l) ~= array(l+1) && array(l+1)==1 ;
            countS=countS+1;
            singleE(countS)=l;
            l=l+1;
            pull(pul)=1;
            pul=pul+1;
        else
            l=l+1;
        end
    elseif l == (length(array)-1)
        if array(l) == array(l+1);
            countD=countD+1;
            doubleE{countD}=[l;l+1];
            l=l+1;
            pull(pul)=2;
            pul=pul+1;
        elseif array(l) ~= array(l+1) && array(l)==1;
            countS=countS+1;
            singleE(countS)=l+1;
            l=l+1;
            pull(pul)=1;
            pul=pul+1;
        else
            l=l+1;
        end
    else
        if array(l) == array(l+1);
            countD=countD+1;
            doubleE{countD}=[l;l+1];
            l=l+1;
            pull(pul)=2;
            pul=pul+1;
        elseif array(l) ~= array(l+1) && array(l+1)==1 && array(l-1)==1 ;
            countS=countS+1;
            singleE(countS)=l;
            l=l+1;
            pull(pul)=1;
            pul=pul+1;
        else
            l=l+1;
        end
    end
end

% pull matrix number 1 means pull from singleE matrix, 2 = pull from
% doubleE
% cat the double elements to place into cell array
nm=size(doubleE); atomicelements={}; dEl={};
for i=1:nm(2)
    element=doubleE{i};         % get the matrix elements from doubleE
    catE=strcat(spaces(element(1)),spaces(element(2)));
    dEl{i}={catE};
end 

double=0;                   % counter to place doubles in final matrix
single=0;                   % counter to place single in final matrix
% dEl is the list of double elements from array
% singleE is the index of the single element from array
%% PUT SINGLE ELEMENTS AND DOUBLE ELEMENTS INTO ARRAY
for i=1:length(pull)
    if pull(i)==1
        single=single+1;
        atomicelements(i)={spaces(singleE(single))};
    elseif pull(i)==2 
        double=double+1;
        atomicelements(i)=dEl{double};
    end
end
end

