%Developed By Anik
%Inital Idea by Alex
%Inital Days of Learning CPA
%Date : 8_7_2019
%%
clc; clear all; close all;
pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load required files

%Load cipher texts
tStartOverall = tic;
fprintf('Loading cipher texts...\n');
tic
load 'ct.txt'; %anik
toc
fprintf('Done!\n\n')

ct_nums = length(ct)/16; %total number of ciphertexts

%Load power traces
fprintf('Loading power traces...(Matrix T)\n')
tic
load 'power.txt'; %anik
toc
fprintf('Done!\n\n')

traces = power;
clear power;

load InvSubBytes %load InvSubBytes table
load HW          %load HW table

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Set Parameters
roundkey = zeros(1,16);  %create empty array to hold round key guesses

for byte_to_attack = 0:15  %from 0-15
fprintf('Attacking byte%d\n\n',byte_to_attack)    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Create input vectors, D and K
fprintf('Creating data vector D and key guess vector K...\n');
tic
D = uint8(ct(byte_to_attack+1:16:end));  %%create vector D of CT bytes
K = uint8(0:255); %generate key hypotheses
toc
fprintf('Done!\n\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate hypothetical intermediate values
fprintf('Calculating Hypothetical Intermediate Values (Matrix V)...\n');
tic
V = InvSubBytes(bitxor(repmat(D, 1, length(K)), repmat(K, ct_nums, 1)) + 1);
    %repmat(D, 1, length(K)) expands vector D into Matrix of size DxK
    %where each column is vector D
toc
fprintf('Done!\n\n')
    %repmat(K, samples,1) expands vector K into DxK matrix
    %where each column is vector K
    
    %the + 1 after bit xor since matlab indexes from 1
    
% fprintf('Calculating Hypothetical Power Consumption (Matrix H)...\n');
% fprintf('Power Model : Hamming Weight \n');
% tic
% H = HW(V+1);
%     %the + 1 since MATLAB indexes from 1.
%     %so if V=0, the HW should be 0. HW(1) will return 0.
% toc
% fprintf('Done!\n\n')

fprintf('Calculating Hypothetical Power Consumption (Matrix H)...\n');
fprintf('Power Model : Hamming Distance \n');
%h_(i,j) = HD(v_(i,j) = HW(v_(i,j) XOR d_i)
tic
switch byte_to_attack
    case  0 
        previous_bta = 0;
    case  1
        previous_bta = 5;
    case  2
        previous_bta = 10;
    case  3 
        previous_bta = 15;
    case  4 
        previous_bta = 4;
    case  5
        previous_bta = 9;
    case  6 
        previous_bta = 14;
    case  7
        previous_bta = 3;
    case  8
        previous_bta =  8;
    case  9
        previous_bta = 13;
    case 10
        previous_bta =  2;
    case 11 
        previous_bta =  7;
    case 12 
        previous_bta = 12;
    case 13 
        previous_bta =  1;
    case 14 
        previous_bta =  6;
    case 15 
        previous_bta = 11;
end

D_prev = uint8(ct(previous_bta+1:16:end));
%%H = HW(bitxor(repmat(D,1,length(K)), V)+1);
H = HW(bitxor(repmat(D_prev,1,length(K)), V)+1);
toc
fprintf('Done!\n\n');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate Correlation

fprintf('Calculating Correlation...(Matrix R)\n');
tic
tr_length = size(traces, 2);  %how many sample points in each trace
R = zeros(length(K), tr_length);    %initialize R to all zeros

for key_idx = uint16(K)+1 %+1 since matlab indexes from 1
    fprintf('Working on key guess = %d\n', K(key_idx));
    
    for k = 1:tr_length
        r = corrcoef( [double(H(:,key_idx)) double(traces(:,k))] );
        R(key_idx, k) = r(1, 2);
    end
end
toc
fprintf('Done!\n\n');


%{
fprintf('Calculating Correlation...(Matrix R)\n');
tic
tr_length = size(traces, 2);  %how many sample points in each trace
R = corr(double(H),double(traces));
toc
fprintf('Done!\n\n');
%}




%determine max correlation
fprintf('Finding max correlation in R...\n');
tic
[maxNum, maxIndex] = max(R(:));
[kck, col] = ind2sub(size(R), maxIndex);
toc
fprintf('Done!\n\n');
roundkey(byte_to_attack+1) = kck; %fill in array with roundkey guesses
close all; 

fprintf('Plotting correlation for all traces...\n');
tic

plot_all = figure;
hold on;
axis([0 tr_length min(min(R)) max(max(R))])
for i=1:256   
    plot((R(i,:)));
    if (i==kck)
        plot_kck = plot(R(i,:),'r');
        titletext = sprintf('Byte_{%d} of Roundkey: 0x%2.2x, MaxR: %2.4f, MinR: %2.4f',byte_to_attack,i-1, max(R(i,:)), min(R(i,:)));
        %titletext = strrep(titletext,'\','\\');
        %titletext = strrep(titletext,'_','\_');
        title(titletext);
        legend([plot_kck],sprintf('Byte_{%d}',byte_to_attack));
    end
end
    xlabel('Samples');
    ylabel('Corrlelation');
hold off;
toc
fprintf('Done!\n\n');

fprintf('Saving plots...\n');
plot_name = sprintf('byte_{%d}',byte_to_attack);
saveas(plot_all,plot_name,'fig');
saveas(plot_all,plot_name,'png');
fprintf('Done!\n\n');

fprintf('Saving correlation matrix...\n');
filename = sprintf('R%d',byte_to_attack);

fprintf('Done!\n\n');
end

fprintf('Writing Roundkey to file...\n');
dlmwrite('rk10.txt',dec2hex(roundkey(byte_to_attack+1)),'delimiter',' ');
fprintf('Done!\n\n');
tEndOverall = toc(tStartOverall);

fileID = fopen('rk10.txt','w');
fprintf(fileID,'%2.2x ',roundkey);
fclose(fileID);
