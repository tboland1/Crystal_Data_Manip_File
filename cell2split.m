function cellArray=cell2split(spaces)
% ArrayManipulation removes the spaces from a set of text data in the form
% of an array and returns a cell array. It separates by spaces. The function 
% works on any number of spaces and variables matrix character elements.
% 54 lines
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

% reset all old loop variables
indexSpace=0;l=0;
spaces(doubleSpace)=[];              % remove all the spaces at the same time
array = isspace(spaces);             % redo index array count, 0=char 1=space
% all spaces are removed
% get new indices for array
indexSpace=[];
for i=1:length(array)
    if array(i)==1 
        l = l+1;
        indexSpace(l)=i;
    end
end
if length(indexSpace)>1 
    temp={};
    for i=1:length(indexSpace)+1
        if i==1
            temp(i)={spaces(1:indexSpace(i)-1)};
        elseif i > 1 && i< length(indexSpace)+1
            temp(i)={spaces(indexSpace(i-1)+1:indexSpace(i)-1)};
        elseif i == length(indexSpace)+1
            temp(i)={spaces(indexSpace(i-1)+1:length(spaces))};
        end
    end
    cellArray=temp;                 % return the data
else
    cellArray={spaces};
end
end
























