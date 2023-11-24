function [r]= dpa_corelation(h, t)

[i,j]= size(h);

[m,n]= size(t);

r= zeros(256,n);

for ii= 1:j
    
    hi = mean(h(:,ii));
    
    for jj = 1: n
        
        tj = mean (t(:,jj));
        
        rii=0;
               
        hiis=0;
        tiis=0;
        for dd = 1:i
            
            hid= (h(dd,ii)-hi);
            tid= (t(dd,jj)-tj);
            
            rii=rii+hid*tid;
            
            hiis=hiis+(hid*hid);
            tiis=tiis+(tid*tid);
            
         r(ii,jj)=rii/(sqrt(hiis*tiis));
        end
    end
end 
            
            
        
        