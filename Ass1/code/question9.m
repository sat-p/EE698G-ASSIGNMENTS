%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% question9.m
% Author : Satya Prakash Panuganti - 14610
% Assignment 1 - EE698G 2016-17
% 
% This program loads data points stored in the a file data_points_plane.mat and
% obatins the the best fitting plane from the point cloud data using OLS
% (Ordinary Least Squares) after applying the RANSAC algorithm to obtain the
% coefficients of the plane. The OLS function assumes that the Z is the
% independent variable.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear all; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%PARAMETERS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

threshold = 5.0;
outlier_probability = 0.1;
inlier_probability = 1 - outlier_probability;
inlier_set_probability = 0.99;
points_in_fit = 25;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load '../data/data_points_plane.mat'

X = points (: , 1);
Y = points (: , 2);
Z = points (: , 3);

%%%%%%%%%%%%%%%%%%%%%%%%%%OLS_WHOLE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[c_whole, a_whole, b_whole] = OLS3 (X, Y, Z);

%%%%%%%%%%%%%%%%%%%%%%%%%%OLS_RANSAC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X_temp, Y_temp, Z_temp] =    RANSAC3 (threshold,...
                                       inlier_probability,...
                                       inlier_set_probability,...
                                       X, Y, Z);
                                   
[X_temp_, Y_temp_, Z_temp_] = RANSAC3_OLS (threshold,...
                                           inlier_probability,...
                                           inlier_set_probability,...
                                           points_in_fit,...
                                           X, Y, Z);
                                       
[c_RANSAC,  a_RANSAC,  b_RANSAC]  = OLS3 (X_temp,  Y_temp,  Z_temp);
[c_RANSAC_, a_RANSAC_, b_RANSAC_] = OLS3 (X_temp_, Y_temp_, Z_temp_);

%%%%%%%%%%%%%%%%%%%%%%%%%%Visualization%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X_max = max (X);
X_min = min (X);

del_X = (X_max - X_min) / 25;

    [X_whole, Y_whole]     = meshgrid (X_min : del_X : X_max);
    Z_whole =   a_whole   * X_whole   + b_whole   * Y_whole   + c_whole;

    [X_RANSAC, Y_RANSAC]   = meshgrid (X_min : del_X : X_max);
    Z_RANSAC =  a_RANSAC  * X_RANSAC  + b_RANSAC  * Y_RANSAC  + c_RANSAC;

    [X_RANSAC_, Y_RANSAC_] = meshgrid (X_min : del_X : X_max);
    Z_RANSAC_ = a_RANSAC_ * X_RANSAC_ + b_RANSAC_ * Y_RANSAC_ + c_RANSAC_;
    
hold on;

scatter3 (X, Y, Z, 'b', 'filled');

m1 = mesh (X_whole,   Y_whole,   Z_whole);
m2 = mesh (X_RANSAC,  Y_RANSAC,  Z_RANSAC);
m3 = mesh (X_RANSAC_, Y_RANSAC_, Z_RANSAC_);

set (m1,...
    'FaceColor', [1 0 0],...
    'EdgeAlpha', 0,...
    'FaceAlpha', 0.5);

set (m2,...
    'FaceColor', [0 1 0],...
    'EdgeAlpha', 0,...
    'FaceAlpha', 0.5);

set (m3,...
    'FaceColor', [0 0 1],...
    'EdgeAlpha', 0,...
    'FaceAlpha', 0.5);

legend ({'points',
         'LS using whole data',
         'LS using only inliers obtained from naive RANSAC',
         'LS using only inliers obtained from modified RANSAC'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%