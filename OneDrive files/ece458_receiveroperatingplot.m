%ECE458 - Senior Design
%Michael Benker
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FALSE DETECTION RATES %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf;clear all; clc; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
samples=10000;
T_h_begin = 4; %Begin and end for parameter sweep of threshold numbers
T_h_end = 4;
T_m_begin = 30;
T_m_end = 30;
T_l_begin = 55;
T_l_end = 55;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%VARIABLES
Ave2sec = 0;    %2-second average
T_high = 4;     %standard deviations for high sensitivity setting
T_med = 8;      %standard deviations for medium sensitivity setting
T_low = 12;     %standard deviations for low sensitivity setting
Data20sec = zeros(200,1);
history = zeros(1000,1);

RI_med = zeros(1000,1); %1 if real interrupt, 0 if false interrupt
RI_high = zeros(1000,1); 
RI_low = zeros(1000,1);
ID_low = zeros(1000,1);   %1 if interrupt detected, 0 if interrupt not detected
ID_med = zeros(1000,1); 
ID_high = zeros(1000,1); 
TID_low = zeros(1000,1);    %1 if ID = RI = 1, 0 otherwise
TID_med = zeros(1000,1); 
TID_high = zeros(1000,1); 
FD_low = zeros(1000,1);     %1 if ID = 1 & RI = 0, 0 otherwise
FD_med = zeros(1000,1);
FD_high = zeros(1000,1);
FN_low = zeros(1000,1);     %1 if ID = 0 & RI = 1, 0 otherwise
FN_med = zeros(1000,1);
FN_high = zeros(1000,1);
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

%IMPORT DATA
SoundData1 = 'Book1.xlsx'; %Read excel file in folder
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
    
    RI_med = zeros(1000,1); %1 if real interrupt, 0 if false interrupt
    RI_high = zeros(1000,1); 
    RI_low = zeros(1000,1);
    ID_low = zeros(1000,1);   %1 if interrupt detected, 0 if interrupt not detected
    ID_med = zeros(1000,1); 
    ID_high = zeros(1000,1); 
    TID_low = zeros(1000,1);    %1 if ID = RI = 1, 0 otherwise
    TID_med = zeros(1000,1); 
    TID_high = zeros(1000,1); 
    FD_low = zeros(1000,1);     %1 if ID = 1 & RI = 0, 0 otherwise
    FD_med = zeros(1000,1);
    FD_high = zeros(1000,1);
    FN_low = zeros(1000,1);     %1 if ID = 0 & RI = 1, 0 otherwise
    FN_med = zeros(1000,1);
    FN_high = zeros(1000,1);
    
    
    

for c =1:10
    Data20sec(c,1) = Ambients(randi([1 30],1,1),1);
    
end
Ave20sec = mean(Data20sec);
Std20sec = std(Data20sec);
RT_high = Ave20sec+Std20sec*T_high; %Running threshold level (high sens)
RT_med = Ave20sec+Std20sec*T_med; %Running threshold level (med sens)
RT_low = Ave20sec+Std20sec*T_low; %Running threshold level (low sens)

for c=1:259
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
for c=260:509
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

for c=510:759
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
for c=761:1000
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
%FDR_low = sum(FD_low, 'all')/sum(ID_low, 'all');    %probability of false interrupt given interrupt detection
%FDR_med = sum(FD_med, 'all')/sum(ID_med, 'all');
%FDR_high = sum(FD_high, 'all')/sum(ID_high, 'all');
FDR_low =  sum(FD_low, 'all')/sum(ID_low, 'all');     %probability of false interrupt given interrupt detection
FDR_med = sum(FD_med, 'all')/sum(ID_med, 'all');
FDR_high = sum(FD_high, 'all')/sum(ID_high, 'all');

TID_low_Array(s,1) = sum(TID_low,'all')/1000;
TID_med_Array(s,1) = sum(TID_med,'all')/1000;
TID_high_Array(s,1) = sum(TID_high,'all')/1000;

FDR_low_array(s,1) = FDR_low;    
FDR_med_array(s,1) = FDR_med;
FDR_high_array(s,1) = FDR_high;

FN_low_array(s,1)=sum(FN_low,'all')/1000;    
FN_med_array(s,1)=sum(FN_med,'all')/1000; 
FN_high_array(s,1)=sum(FN_high,'all')/1000;

Opti_low(s,1)= FDR_low_array(s,1)+FN_low_array(s,1);    
Opti_med(s,1)=FDR_med_array(s,1)+FN_med_array(s,1);
Opti_high(s,1)=FDR_high_array(s,1)+FN_high_array(s,1);


end

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

%FDRfit_high = fit( T_high_array,FDR_high_array, 'poly3','normalize','on');
%FNfit_high = fit( T_high_array, FN_high_array,'poly3','normalize','on');

%FDRfit_med = fit( T_med_array, FDR_med_array,'poly3','normalize','on');
%FNfit_med = fit( T_med_array, FN_med_array,'poly3','normalize','on');

%FDRfit_low = fit( T_low_array,FDR_low_array,'poly3','normalize','on' );
%FNfit_low = fit( T_low_array,FN_low_array,'poly3','normalize','on' );


DataLoc = char(DataLoc);
figure(1)
subplot(2,1,1)
plot(T_low_array,FDR_low_array)
title('False Detection Rate: Low Sensitivity, %s')
xlabel('# of Threshold Standard Deviations, T')
ylabel('FDR')
grid on
subplot(2,1,2)
plot(T_low_array,FN_low_array)
title('False Negatives: Low Sensitivity,')
xlabel('# of Threshold Standard Deviations, T')
ylabel('FN')
suptitle(DataLoc)
grid on

figure(2)
subplot(2,1,1)
plot(T_med_array,FDR_med_array)
title('False Detection Rate: Medium Sensitivity,')
xlabel('# of Threshold Standard Deviations, T')
ylabel('FDR')
grid on
subplot(2,1,2)
plot(T_med_array,FN_med_array)
title('False Negatives: Medium Sensitivity,')
xlabel('# of Threshold Standard Deviations, T')
ylabel('FN/100')
suptitle(DataLoc)
grid on

figure(3)
subplot(2,1,1)
plot(T_high_array,FDR_high_array)
title('False Detection Rate: High Sensitivity,')
xlabel('# of Threshold Standard Deviations, T')
ylabel('FDR')
grid on
subplot(2,1,2)
plot(T_high_array,FN_high_array)
title('False Negatives: High Sensitivity,')
xlabel('# of Threshold Standard Deviations, T')
ylabel('FN/100')
suptitle(DataLoc)
grid on



%fit_high = fit( T_high_array,Opti_high, 'poly3','normalize','on');
%fit_med = fit( T_med_array, Opti_med,'poly3','normalize','on');
%fit_low = fit( T_low_array,Opti_low,'poly3','normalize','on' );

figure(4)
subplot(3,1,1)
plot(T_high_array,Opti_high)
%fit_high( 0.01 );
title('FDR+False Negatives: High Sensitivity,')
xlabel('Threshold stdev')
ylabel('Pr')
grid on

subplot(3,1,2)
plot(T_med_array,Opti_med)
%fit_med( 0.01 );
title('FDR+False Negatives: Med Sensitivity,')
xlabel('Threshold stdev')
ylabel('Pr')
grid on

subplot(3,1,3)
plot(T_low_array,Opti_low)
%fit_low( 0.01 );
title('FDR+False Negatives: Low Sensitivity, ')
xlabel('Threshold stdev')
ylabel('Pr')
suptitle(DataLoc)
grid on

figure(5)
scatter(FDR_low_array,TID_low_Array,'p','b')
xlabel('False Positives/Detections')
ylabel('False Negatives')
suptitle('Receiver Operating Characteristic, Low Sensitivity')
title(DataLoc)
xlim([0 1])
ylim([0 1])
grid on

figure(6)
scatter(FDR_med_array,TID_med_Array,'p','b')
xlabel('False Positives/Detections')
ylabel('False Negatives')
suptitle('Receiver Operating Characteristic, Medium Sensitivity')
title(DataLoc)
xlim([0 1])
ylim([0 1])
grid on

figure(7)
scatter(FDR_high_array,TID_high_Array,'p','b')
xlabel('False Positives/Detections')
ylabel('False Negatives')
suptitle('Receiver Operating Characteristic, High Sensitivity')
title(DataLoc)
xlim([0 1])
ylim([0 1])
grid on
