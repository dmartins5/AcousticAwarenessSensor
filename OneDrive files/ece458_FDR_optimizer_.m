%ECE458 - Senior Design
%Michael Benker
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FALSE DETECTION RATES %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf;clear all; clc; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
samples=100;

%Threshold Levels. Begin and End for sweeping capabilities
T_h_begin = 3.57; 
T_h_end = 3.57;
T_m_begin = 16.84;
T_m_end = 16.84;
T_l_begin = 24.02;
T_l_end = 24.02;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%VARIABLES
Ave2sec = 0;    %2-second average
Data20sec = zeros(10,1);
history = zeros(100,1);

RI_med = zeros(100,1); %1 if real interrupt, 0 if false interrupt
RI_high = zeros(100,1); 
RI_low = zeros(100,1);
ID_low = zeros(100,1);   %1 if interrupt detected, 0 if interrupt not detected
ID_med = zeros(100,1); 
ID_high = zeros(100,1); 
TID_low = zeros(100,1);    %1 if ID = RI = 1, 0 otherwise
TID_med = zeros(100,1); 
TID_high = zeros(100,1); 
FD_low = zeros(100,1);     %1 if ID = 1 & RI = 0, 0 otherwise
FD_med = zeros(100,1);
FD_high = zeros(100,1);
FN_low = zeros(100,1);     %1 if ID = 0 & RI = 1, 0 otherwise
FN_med = zeros(100,1);
FN_high = zeros(100,1);
FDR_low = 0;    %probability of false interrupt given interrupt detection
FDR_med = 0;
FDR_high = 0;
FDR_low_array = zeros(samples,1);    
FDR_med_array = zeros(samples,1);
FDR_high_array = zeros(samples,1);
T_high_array = zeros(samples,1);     %standard deviations for high sensitivity setting
T_med_array = zeros(samples,1);      %standard deviations for medium sensitivity setting
T_low_array = zeros(samples,1);     %standard deviations for low sensitivity setting
FN_low_array = zeros(samples,1);    
FN_med_array = zeros(samples,1);
FN_high_array = zeros(samples,1);
Opti_low = zeros(samples,1);    
Opti_med = zeros(samples,1);
Opti_high = zeros(samples,1);
TID_low_Array = zeros(samples,1);    
TID_med_Array = zeros(samples,1);
TID_high_Array = zeros(samples,1);

TPR_low_Array = zeros(samples,1);    
TPR_med_Array = zeros(samples,1);
TPR_high_Array = zeros(samples,1);

%IMPORT DATA
SoundData1 = 'Book3.xlsx'; %Read excel file in folder
DataMat = zeros(30,4); %Predefine Data Matrix
Ambients = xlsread(SoundData1, 'A2:A31'); %Ambient 1st col
Quiets = xlsread(SoundData1, 'B2:B31'); %Quiet is 2nd col
Mediums = xlsread(SoundData1, 'C2:C31'); %Medium is 3rd col
Louds = xlsread(SoundData1, 'D2:D31'); %Loud is 4th col
[k,DataLoc] = xlsread(SoundData1, 'E1:E1');

%Define past 20 seconds (ambients)


for s=1:samples
    T_high=T_h_begin+s*(T_h_end-T_h_begin)/samples;
    T_med=T_m_begin+s*(T_m_end-T_m_begin)/samples;
    T_low=T_l_begin+s*(T_l_end-T_l_begin)/samples;
    
    T_high_array(s,1)=T_high;
    T_med_array(s,1)=T_med;
    T_low_array(s,1)=T_low;
    
    RI_med = zeros(100,1); %1 if real interrupt, 0 if false interrupt
    RI_high = zeros(100,1); 
    RI_low = zeros(100,1);
    ID_low = zeros(100,1);   %1 if interrupt detected, 0 if interrupt not detected
    ID_med = zeros(100,1); 
    ID_high = zeros(100,1); 
    TID_low = zeros(100,1);    %1 if ID = RI = 1, 0 otherwise
    TID_med = zeros(100,1); 
    TID_high = zeros(100,1); 
    FD_low = zeros(100,1);     %1 if ID = 1 & RI = 0, 0 otherwise
    FD_med = zeros(100,1);
    FD_high = zeros(100,1);
    FN_low = zeros(100,1);     %1 if ID = 0 & RI = 1, 0 otherwise
    FN_med = zeros(100,1);
    FN_high = zeros(100,1);
    
    
    

for c =1:100
    Data20sec(c,1) = Ambients(randi([1 30],1,1),1);
    
end
Ave20sec = mean(Data20sec);
Std20sec = std(Data20sec);
RT_high = Ave20sec+Std20sec*T_high; %Running threshold level (high sens)
RT_med = Ave20sec+Std20sec*T_med; %Running threshold level (med sens)
RT_low = Ave20sec+Std20sec*T_low; %Running threshold level (low sens)

for c=1:25
    new = Ambients(randi([1 30],1,1),1);
    history(c,1)=new;

    if new>RT_high
            ID_high(c,1)=1;
            FD_high(c,1)=1;
    end
    if new>RT_med
            ID_med(c,1)=1;
            FD_med(c,1)=1;
    end
    if new>RT_low
            ID_low(c,1)=1; 
            FD_low(c,1)=1;
    end

end

%Quiet interrupts
%Only high sensitivity should activate interrupt
for c=26:50
    new = Quiets(randi([1 30],1,1),1);
    history(c,1)=new;
    RI_high(c,1)=1;
    if new>RT_high
            ID_high(c,1)=1;
            TID_high(c,1)=1;
    else
        FN_high(c,1)=1;
    end
    if new>RT_med
            ID_med(c,1)=1;
            FD_med(c,1)=1;
    end
    if new>RT_low
            ID_low(c,1)=1; 
            FD_low(c,1)=1;
    end

end
    
%medium interrupts
%Only high and medium sensitivity should activate interrupt

for c=51:75
    new = Mediums(randi([1 30],1,1),1);
    history(c,1)=new;
    RI_high(c,1)=1;
    RI_med(c,1)=1;
    if new>RT_high
            ID_high(c,1)=1;
            TID_high(c,1)=1;
    else
        FN_high(c,1)=1;
    end
    if new>RT_med
            ID_med(c,1)=1;
            TID_med(c,1)=1;
    else
        FN_med(c,1)=1;
    end
    if new>RT_low
            ID_low(c,1)=1; 
            FD_low(c,1)=1;
    end

end



%loud interrupts
%all activate interrupt
for c=76:100
    new = Louds(randi([1 30],1,1),1);
    history(c,1)=new;
    RI_high(c,1)=1;
    RI_med(c,1)=1;
    RI_low(c,1)=1;
    if new>RT_high
            ID_high(c,1)=1;
            TID_high(c,1)=1;
    else
        FN_high(c,1)=1;
    end
    if new>RT_med
            ID_med(c,1)=1;
            TID_med(c,1)=1;
    else
        FN_med(c,1)=1;
    end
    if new>RT_low
            ID_low(c,1)=1; 
            TID_low(c,1)=1;
    else
        FN_low(c,1)=1;
    end

end

%False Interrupt Detection Rate - Print all
%probability of false interrupt given interrupt detection
FDR_low_array(s,1) =  sum(FD_low, 'all')/(100-sum(RI_low, 'all'));     
FDR_med_array(s,1) = sum(FD_med, 'all')/(100-sum(RI_med, 'all'));
FDR_high_array(s,1) = sum(FD_high, 'all')/(100-sum(RI_high, 'all'));

TID_low_Array(s,1) = sum(TID_low,'all')/sum(ID_low, 'all');
TID_med_Array(s,1) = sum(TID_med,'all')/sum(ID_med, 'all');
TID_high_Array(s,1) = sum(TID_high,'all')/sum(ID_high, 'all');

FN_low_array(s,1)=sum(FN_low,'all')/25;    
FN_med_array(s,1)=sum(FN_med,'all')/50; 
FN_high_array(s,1)=sum(FN_high,'all')/75;

TPR_low_Array(s,1) = sum(TID_low, 'all')/(sum(RI_low, 'all'));    
TPR_med_Array(s,1) = sum(TID_med, 'all')/(sum(RI_med, 'all'));
TPR_high_Array(s,1) = sum(TID_high, 'all')/(sum(RI_high, 'all'));

end

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
DataLoc = char(DataLoc);

figure(1)
scatter(FDR_low_array,TPR_low_Array,'p','b')
xlabel('False Positive Rate')
ylabel('True Positive Rate')
suptitle('Receiver Operating Characteristic, Low Sensitivity')
title(DataLoc)
xlim([0 1])
ylim([0 1])
grid on
filenamelow = ['ROC_lowsens_standard' DataLoc '.png'];%
saveas(gcf,filenamelow);

figure(2)
scatter(FDR_med_array,TPR_med_Array,'p','b')
xlabel('False Positive Rate')
ylabel('True Positive Rate')
suptitle('Receiver Operating Characteristic, Medium Sensitivity')
title(DataLoc)
xlim([0 1])
ylim([0 1])
grid on
filenamemed = ['ROC_medsens_standard' DataLoc '.png'];
saveas(gcf,filenamemed);

figure(3)
scatter(FDR_high_array,TPR_high_Array,'p','b')
xlabel('False Positive Rate')
ylabel('True Positive Rate')
suptitle('Receiver Operating Characteristic, High Sensitivity')
title(DataLoc)
xlim([0 1])
ylim([0 1])
grid on
filenamehigh = ['ROC_highsens_standard' DataLoc '.png'];
saveas(gcf,filenamehigh);


