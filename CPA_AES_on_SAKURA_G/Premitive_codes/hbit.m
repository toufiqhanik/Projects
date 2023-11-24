function [y] = hbit (x,bitnumber);

x= char(x);

y=0;

if ( x(bitnumber)== '1')
    y=1;
else
    y=0;
end
