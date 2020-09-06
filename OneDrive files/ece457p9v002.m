%Senior Design ECE457 Project Group 9
%Fall 2019
clear all; clc; clf;

%Global Variables
n =6; %Number of data files
filenamelist = {'Book1.xlsx';'Book2.xlsx';'Book3.xlsx';'Book4.xlsx';'Book5.xlsx';'Marketplace DB'};
filearray = string(filenamelist);
%c=1;
sz = 36; %Size of scatterplot points
x = [30:0.1:110]; %Setting x axis for 'normpdf' plot
x1 = linspace(30,90,120);
DataMat = zeros(30,4); %Predefine Data Matrix
AllAveAmb = zeros(1,n);
AllStdAmb = zeros(1,n);
Std2Qui = zeros(1,n);
Std2Med = zeros(1,n);
Std2Lou = zeros(1,n);

QuiStdfromAmb = 0;
MedStdfromAmb = 0;
LouStdfromAmb = 0;
%Function
for c = 1:n
        SoundData = filearray(c,1); %Read excel file in folder



        DataMat(:,1,c) = xlsread(filearray(c,1), 'A2:A31'); %Ambient 1st col
        DataMat(:,2,c) = xlsread(filearray(c,1), 'B2:B31'); %Quiet is 2nd col
        DataMat(:,3,c) = xlsread(filearray(c,1), 'C2:C31'); %Medium is 3rd col
        DataMat(:,4,c) = xlsread(filearray(c,1), 'D2:D31'); %Loud is 4th col
        [k,DataLoc] = xlsread(filearray(c,1), 'E1:E1');


        AveAmb = mean(DataMat(:,1,c)); %Calculate Averages
        AveQui = mean(DataMat(:,2,c));
        AveMed = mean(DataMat(:,3,c));
        AveLou = mean(DataMat(:,4,c));
        StdAmb = std(DataMat(:,1,c));
        StdQui = std(DataMat(:,2,c)); %Calculate Standard Deviations
        StdMed = std(DataMat(:,3,c));
        StdLou = std(DataMat(:,4,c));
        
        %Number of standard deviations from Ambient
        %Calculating running total number of standard deviations from Ambient 
        QuiStdfromAmb = QuiStdfromAmb + (AveQui - AveAmb)/StdAmb; 
        MedStdfromAmb = MedStdfromAmb + (AveMed - AveAmb)/StdAmb;        
        LouStdfromAmb = LouStdfromAmb + (AveLou - AveAmb)/StdAmb;     
        
        
        Labels = {'Ambient';'Quiet';'Medium';'Loud'};
        Averages = {AveAmb; AveQui; AveMed; AveLou};
        Stdevs = {StdAmb; StdQui; StdMed; StdLou};

        AllAveAmb(1,c) = AveAmb;
        AllStdAmb(1,c) = StdAmb;
        Std2Qui(1,c) = (AveQui - AveAmb)./StdAmb;
        Std2Med(1,c) = (AveMed - AveAmb)./StdAmb;
        Std2Lou(1,c) = (AveLou - AveAmb)./StdAmb;
        
        GauAmb = normpdf(x,AveAmb,StdAmb);
        GauQui = normpdf(x,AveQui,StdQui);
        GauMed = normpdf(x,AveMed,StdMed);
        GauLou = normpdf(x,AveLou,StdLou);
        
        %%%%%%%%%%%%%%%PLOTTING%%%%%%%%%%%%%%%
        DataLoc %Print Data Location to command window
        T = table(Labels, Averages, Stdevs) %Print Data Table to Command Window
         
        figure(c), subplot(2,1,1)
        hold on
        scatter(1:30, DataMat(:,1,c), sz, 'r') %Ambient
        scatter(1:30, DataMat(:,2,c), sz, 'g') %Quiet
        scatter(1:30, DataMat(:,3,c), sz, 'b') %Medium
        scatter(1:30, DataMat(:,4,c), sz, 'k') %Loud
        ylim([30 110])
        title(DataLoc)
        xlabel('Trials')
        ylabel('Volume Level in dB')
        legend({'Ambient','Quiet','Medium','Loud'},'Location','northwest','NumColumns',4)
        hold off

        subplot(2,1,2)
        hold on
        plot(x,GauAmb, 'r')
        plot(x,GauQui, 'g')
        plot(x,GauMed, 'b')
        plot(x,GauLou, 'k')
        ylabel('Probability')
        xlabel('Volume Level in dB')
        legend({'Ambient','Quiet','Medium','Loud'},'Location','northwest','NumColumns',4)
        title(DataLoc)
        ylim([-0.02 1])
        hold off   

end


        QuiStdfromAmb = QuiStdfromAmb/n 
        MedStdfromAmb = MedStdfromAmb/n        
        LouStdfromAmb = LouStdfromAmb/n  
        
        
AllAveAmb
AllStdAmb

figure(n+1)
hold on
scatter(AllAveAmb, AllStdAmb, sz, 'r') %Ambient

%scatter(AllAveAmb, Std2Qui, sz, 'g') %Quiet
%scatter(AllAveAmb, Std2Med, sz, 'b') %Medium
%scatter(AllAveAmb, Std2Lou, sz, 'k') %Loud
hold off
%ylim([0 15])
title('Standard Deviation with respect to Average Ambient Level')
xlabel('Ambient Level')
ylabel('Standard Deviation')
%DataMat %Print Data Matrix to command window

