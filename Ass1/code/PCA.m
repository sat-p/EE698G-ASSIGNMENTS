%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PCA.m
% Author : Satya Prakash Panuganti - 14610
% Assignment 1 - EE698G 2016-17
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X_, Y_] = PCA (X, Y)

    % [X_, Y_] = PCA (X, Y). It returns points of a line fitted to match the
    % provided datapoints using PCA (Principal Component Analysis).
    % 
    % X  : vector of x values of input dataset
    % Y  : vector of y values of input dataset
    %
    % _X : vector of x values of fitted line
    % _Y : vector of y values of fitted line
    
    [n, n_] = size (X);

    %%%%%%Creation of Covariance matrix (R)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    mean = [sum(X); sum(Y)] / n;
    
    Q = zeros (2, 2);
    
    for idx = 1 : n
        
        delta_X  = [X(idx); Y(idx)] - mean;
        
        Q = Q + delta_X * transpose (delta_X); 
    end
    
    Q = Q / n;
    
    %%%%%%Obtaining Principal Component%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [M, D] = eig (Q); % A * M = M * D
    
    if (D (1, 1) > D (2, 2))
        eigen_vector = M (:, 1);
    else
        eigen_vector = M (:, 2);
    end
    
    % Normalization is not required
    norm = transpose (eigen_vector) * eigen_vector;
    eigen_vector = eigen_vector / norm;
    
    %%%%%%Creation of line%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if eigen_vector (1) ~= 0
        % slope, m ~= infinity
        
        m = eigen_vector (2) / eigen_vector (1);
        c = mean (2) - m * mean (1); % c = mu_y - m * mu_x
        
        X_max = max (X);
        X_min = min (X);
        
        X_ = linspace (X_min, X_max);
        Y_ = m * X_ + c;
    else
        % slope, m = infinity
        
        x = mean (1) % x = mu_x
        
        Y_max = max (Y);
        Y_min = min (Y);
        
        Y_ = linspace (Y_min, Y_max);
        X_ = ones (100) * x;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%