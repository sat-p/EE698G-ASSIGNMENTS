%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function X = gen_normal (R, n)
    % X = gen_normal (R, n). Returns a matrix whose columns represent
    % random variables and whose rows represent obseravations.
    %
    % R : The required covariance matrix of points
    % n : The number of points to generate.
    %
    % X : The generated points
    
    [r, ~] = size (R);
    [U, e] = eig (R);
    
    e_sqrt = zeros (r, r);
    
    for i = 1 : r
        e_sqrt (i, i) = sqrt (e (i, i));
    end
   
    T = U * e_sqrt;
    
    Y = randn (n, r);
    
    X = Y * T';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%