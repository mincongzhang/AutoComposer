function r=practical5b
%The goal of this part of the practical is to use the dynamic programming
%routine that you developed in the first part to solve the dense stero
%problem.  Use the template below, filling in parts marked "TO DO".

%close any previous figures;
close all;

%load in images and ground truth
load('StereoData.mat','im1','im2','gt');

%ground truth disparity is originally expressed in 16'ths of pixels but we 
%will only consider whole-pixel shifts
gtDisp = round(gt/16);

%display image
figure; set(gcf,'Color',[1 1 1]);
subplot(1,2,1); imagesc(im1); axis off; axis image; colormap(gray);
subplot(1,2,2); imagesc(im2); axis off; axis image; colormap(gray);

%figure out size of image
[imY imX] = size(im1);

%define maximum disparity 
maxDisp = 5;

%set up pairwiseCosts - we will define a fixed cost of alpha for changing
%disparity or zero cost for staying the same
alpha = 1;
pairwiseCosts = alpha*ones(maxDisp,maxDisp)-alpha*eye(maxDisp,maxDisp);

%initialize the disparity map that we will estimate
estDisp = zeros(imY,imX-maxDisp);


%define standard deviation of noise
noiseSD = 6;

%display ground truth and estimated disparity
figure; set(gcf,'Color',[1 1 1]);
subplot(1,2,1); imagesc(gtDisp,[0 11]); axis off; axis image; colormap(gray); colorbar;
title('Ground Truth');

%run through each line of image
for (cY = 1:imY)
    fprintf('Procesing scanline %d\n',cY);
    %define unary costs - we will not use the last few columns of the
    %image as the disparity might map the pixel outside the valid area of
    %the second image
    unaryCosts = zeros(maxDisp,imX-maxDisp);
    for(cDisp = 1:maxDisp)
        for (cX = 1:imX-maxDisp)
            %TO DO - calculate cost for this disparity. This is the 
            %negative log likelihood, where the likelihood is a Gaussian
            %with a mean of the value (i.e. intensity) at the offset pixel 
            %in image2 and a standard deviation of "noiseSD". 
            mean = im2(cY,cX);
            std = noiseSD;
            %1/(std*sqrt(2*pi))*exp(-(x-mean)^2/(2*std^2))
            unaryCosts(cDisp,cX) = -log(1/(std*sqrt(2*pi))*exp(-(im1(cY,cX+cDisp)-mean)^2/(2*std^2)));
            end;
    end;
    
    %TO DO call the routine that you wrote in the previous section (copy it
    %below into the bottom of this file)
    estDisp(cY,:) = dynamicProgram(unaryCosts,pairwiseCosts);
    
    %display solution so far
    subplot(1,2,2); imagesc(estDisp,[0 11]); axis off; axis image; colormap(gray); colorbar;
    title('Estimated Disparity');
    drawnow;
end;


%TO DO - investigate how different values of alpha and noiseSD affect the results

%TO DO (optional) - you should be able to rewrite this with fewer loops once you have
%the general idea so that it runs faster

%TO DO (optional)- adapt the algorithm so that it makes use of colour
%information




 




 