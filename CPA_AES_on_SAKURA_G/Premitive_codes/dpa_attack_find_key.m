function [key] = dpa_attack_find_key (d,type)

load('keyhi.mat');
load('keyib.mat');

key=zeros(1,16);
for index = 1:16    

    [v, phhd,phhw]= dpa_power_hypothesis(d(:,:),index);
    [t, tphhd,tphhw,tphbit]= sim_power_traces(d(:,:), index, keyib, 8);
    
    if type==1        
        [r]= dpa_corelation(phhw, tphhw);
    elseif type==0
        [r]= dpa_corelation(phhd, tphhd);
    else
        disp('input type as hd or hw');
    end
    
    [val, idx]= max(r);
    
    key(1, index)= idx-1
end
    
    