%Senior Design ECE457 Project Group 9
%Fall 2019

SoundData1 = 'Book1.xlsx'; %Read excel file in folder
DataMat = zeros(30,4); %Predefine Data Matrix
DataMat(:,1,1) = xlsread(SoundData1, 'A2:A31'); %Ambient 1st col
DataMat(:,2,1) = xlsread(SoundData1, 'B2:B31'); %Quiet is 2nd col
DataMat(:,3,1) = xlsread(SoundData1, 'C2:C31'); %Medium is 3rd col
DataMat(:,4,1) = xlsread(SoundData1, 'D2:D31'); %Loud is 4th col
[k,DataLoc] = xlsread(SoundData1, 'E1:E1');
DataLoc
DataMat %Print Data Matrix to command window


AveAmb = mean(DataMat(:,1)); %Calculate Averages
AveQui = mean(DataMat(:,2));
AveMed = mean(DataMat(:,3));
AveLou = mean(DataMat(:,4));
StdAmb = std(DataMat(:,1));
StdQui = std(DataMat(:,2)); %Calculate Standard Deviations
StdMed = std(DataMat(:,3));
StdLou = std(DataMat(:,4));
Labels = {'Ambient';'Quiet';'Medium';'Loud'};
Averages = {AveAmb; AveQui; AveMed; AveLou};
Stdevs = {StdAmb; StdQui; StdMed; StdLou};
T = table(Labels, Averages, Stdevs) %Print Data Table to Command Window

x = [20:0.1:130]; %Setting x axis for 'normpdf' plot
GauAmb = normpdf(x,AveAmb,StdAmb);
GauQui = normpdf(x,AveQui,StdQui);
GauMed = normpdf(x,AveMed,StdMed);
GauLou = normpdf(x,AveLou,StdLou);

sz = 36; %Size of scatterplot points
figure(1), subplot(2,1,1)
hold on
scatter(1:30, DataMat(:,1), sz, 'r') %Ambient
scatter(1:30, DataMat(:,2), sz, 'g') %Quiet
scatter(1:30, DataMat(:,3), sz, 'b') %Medium
scatter(1:30, DataMat(:,4), sz, 'k') %Loud
ylim([30 130])
title(DataLoc)
xlabel('Trials')
ylabel('Volume Level in dB')
legend({'Ambient','Quiet','Medium','Loud'},'Location','northwest','NumColumns',4)
hold off

x = [20:0.1:130]; %Setting x axis for 'normpdf' plot
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
ylim([-0.02 1.4])
hold off