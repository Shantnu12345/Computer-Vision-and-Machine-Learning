function [MeanM,CoVariance] = FindMeanCovariance(x0,y0,vx0,vy0,ax0,ay0)
% Finds mean and covraince for points on the ball
% On input:
%       x0 (float): initial x locaiton
%       y0 (float): initial y location
%       vx0 (float): initial x speed
%       vy0 (float): initial y speed
%       ax0 (float): x acceleration
%       ay0 (float): y acceleration
% On Output:
%       Mean (float) (n X 1)
%       CoVariance (n X n)
  load('A10_data.mat');    
  im = Falling_Ball(1).cdata;
[nr,nc,nd] = size(im);
temp_im = zeros(nr,nc);
model = [230,30,30];
for r = 1:nr
    for c = 1:nc
       if im(r,c,1) > model(1) & im(r,c,2) < model(2) & im(r,c,3) < model(3)
           temp_im(r,c) = 1;
       end
    end
end
% [row,col] = find(temp_im==1);
% Mean= mean([row,col]);
% Mean = [Mean, vx0,vy0,ax0,ay0];
% 
% xCordinate = Mean(2);
% yCordinate = nr - Mean(1) + 1;
% Mean(1) = xCordinate;
% Mean(2) = yCordinate;

%%%%
[row,col] = find(temp_im==1);
NumOfObservations = length(row);
xCoord = col;
yCoord = nr*ones(NumOfObservations,1) - row + ones(NumOfObservations,1);
MeanM= mean([xCoord,yCoord]);
MeanM = [MeanM, vx0,vy0,ax0,ay0];


%%%%

Temp = zeros(NumOfObservations,6);
Temp(:,1) = xCoord;
Temp(:,2) = yCoord;
Temp(:,6) = ay0 * ones(NumOfObservations,1);
CoVariance = cov(Temp);
  