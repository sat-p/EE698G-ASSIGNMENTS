%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% question8a.m
% Author : Satya Prakash Panuganti - 14610
% Assignment 1 - EE698G 2016-17
% 
% This program loads data points stored in the a file data_points_line.mat and
% expresses Y as a linear function of X using OLS (Oridinary Least Squares)
% after applying the RANSAC algorithm to obtain the coefficients of the line.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%PARAMETERS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

threshold = 1.0;
outlier_probability = 0.1;
inlier_probability = 1 - outlier_probability;
inlier_set_probability = 0.99;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load '../data/data_points_line.mat'

X = points (: , 1);
Y = points (: , 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%OLS_WHOLE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X_whole, Y_whole] = OLS (X, Y);

%%%%%%%%%%%%%%%%%%%%%%%%%%OLS_RANSAC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X_temp, Y_temp] = RANSAC (threshold,...
                           inlier_probability,...
                           inlier_set_probability,...
                           X, Y);

[X_RANSAC, Y_RANSAC] = OLS (X_temp, Y_temp);

%%%%%%%%%%%%%%%%%%%%%%%%%%Visualization%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hold on;

scatter(X, Y);

plot (X_whole,  Y_whole,  'r',...
      X_RANSAC, Y_RANSAC, 'g');

legend ({'points', 'LS using whole data', 'LS using only inliers'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%