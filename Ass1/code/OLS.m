%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% OLS.m
% Author : Satya Prakash Panuganti - 14610
% Assignment 1 - EE698G 2016-17
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X_, Y_] = OLS (X, Y)

    % [X_, Y_] = OLS (X, Y). It returns points of a line fitted to match the
    % provided datapoints using OLS (Oridinary Least Squares).
    % 
    % X  : vector of x values of input dataset
    % Y  : vector of y values of input dataset
    %
    % _X : vector of x values of fitted line
    % _Y : vector of y values of fitted line
    
    n = size (X);

    %%%%%%Calculation of theta (coefficient vector)%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    A = [ones(n), X]; % A = [1 X]

    At = transpose (A);

    theta_ = ((At * A) ^ (-1)) * At * Y;

    c = theta_ (1);
    m = theta_ (2);

    %%%%%%Creation of line%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    X_max = max (X);
    X_min = min (X);

    X_ = linspace (X_min, X_max);
    Y_ = m * X_ + c;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%