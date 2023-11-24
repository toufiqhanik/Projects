function [v, phhd,phhw,phbit]= sim_power_traces(d, byte_number, key, atkbit_num)

[m,n]= size(d(:,byte_number));
data= d(:,byte_number);

kh=key;

load('sbox.mat');
sboxin=sbox;
phhd=zeros(m,1);
phhw=zeros(m,1);
phbit=zeros(m,1);

vin= zeros(m,1);
v= reshape(cellstr(dec2bin(vin,8)),size(vin));

for mi= 1:m
    keyxor= aesxor(kh(1,byte_number),data(mi,1));
    k =kh(1,byte_number);
    da=data(mi,1);
    %disp(keyxor)
    keyxor=char(keyxor);
    sboxout=sboxin(bin2dec(keyxor)+1);
    sboxoutbin= dec2bin(sboxout,8);
    sbo= sboxoutbin;
    v(mi,1)= cellstr(sboxoutbin);
    phhd(mi,1)= hd(data(mi,1),sboxoutbin);
    phhw(mi,1)= hw(sboxoutbin);
    phbit(mi,1)= hbit(sboxoutbin,atkbit_num);
    
end