function [x,P]= UKF_update(x,P,z,R,idf,lm)
% correcting the predicted pose using Kalman gain.

% Inputs:
%   x, P -  state and covariance
%   z, R - range-bearing measurements and covariances
%   idf - indecies of each landmark from which measurements have arrived 
 
% Outputs:
%   x, P - updated state and covariance

[~, n] = size (idf);
[n_, ~] = size (x);

if n == 0
    return;
end

%% The parameters

alpha  = 0.001;
beta   = 2;

% lambda = n_ * (alpha^2 - 1); 
lambda = -.9;

%% The weights

wm0 = (lambda / (n_ + lambda));
wc0 = wm0 + 1 - alpha ^ 2 + beta;

wm = 1 / (2 * (n_ + lambda));
wc = wm;

for it = 1 : n
    %% The matrix square root

    rt = sqrtm (P);
    
    %% Computing the propagated sigma points.
    
    lm_ = lm (:, idf (it));
    z_ = measurement_model (x, lm_);
    
    xi1 = repmat (x, 1, n_) + rt;
    xi2 = repmat (x, 1, n_) - rt;
    
    z1 = zeros (2, n_);
    z2 = zeros (2, n_);
    
    for c = 1 : n_
        z1 (:, c) = measurement_model (xi1 (:, c), lm_);
        z2 (:, c) = measurement_model (xi2 (:, c), lm_);
    end
    
    %% Estimating z and S
    
    mu_z = wm0 * z_ + wm * (sum (z1, 2) + sum(z2, 2));
    
    S = wc0 * self_outer_product (z_ - mu_z);
    
    z1_ = z1 - repmat (mu_z, 1, n_);
    z2_ = z2 - repmat (mu_z, 1, n_);
    
    for c = 1 : n_
        S = S + wc * (self_outer_product (z1_ (:, c)) +...
                      self_outer_product (z2_ (:, c)));
    end
    
    S = S + R;
    
    %% Cross covariance of prior state vector and measurement vector
    
    cross_cov = zeros (3, 2);
    
    for c = 1 : n_
        cross_cov = cross_cov + wc * (outer_product ( rt (:, c), z1_ (:, c)) +...
                                      outer_product (-rt (:, c), z2_ (:, c)));
    end
    
    K = cross_cov * (S ^ (-1));
    
    del_z = z (:, it) - mu_z;
    del_z (2) = pi_to_pi (del_z (2));
    
    x = x + K * del_z;
    x (3) = pi_to_pi (x (3));
    
    P = P - K * S * K';
end
end