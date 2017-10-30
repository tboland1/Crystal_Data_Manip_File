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