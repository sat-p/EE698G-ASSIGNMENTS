%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [m, c] = OLS (X, Y)

    % [m, c] = OLS (X, Y). It returns the coefficients of a line fitted to match
    % the provided datapoints using OLS (Oridinary Least Squares).
    % 
    % X  : column vector of x values of the input dataset
    % Y  : column vector of y values of the input dataset
    %
    % m  : the slope of the fitted line
    % c  : the y-intercept of the fitted line
    
    n = size (X);

    %%%%%%Calculation of theta (coefficient vector)%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    A = [ones(n), X]; % A = [1 X]

    At = transpose (A);

    theta_ = ((At * A) ^ (-1)) * At * Y;

    c = theta_ (1);
    m = theta_ (2);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%