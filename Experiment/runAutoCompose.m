function r=practical5a
%The goal of this practical is to investigate dynamic progamming along
%scanlines in stereo vision.  In this part of the practical, we build a
%basic dynamic programming algorithm, which will solve the same problem as
%presented in the notes.  
%In practical 5b we will apply this to the stereo problem.  


%Use the template below, filling in parts marked "TO DO".
% Note: Optionally, you may want to move the function-skeleton
%       function bestPath = dynamicProgram(unaryCosts, pairwiseCosts)...
% from below into its own new and separate dynamicProgram.m file, for 
% easier debugging and re-use.

%close any previous figures;
close all;

%define unary costs : unaryCosts(d,j) represents the cost for having
%disparity d at pixel j.
% unaryCosts = [2.0 1.1 5.7 1.5 6.0 3.1 ;...
%               0.8 4.8 1.0 3.0 6.9 3.3 ;...
%               4.3 2.3 2.4 2.4 6.6 6.2 ;...
%               6.4 0.0 6.1 0.8 7.1 2.1 ;...
%               2.3 2.2 4.9 8.9 1.0 9.8 ];

unaryCosts = abs(rand(10)*50);

%define pairwise costs:  pairwiseCosts(a,b) represents the cost for changing from 
%disparity level A at pixel j to disparity level B at pixel j+1;
% pairwiseCosts = [   0   2 100 100 100;...
%                     2   0   2 100 100;...
%                   100   2   0   2 100;...
%                   100 100   2   0   2;...
%                   100 100 100   2   0];
pairwiseCosts = ones(size(unaryCosts))*100;
for i = 3:size(unaryCosts,1)
    pairwiseCosts(i,i) = 0;
    pairwiseCosts(i-1,i) = 2;
    pairwiseCosts(i,i-1) = 2;
    pairwiseCosts(i-2,i) = 2;
    pairwiseCosts(i,i-2) = 2;
end
pairwiseCosts(1,1)=0;
pairwiseCosts(2,2)=0;
pairwiseCosts(1,2)=2;
pairwiseCosts(2,1)=2;

%Now, use dynamic programming to find best solution.
%TO DO - fill in this routine (further down in this file).
bestPath = dynamicProgram(unaryCosts,pairwiseCosts);

%display the nodes
figure; set(gcf,'Color',[1 1 1]);
[nY nX] = size(unaryCosts);
for(cY = 1:nY)
    for (cX = 1:nX)
        plot(cX,cY,'r.','MarkerSize',20); hold on;
        text(cX+0.1,cY+0.1,sprintf('%1.1f',unaryCosts(cY,cX)));
        axis off;set(gca,'YDir','reverse');
    end;
end;

%display the best path
plot(1:nX,bestPath,'b-');

%calculate the cost of the path computed
%bestPathCostUnary = sum(unaryCosts(bestPath+(0:nX-1)*nY));
%bestPathCostPairwise = sum(pairwiseCosts(bestPath(1:end-1)+nY*(bestPath(2:end)-1)));
%bestCost = bestPathCostUnary+bestPathCostPairwise;
%fprintf('Path Cost = %3.3f\n',bestCost);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Compose!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
notecreate = @(frq,dur) sin(2*pi* [1:dur]/8192 * (440*2.^((frq-1)/12)));
notename = {'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#'};

songidx = bestPath;
dur = 0.3*8192;
songnote = [];
for k1 = 1:length(songidx)
    songnote = [songnote; [notecreate(songidx(k1),dur)  zeros(1,75)]'];
end
soundsc(songnote, 8192);
  
pause(size(songidx,2)/2);

songidx = songidx+1;
songnote = [];
for k1 = 1:length(songidx)
    songnote = [songnote; [notecreate(songidx(k1),dur)  zeros(1,75)]'];
end
soundsc(songnote, 8192)