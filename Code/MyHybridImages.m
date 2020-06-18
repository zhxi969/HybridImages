function hybrid=MyHybridImages(lowImage, lowSigma, highImage, highSigma) 
% MYHYBRIDIMAGES Create hybrid images by combining a low-pass and high-pass filtered pair. 
% C = MYHYBRIDIMAGES(lowImage, lowSigma, highImage, highSigma) returns the hybrid image created 
% by low-pass filtering lowImage with a Gaussian of s.d. lowSigma and combining it with 
% a high-pass image created by subtracting highImage from highImage convolved with 
% a Gaussian of s.d. highSigma % a Gaussian of s.d. highSigma
% 
% lowImage and highImage should both have size (rows,cols) or (rows,cols,channels). 
% The resultant image also has the same size 

%%
[~,~,l]=size(lowImage);
if l==3
    for i=1:3
        im1=double(lowImage(:,:,i))/255;
        kernel=makegaussiankernel(lowSigma);   
        conv_im1=MyConvolution(im1, kernel);
        im1_lowpass(:,:,i)=conv_im1;

        im2=double(highImage(:,:,i))/255;
        kernel=makegaussiankernel(highSigma);  
        im2_lowpass=MyConvolution(im2, kernel);
        im2_highpass(:,:,i)=im2-im2_lowpass;
    
    end
        hybrid=im1_lowpass+im2_highpass;
    %%
    
        figure,imshow(im1_lowpass,[]);
        figure,imshow(im2_highpass+0.5,[]);
        figure,imshow((im1_lowpass+im2_highpass),[]);
        for i=1:4
            figure,imshow(imresize(hybrid,1.5/i),[]);
        end
else
%     low_im1=rgb2gray(lowImage);
        im1=double(lowImage)/255;
        kernel=makegaussiankernel(lowSigma);  
        conv_im1=MyConvolution(im1, kernel);
        im1_lowpass=conv_im1;

%     high_im2=rgb2gray(highImage);
        im2=double(highImage)/255;
        kernel=makegaussiankernel(highSigma);   
        im2_lowpass=MyConvolution(im2, kernel);
        im2_highpass=im2-im2_lowpass;
        im2_highpass1=im2_highpass+0.5
        hybrid=im1_lowpass+im2_highpass1;
    %%
    
        figure,imshow(im1_lowpass,[]);
        figure,imshow(im2_highpass1+0.5,[]);
        figure,imshow((im1_lowpass+im2_highpass1),[]);
        for i=1:4
            figure,imshow(imresize(hybrid,1.5/i),[]);
        end
end

%%
function f=makegaussiankernel(sigma) 
% Use this function to create a 2D gaussian kernel with standard deviation sigma.
% The kernel values should sum to 1.0, and the size should be floor(8*sigma+1)
% floor(8*sigma+1)+1 (whichever is odd) as per the assignment specification.
% GaussianDieOff = .0001;
% sigma = 1;
% pw = 1:30; 
ssq = sigma^2;
% width = find(exp(-(pw.*pw)/(2*ssq))>GaussianDieOff,1,'last');
% if isempty(width)
%   width = 1;  
% end
size=8*sigma+1;
if mod(size,2) == 0
    size=size+1;
end

% GaussianKernels
t = (-(size-1)/2:(size-1)/2);
gau = exp(-(t.*t)/(2*ssq))/(sqrt(2*pi)*ssq); 
kernel = gau' * gau;  

kernel_sum=sum(sum(kernel));
kernel_normal=kernel/kernel_sum;

f = im2single(kernel_normal);