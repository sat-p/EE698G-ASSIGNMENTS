%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% RANSAC3_OLS.m
% Author : Satya Prakash Panuganti - 14610
% Assignment 1 - EE698G 2016-17
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X_, Y_, Z_] = RANSAC3_OLS (d, w, p, s, X, Y, Z)

    % [X_ Y_ Z_] = RANSAC3_OLS (d, w, s, p, X, Y, Z). It returns a reduced
    % dataset which comprises only of the inliers of the input dataset. In each
    % trial 's' points are randomly choosen and the best fitting line obatined
    % through OLS is used as the model for the trial.
    %
    % d  : threshold to identify inliers.
    % w  : probability of picking an inlier.
    % s  : number of points taken while fitting a plane during a trial.
    % p  : minimum probability that chosen set doesn't contain outliers.
    %
    % X  : vector of x values of input dataset
    % Y  : vector of y values of input dataset
    %
    % X_ : vector of x values of reduced inlier dataset
    % Y_ : vector of y values of reduced inlier dataset

    [n, n_] = size (X);
    set = zeros (n, 3);
    
    %%%%%%Calculation of N (Number of Iterations)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    N = ceil (log (1 - p) / log (1 - w ^ s));
    
    %%%%%%Performing N iterations%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    mostInliers = 0;
    
    X_ = set (1 , 1);
    Y_ = set (1 , 2);
    Z_ = set (1 , 3);
    
    for it = 1 : N
        
        count = 0;
        indices = randperm (n, s);
        
        x = X (indices);
        y = Y (indices);
        z = Z (indices);
        
        [c, a, b] = OLS3 (x, y, z);
        
        for idx = 1 : N
            
            dist = (abs (Z (idx) - a * X (idx) - b * Y (idx) - c) /...
                    sqrt (1 + a * a + b * b));
    
            if dist <= d
                
                set (count + 1, 1) = X (idx);
                set (count + 1, 2) = Y (idx);
                set (count + 1, 3) = Z (idx);

                count = count + 1;
            end
        end
        
        % Choosing current set if it contains more points than previous sets
        
        if count > mostInliers
                
                mostInliers = count;
                
                X_ = set (1 : count, 1);
                Y_ = set (1 : count, 2);
                Z_ = set (1 : count, 3);
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%