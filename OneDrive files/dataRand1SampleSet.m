%Senior Design ECE457 Project Group 9
%Fall 2019
clear all; clc; clf;


sets = 100;
N = 30;
ambientmin = 30;
ambientmax = 60;

DataMat = zeros(N,1); %Predefine Data Matrix
TotalData = zeros(N, sets);
number = 0;
amb4 = 0;
for c = 1:sets
    for k=1:N
   
        amb4 = abs((ambientmax - ambientmin)*(randn+1));
        TotalData(k,c) = amb4;
        
        
    end
    
    

end

TotalData %Print Data Matrix to command window



AveAmb = mean(TotalData(:,1)); %Calculate Averages

StdAmb = std(TotalData(:,1)); %Calculate Standard Deviation



