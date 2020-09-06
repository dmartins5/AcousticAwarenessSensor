%ECE458 - Senior Design
%Michael Benker
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FALSE DETECTION RATES %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf;clear all; clc; close all;

%VARIABLES
Ave2sec = 0;    %2-second average
T_high = 4;     %standard deviations for high sensitivity setting
T_med = 8;      %standard deviations for medium sensitivity setting
T_low = 12;     %standard deviations for low sensitivity setting
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

%IMPORT DATA
SoundData1 = 'Book1.xlsx'; %Read excel file in folder
DataMat = zeros(30,4); %Predefine Data Matrix
Ambients = xlsread(SoundData1, 'A2:A31'); %Ambient 1st col
Quiets = xlsread(SoundData1, 'B2:B31'); %Quiet is 2nd col
Mediums = xlsread(SoundData1, 'C2:C31'); %Medium is 3rd col
Louds = xlsread(SoundData1, 'D2:D31'); %Loud is 4th col
[k,DataLoc] = xlsread(SoundData1, 'E1:E1');
DataLoc
%Define past 20 seconds (ambients)

for c =1:10
    Data20sec(c,1) = Ambients(randi([1 30],1,1),1);
    history(c,1)=Data20sec(c,1);
end
Ave20sec = mean(Data20sec)
Std20sec = std(Data20sec)
RT_high = Ave20sec+Std20sec*T_high %Running threshold level (high sens)
RT_med = Ave20sec+Std20sec*T_med %Running threshold level (med sens)
RT_low = Ave20sec+Std20sec*T_low %Running threshold level (low sens)

for c=11:25
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
FDR_low = sum(FD_low, 'all')/sum(ID_low, 'all')    %probability of false interrupt given interrupt detection
FDR_med = sum(FD_med, 'all')/sum(ID_med, 'all')
FDR_high = sum(FD_high, 'all')/sum(ID_high, 'all')






figure(1)
subplot(4,1,1)
plot(history)
title('Environment history')
subplot(4,1,2)
plot(ID_low)
title('Interrupt Detection: low')
subplot(4,1,3)
plot(ID_med)
title('Interrupt Detection: medium')
subplot(4,1,4)
plot(ID_high)
title('Interrupt Detection: high')
suptitle(DataLoc)

figure(2)
subplot(4,1,1)
plot(history)
title('Environment history')
subplot(4,1,2)
plot(FD_low)
title('False Interrupt Detection: low')
subplot(4,1,3)
plot(FD_med)
title('False Interrupt Detection: medium')
subplot(4,1,4)
plot(FD_high)
title('False Interrupt Detection: high')
suptitle(DataLoc)

figure(3)
subplot(4,1,1)
plot(history)
title('Environment history')
subplot(4,1,2)
plot(TID_low)
title('True Interrupt Detection: low')
subplot(4,1,3)
plot(TID_med)
title('True Interrupt Detection: medium')
subplot(4,1,4)
plot(TID_high)
title('True Interrupt Detection: high')
suptitle(DataLoc)



