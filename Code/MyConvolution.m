function convolved=MyConvolution(image, kernel)
% MYCONVOLUTION Convolve an image with a kernel % MYCONVOLUTION Convolve an image with a kernel
% C = MYCONVOLUTION(image,kernel) returns the two-dimensional convolution 
% of matrices image and kernel assuming zero-padding of the image to handle the borders. 
% 
% image should have size (rows,cols) or (rows,cols,channels) 
% kernel should have size (krows,kcols); both dimensions odd 

[rows,cols] = size(image);       
kernel=double(kernel);
[height,width] = size(kernel);
temp = zeros(rows+height,cols+width);  
convolved = zeros(rows,cols); 

%% 

temp((height-1)/2+1:rows+(height-1)/2,(width-1)/2+1:cols+(width-1)/2) = image; % Old-Image

for q = 1:rows+height  
%     for p = (width-1)/2+1:cols+(width-1)/2
        if(q<(height-1)/2+1) 
            temp(q,:) = 0;
        end
        if(q>rows+(height-1)/2) 
            temp(q,:) = 0; 
        end
%     end
end

% for q = 1:rows+height
    for p = 1:cols+width
        if(p<(width-1)/2+1) 
            temp(:,p) = 0; 
        end
        if(p>cols+(width-1)/2) 
            temp(:,p) = 0; 
        end
    end
% end

%% FFT
x_kernel=diag(sqrt(kernel));
y_kernel=diag(sqrt(kernel))';

% for q = (height-1)/2+1:rows+(height-1)/2  
for p = 1:cols        % x-axis
    convolved(:,p)=temp((height-1)/2+1:rows+(height-1)/2,p:p+(width-1))*x_kernel;
end
% end
temp((height-1)/2+1:rows+(height-1)/2,(width-1)/2+1:cols+(width-1)/2)=convolved;

% for p = (width-1)/2+1:cols+(width-1)/2      
for q = 1:rows          % y-axis
    convolved(q,:)=y_kernel*temp(q:q+(height-1),(width-1)/2+1:cols+(width-1)/2);
end


% end
