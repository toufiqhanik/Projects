function [y] = hd (x1,x2)

x1= char(x1);
x2= char(x2);

y=0;
for ii= 1:8
    if ( x1(ii)~= x2(ii))
        y=y+1;
        
    end
end

