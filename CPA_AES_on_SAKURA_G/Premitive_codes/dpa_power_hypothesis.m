function [v, phhd,phhw]= dpa_power_hypothesis(d, byte_number)

[m,n]= size(d(:,byte_number));
data= d(:,byte_number);
load('keyhi.mat');
khin=keyhi;
kh= reshape(cellstr(dec2bin(khin,8)),size(khin));

load('sbox.mat');
sboxin=sbox;
phhd=zeros(m,256);
phhw=zeros(m,256);

vin= zeros(m,256);
v= reshape(cellstr(dec2bin(vin,8)),size(vin));

for mi= 1:m
    for ni = 1:256
        keyxor= aesxor(kh(1,ni),data(mi,1));
        %disp(keyxor)
        keyxor=char(keyxor);
        sboxout=sboxin(bin2dec(keyxor)+1);
        sboxoutbin= dec2bin(sboxout,8);
        v(mi,ni)= cellstr(sboxoutbin);
        phhd(mi,ni)= hd(data(mi,1),sboxoutbin);
        phhw(mi,ni)= hw(sboxoutbin);
    end
end
        
        
