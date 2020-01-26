% This is an initial program to write to the ADC of the microcontroller

%Jared Alves and Michael Benker
%%

%SUBARRAY AVERAGE FUNCTION

samples_vec = rand(1, 200); %Create random data of 200 points (row vector)

sz = size(samples_vec); %calculate data array size

n = 10; %select number of samples for each subarray

z = sz/n; %number of additions to perform

for h = 1:z
    result = subarrayavg(samples_vec, n, h*n)
    
    x = result;
    
    result = result + x;  %CONTINUOUSLY ADD AVERAGES
    
end
    