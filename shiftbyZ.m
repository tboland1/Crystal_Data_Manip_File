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