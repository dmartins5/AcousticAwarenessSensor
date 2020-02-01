% This is an initial program to average for the 10-bit ADC

%Jared Alves and Michael Benker
%%

%SUBARRAY AVERAGE FUNCTION

%100 samples/sec

samples_vec = rand(1, 200); %Create random data of 400 points (row vector)

sz = size(samples_vec,2); %calculate data array size

n = 10*x; %select number of samples for each subarray

z = sz/n; %number of additions to perform

result = 0;

for h = 0:z
    [avg,subarray] = subarrayavg(samples_vec, n,1+h*n)
    
    n= n*2;
    
    result = result + avg;  %CONTINUOUSLY ADD AVERAGES
    
end