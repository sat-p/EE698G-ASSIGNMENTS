%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% question8b.m
% Author : Satya Prakash Panuganti - 14610
% Assignment 1 - EE698G 2016-17
% 
% This program loads data points stored in the a file data_points_line.mat and
% expresses Y as a linear function of X using PCA (Oridinary Least Squares)
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

%%%%%%%%%%%%%%%%%%%%%%%%%%PCA_WHOLE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X_whole, Y_whole] = PCA (X, Y);

%%%%%%%%%%%%%%%%%%%%%%%%%%PCA_RANSAC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X_temp, Y_temp] = RANSAC (threshold,...
                           inlier_probability,...
                           inlier_set_probability,...
                           X, Y);

[X_RANSAC, Y_RANSAC] = PCA (X_temp, Y_temp);

%%%%%%%%%%%%%%%%%%%%%%%%%%Visualization%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hold on;

scatter(X, Y);

plot (X_whole,  Y_whole,  'r',...
      X_RANSAC, Y_RANSAC, 'g');

legend ({'points', 'PCA using whole data', 'PCA using only inliers'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%