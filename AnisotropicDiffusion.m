function AnisotropicDiffusion(image,kappa,lambda,no_itr)
% In this code I have implemented Anisotropic Filtering via both the 2 ways 
% used to calculate the value of c(x,y,t). The final output is the
% comparison of the orginal image to the output via method 1 and method 2.

% Reading the image parameters
[len,brd,channels] = size(image);
% Converting the image to B/W if necessary
if channels>1
    image = rgb2gray(image);
end
% Converting image to double for further calculation
image = im2double(image);

% Creating matrices for gradient calculation via method 1
left_m1 = zeros(len,brd,'double');
right_m1 = zeros(len,brd,'double');
top_m1 = zeros(len,brd,'double');
down_m1 = zeros(len,brd,'double');
topleft_m1 = zeros(len,brd,'double');
topright_m1 = zeros(len,brd,'double');
downleft_m1 = zeros(len,brd,'double');
downright_m1 = zeros(len,brd,'double');
% Creating c matrices for calculation via method 1
c_left_m1 = zeros(len,brd,'double');
c_right_m1 = zeros(len,brd,'double');
c_top_m1 = zeros(len,brd,'double');
c_down_m1 = zeros(len,brd,'double');
c_topleft_m1 = zeros(len,brd,'double');
c_topright_m1 = zeros(len,brd,'double');
c_downleft_m1 = zeros(len,brd,'double');
c_downright_m1 = zeros(len,brd,'double');

% Creating matrices for gradient calculation via method 2
left_m2 = zeros(len,brd,'double');
right_m2 = zeros(len,brd,'double');
top_m2 = zeros(len,brd,'double');
down_m2 = zeros(len,brd,'double');
topleft_m2 = zeros(len,brd,'double');
topright_m2 = zeros(len,brd,'double');
downleft_m2 = zeros(len,brd,'double');
downright_m2 = zeros(len,brd,'double');
% Creating c matrices for calculation via method 1
c_left_m2 = zeros(len,brd,'double');
c_right_m2 = zeros(len,brd,'double');
c_top_m2 = zeros(len,brd,'double');
c_down_m2 = zeros(len,brd,'double');
c_topleft_m2 = zeros(len,brd,'double');
c_topright_m2 = zeros(len,brd,'double');
c_downleft_m2 = zeros(len,brd,'double');
c_downright_m2 = zeros(len,brd,'double');

% Creating 2 replicas of the original image for calculation
image_1 = image;
image_2 = image;

% Iterating to calculate the result
for k = 1:no_itr
    % Padding dummy matrices for gradient calculation
    img1 = padarray(image_1,[1 1],0,'both');
    img2 = padarray(image_2,[1 1],0,'both');
    
    %Gradient claculation for method 1
    for i = 2:len+1
        for j = 2:brd+1
            left_m1(i-1,j-1) = img1(i,j-1)-img1(i,j);
            right_m1(i-1,j-1) = img1(i,j+1)-img1(i,j);
            top_m1(i-1,j-1) = img1(i-1,j)-img1(i,j);
            down_m1(i-1,j-1) = img1(i+1,j)-img1(i,j);
            topleft_m1(i-1,j-1) = img1(i-1,j-1)-img1(i,j);
            topright_m1(i-1,j-1) = img1(i-1,j+1)-img1(i,j);
            downleft_m1(i-1,j-1) = img1(i+1,j-1)-img1(i,j);
            downright_m1(i-1,j-1) = img1(i+1,j+1)-img1(i,j);
        end
    end
    % c calculation via method 1
    c_left_m1 = exp(-((abs(left_m1)/kappa).^2));
    c_right_m1 = exp(-((abs(right_m1)/kappa).^2));
    c_top_m1 = exp(-((abs(top_m1)/kappa).^2));
    c_down_m1 = exp(-((abs(down_m1)/kappa).^2));
    c_topleft_m1 = exp(-((abs(topleft_m1)/kappa).^2));
    c_topright_m1 = exp(-((abs(topright_m1)/kappa).^2));
    c_downleft_m1 = exp(-((abs(downleft_m1)/kappa).^2));
    c_downright_m1 = exp(-((abs(downright_m1)/kappa).^2));
    % Iterative image update via method 1
    image_1 = image_1 + lambda.*(left_m1.*c_left_m1 + right_m1.*c_right_m1 + top_m1.*c_top_m1 + down_m1.*c_down_m1 + topleft_m1.*c_topleft_m1 + topright_m1.*c_topright_m1 + downleft_m1.*c_downleft_m1 + downright_m1.*c_downright_m1);
    
    %Gradient claculation for method 2
    for i = 2:len+1
        for j = 2:brd+1
            left_m2(i-1,j-1) = img2(i,j-1)-img2(i,j);
            right_m2(i-1,j-1) = img2(i,j+1)-img2(i,j);
            top_m2(i-1,j-1) = img2(i-1,j)-img2(i,j);
            down_m2(i-1,j-1) = img2(i+1,j)-img2(i,j);
            topleft_m2(i-1,j-1) = img2(i-1,j-1)-img2(i,j);
            topright_m2(i-1,j-1) = img2(i-1,j+1)-img2(i,j);
            downleft_m2(i-1,j-1) = img2(i+1,j-1)-img2(i,j);
            downright_m2(i-1,j-1) = img2(i+1,j+1)-img2(i,j);
        end
    end
    % c calculation via method 2
    c_left_m2 = 1./(1+((abs(left_m2)/kappa).^2));
    c_right_m2 = 1./(1+((abs(right_m2)/kappa).^2));
    c_top_m2 = 1./(1+((abs(top_m2)/kappa).^2));
    c_down_m2 = 1./(1+((abs(down_m2)/kappa).^2));
    c_topleft_m2 = 1./(1+((abs(topleft_m2)/kappa).^2));
    c_topright_m2 = 1./(1+((abs(topright_m2)/kappa).^2));
    c_downleft_m2 = 1./(1+((abs(downleft_m2)/kappa).^2));
    c_downright_m2 = 1./(1+((abs(downright_m2)/kappa).^2));
    % Iterative image update via method 2
    image_2 = image_2 + lambda.*(left_m2.*c_left_m2 + right_m2.*c_right_m2 + top_m2.*c_top_m2 + down_m2.*c_down_m2 + topleft_m2.*c_topleft_m2 + topright_m2.*c_topright_m2 + downleft_m2.*c_downleft_m2 + downright_m2.*c_downright_m2);
end

% Displaying Images for Comparison
figure
subplot(1,3,1), imshow(image,[]), title('Original Image')
subplot(1,3,2), imshow(image_1,[]), title('Output Method 1')
subplot(1,3,3), imshow(image_2,[]), title('Output Method 2')
end