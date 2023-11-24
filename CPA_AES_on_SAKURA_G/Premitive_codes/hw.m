function [y] = hw (x);

x= char(x);

y=0;
for ii= 1:8
    if ( x(ii)== '1')
        y=y+1;
        
    end
end