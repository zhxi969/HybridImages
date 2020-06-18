clear 
close all
clc




%%
lowImage=imread('1.jpg');

lowSigma=1;  % Low-pass

highImage=imread('2.jpg');
highSigma=6;   % High-pass


hybrid = MyHybridImages(lowImage, lowSigma, highImage, highSigma);

