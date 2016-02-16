function [rgbResult] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a 
%       color image, compute the best aligned result with minimum 
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%   corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here
% stratgy
%%  Moving upside or downside to adjust image.
    width = size(red,2);
    height = size(red,1);
% expand original channel, truncate it then which makes them "moving" upside down.
    mod_green = [zeros(30,width);green;zeros(30,width)];
    mod_blue = [zeros(30,width);blue;zeros(30,width)];
% red channel stay still as calibration.
    red_big = reshape(red, width*height,1);
    green_big = reshape(green,width*height,1);
    blue_mine = repmat(reshape(blue,[],1),1,61);
% using for loop to expand matrix
% prepare to compute SSD for different alignment.
    for i = 1:1:30
        greenup = reshape(mod_green(31-i:30-i+height,:),[],1);
        greendown = reshape(mod_green(31+i:30+i+height,:),[],1);
        blueup = reshape(mod_blue(31-i:30-i+height,:),[],1);
        bluedown = reshape(mod_blue(31+i:30+i+height,:),[],1);
        green_big = [greendown green_big greenup];
        blue_mine = [repmat(blueup,1,61) blue_mine repmat(bluedown,1,61)];
    end
% expand red and green channels to the same size
    red_big = repmat(red_big,1,61*61);
% expand green to the same size
    green_big = repmat(green_big,1,61);
% compute SSD for all possible alignment
    ssdupdwon = sum(abs(red_big - blue_mine) + abs(green_big - blue_mine) + abs(red_big - green_big));
% find out the minimum alignment
    [~, index] = min(ssdupdwon);
% reshape three channels.
    red_rev = reshape(red_big(:,index),height,width);
    blue_rev = reshape(blue_mine(:,index),height,width);
    green_rev = reshape(green_big(:,index),height,width);
%% moving image channels towards left or right
    mod2_green = [zeros(height,30) green_rev zeros(height,30)];
    mod2_blue = [zeros(height,30) blue_rev zeros(height,30)];
    red_big2 = reshape(red_rev, [],1);
    green_big2 = reshape(green_rev,[],1);
    blue_mine2 = repmat(reshape(blue_rev,[],1),1,61);
% using for loop to expand matrix
% prepare to compute SSD for different alignment.
    for i = 1:1:30
        greenleft = reshape(mod2_green(:,31-i:30-i+width),[],1);
        greenright = reshape(mod2_green(:,31+i:30+i+width),[],1);
        blueleft = reshape(mod2_blue(:,31-i:30-i+width),[],1);
        blueright = reshape(mod2_blue(:,31+i:30+i+width),[],1);
        green_big2 = [greenleft green_big2 greenright];
        blue_mine2 = [repmat(blueleft,1,61) blue_mine2 repmat(blueright,1,61)];
    end
% expand red and green channels to the same size
    red_big2 =repmat(red_big2,1,61*61);
    green_big2 = repmat(green_big2,1,61);
% compute all possible channels.
    ssdleftright = sum(abs(red_big2 - blue_mine2) + abs(green_big2 -blue_mine2) + abs(red_big2 - green_big2));
% find out minimum.
    [~, index2] = min(ssdleftright);
% reshape three channasl.
    red_rev2 = reshape(red_big2(:,index2),height,width);
    blue_rev2 = reshape(blue_mine2(:,index2),height,width);
    green_rev2 = reshape(green_big2(:,index2),height,width);
% restore image
    rgb_output(:,:,1) = red_rev2;
    rgb_output(:,:, 2) = green_rev2;
    rgb_output(:,:,3) = blue_rev2;
    rgbResult = rgb_output;
end