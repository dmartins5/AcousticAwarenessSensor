%Senior Design ECE457 Project Group 9
%Fall 2019
clear all; clc; clf;



N = 200;
ambientmin = 30;
ambientmax = 60;
amb4 = (ambientmax - ambientmin)*rand*1.72;
DataMat = zeros(1,N); %Predefine Data Matrix

for k=1:N
    
    
    DataMat = amb4*round(rand(1,N));

end
DataMat %Print Data Matrix to command window



AveAmb = mean(DataMat(:,1)); %Calculate Averages
AveQui = mean(DataMat(:,2));
AveMed = mean(DataMat(:,3));
AveLou = mean(DataMat(:,4));
StdAmb = std(DataMat(:,1));
StdQui = std(DataMat(:,2)); %Calculate Standard Deviations
StdMed = std(DataMat(:,3));
StdLou = std(DataMat(:,4));