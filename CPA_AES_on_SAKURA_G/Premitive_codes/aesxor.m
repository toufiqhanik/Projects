function [y] = aesxor (x1,x2)

x1= char(x1);
x2= char(x2);

y='00000000';

for ii= 1:8
    if ( x1(ii)~= x2(ii))
        y(ii)='1';
    else
        y(ii)='0';
    end
end