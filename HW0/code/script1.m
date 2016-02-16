% Problem 1: Image Alignment

%% 1. Load images (all 3 channels)
% red = [];
% green = [];
% blue = [];
clear;
clc;
close all;
reddata = load('../data/red.mat');
greendata = load('../data/green.mat');
bluedata = load('../data/blue.mat');
red = reddata.red;
green = greendata.green;
blue = bluedata.blue;
% red = load 'red';
% green = load 'green';
% blue = load 'blue';
% Red channel as 'red'
% Green channel as 'green'
% Blue channel as 'blue'
%% 2. Find best alignment
% Hint: Lookup the 'circshift' function
rgbResult = alignChannels(red, green, blue);

%% 3. Save result to rgb_output.jpg (IN THE "results" folder)
image(rgbResult);
save('')