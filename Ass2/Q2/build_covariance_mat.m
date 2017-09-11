%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function R = build_covariance_mat (x1, x2, e1, e2)
    % R = build_covariance_mat (x1, x2, e1, e2). Returns a covariance matrix
    % with x1 and x2 as its eigen vectors, provided x1 and x2 are linearly
    % independent, with e1 and e2 as its corresponding eigenvalues.
    %
    % x1 : First eigenvector
    % x2 : Second eigenvector
    % e1 : First eigenvalue
    % e2 : Second eigenvalue
    %
    % R  : The required covariance matrix
    
    A = [x1, x2];
    A_inv = A^(-1);

    LAMBDA = [e1, 0;
              0,  e2];
              
    R = A * LAMBDA * A_inv;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%