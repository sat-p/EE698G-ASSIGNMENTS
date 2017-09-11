%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% OLS3.m
% Author : Satya Prakash Panuganti - 14610
% Assignment 1 - EE698G 2016-17
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c, a, b] = OLS3 (X, Y, Z)

    % [c, a, b] = OLS3 (X, Y, Z). It returns points of a plane fitted to match
    % the provided datapoints using OLS (Oridinary Least Squares). The equation
    % of the fitted matrix is assumed to be Z = a * X + b * Y + c
    % 
    % X  : vector of x values of input dataset
    % Y  : vector of y values of input dataset
    % Z  : vector of z values of input dataset
    %
    % c  : the coefficient c
    % a  : the coefficient a
    % b  : the coefficient b
    
    [n, n_] = size (X);
   
    %%%%%%Calculation of theta (coefficient vector)%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    A = [ones(n, 1), X, Y]; % A = [1 X Y]  
    At = transpose (A);

    theta_ = (At * A) \ (At * Z);

    c = theta_ (1);
    a = theta_ (2);
    b = theta_ (3);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%