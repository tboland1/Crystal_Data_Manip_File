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