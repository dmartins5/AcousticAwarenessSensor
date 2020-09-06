%Senior Design ECE457 Project Group 9
%Fall 2019
%Random Sound Level Analyzer ECE457
clf;clear all; clc; close all;

%%%%%%%%%%% USER MANIPUTLATION %%%%%%%%%%%%%%%
sdevs = 3; %How many standard deviations?
sets = 1000000; %How many data sets?
N = 300; %Now many trials in a set?
ambmin = 0; %Base ambient minimum
ambcenter = 100000; %adds variation to the ambient by set
sz = 36; %Size of scatter circles


%%%%%%%%%CALCULATIONS%%%%%%%%%%%%%%%%%%%%%%%%
x = [30:0.1:110]; %Setting x axis for 'normpdf' plot
x1 = linspace(30,90,sets);
DataMat = zeros(N,1); %Predefine Data Matrix
TotalData = zeros(N, sets);
number = 0;
amb4 = 0;
AllAveAmb = zeros(1,sets);
AllStdAmb = zeros(1,sets);
AllAveplus3std = zeros(1,sets);

for c = 1:sets
    amb54 = ambmin+ ambcenter*rand;
    for k=1:N
        amb4 = amb54+amb54*rand/6;%amb54+amb54*rand*rand/8;
        TotalData(k,c) = amb4;        
    end
        AveAmb = mean(TotalData(:,c)); %Calculate Averages
        StdAmb = std(TotalData(:,c)); %Calculate Standard Deviations
    AllAveAmb(1,c) = AveAmb;
    AllStdAmb(1,c) = StdAmb;      
end

AllAveplus3std = AllAveAmb+sdevs.*AllStdAmb;
aveallave = mean(AllAveAmb)%Gaussian of all ambients
stdallstd = std(AllAveAmb)
meanplusXstd = aveallave + sdevs*stdallstd
GauAmbient = normpdf(x,aveallave,stdallstd);

%%%%%%%%%%PLOTTING%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
scatter(AllAveAmb, AllStdAmb, sz, 'r') %Ambient
title('Standard Deviation with respect to Average Ambient Level')
xlabel('Ambient Level')
ylabel('Standard Deviation')

figure(2)
hold on
plot(x1,AllAveAmb, 'r')
plot(x1,AllAveplus3std, 'g')
title('Average Ambient Level versus +X std. level per trial')
xlabel('Trial')
ylabel('Ambient Level')
legend({'Ambient','Ambient + X std'},'Location','northwest','NumColumns',1)
hold off

figure(3)
hold on
plot(AllAveAmb,AllAveplus3std)
hold off
%xlim([30 90])
%ylim([30 90])
set(gca,'XScale','log')
grid on
title('Ambient vs. Ambient + X Standard Deviations')
xlabel('Ambient Level')
ylabel('Ambient + X Standard Deviations')
legend({'Difference of X standard Devs'},'Location','northeast','NumColumns',1)

figure(4)
hold on
plot(x,GauAmbient, 'r')
xline(meanplusXstd, 'g')
hold off
title('Average Ambient Level versus +X std. level per trial')
xlabel('Ambient Level')
ylabel('Probability Distribution')
legend({'Ambient','Average + X std'},'Location','northeast','NumColumns',1)

%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
