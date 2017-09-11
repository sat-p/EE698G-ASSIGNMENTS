%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% RANSAC.m
% Author : Satya Prakash Panuganti - 14610
% Assignment 1 - EE698G 2016-17
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X_, Y_] = RANSAC (d, w, p, X, Y)
    
    % [X_ Y_] = RANSAC (d, w, p, X, Y). It returns a reduced dataset which
    % comprises only of the inliers of the input dataset.
    %
    % d  : threshold to identify inliers.
    % w  : probability of picking an inlier.
    % p  : minimum probability that chosen set doesn't contain outliers.
    %
    % X  : vector of x values of input dataset
    % Y  : vector of y values of input dataset
    %
    % X_ : vector of x values of reduced inlier dataset
    % Y_ : vector of y values of reduced inlier dataset

    [n, n_] = size (X);
    
    set = zeros (n, 2);
    
    %%%%%%Calculation of N (Number of Iterations)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    N = ceil (log (1 - p) / log (1 - w * w));
    
    %%%%%%Performing N iterations%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    mostInliers = 0;
    
    for it = 1 : N
        
        count = 0;
        indices = randperm (n, 2);
        
        x = X (indices);
        y = Y (indices);
        
        if X (2) ~= X (1)
            % if slope of line is not infinity
            
            m = (y (2) - y (1)) / (x (2) - x (1));
            c = y (1) - m * x (1);
            
            for idx = 1 : n
                
                dist = (abs (Y (idx) - m * X (idx) - c)/...
                        sqrt (1 + m * m));
                
                if dist <= d
                    
                    set (count + 1, 1) = X (idx);
                    set (count + 1, 2) = Y (idx);
                    
                    count = count + 1;
                end
            end
        else
            % if slope of line is infinity
            
            for idx = 1 : n
                
                dist = abs (X (idx) - X (1))
                
                if dist <= d
                    
                    set (count + 1, 1) = X (idx);
                    set (count + 1, 2) = Y (idx);
                    
                    count = count + 1;
                end
            end
        end
        
        % Choosing current set if contains more points than previous sets
        
        if count > mostInliers
                
                mostInliers = count;
                
                X_ = set (1 : count, 1);
                Y_ = set (1 : count, 2);
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%