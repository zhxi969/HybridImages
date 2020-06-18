clear 
close all
clc

%%
lowImage=imread('kaisa.bmp');
% lowImage=rgb2gray(lowImage);
lowSigma=3;  % Low-pass

highImage=imread('vn.bmp');
highSigma=3;   % High-pass
% highImage=rgb2gray(highImage);

hybrid = MyHybridImages(lowImage, lowSigma, highImage, highSigma);



