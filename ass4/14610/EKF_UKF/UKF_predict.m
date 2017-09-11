function [x,P]= UKF_predict(x,P,v,g,Q,dt)
% Inputs:
%   x, P - state and covariance
%   v, g - control inputs: velocity and gamma (steer angle)
%   Q - covariance matrix for velocity and gamma
%   dt - timestep
%
% Outputs: 
%   x, P - predicted state and covariance

%% Combining x, v and g to create an augmented random vector (X)

X = [x; v; g];

[n, ~] = size (X);

R = [   P,          zeros(3, 2);
     zeros(2, 3),       Q];

%% The parameters

alpha = 0.001;
beta = 2;

% lambda = n * (alpha^2 - 1);
lambda = -.9;

%% The matrix square root

rt = real (sqrtm (R));

%% The weights

wm0 = (lambda / (n + lambda));
wc0 = wm0 + 1 - alpha ^ 2 + beta;

wm = 1 / (2 * (n + lambda));
wc = wm;

%% For the sigma point at the centre.

x_ = state_model (x, v, g, dt);

%% For the sigma points 1, ..., 2n

chi1 = repmat (X, 1, n) + rt;
chi2 = repmat (X, 1, n) - rt;

x1 = zeros (3, n);
x2 = zeros (3, n);

for c = 1 : n
    x1 (: , c) = state_model (chi1 (1 : 3, c), chi1 (4, c), chi1 (5, c), dt);
    x2 (: , c) = state_model (chi2 (1 : 3, c), chi2 (4, c), chi2 (5, c), dt);
end

%% Computing x and p

x = wm0 * x_ + wm * (sum (x1, 2) + sum (x2, 2));

x1_ = x1 - repmat (x, 1, n);
x2_ = x2 - repmat (x, 1, n);

P = wc0 * self_outer_product (x_ - x);

for c = 1 : n
    P = P + wc * (self_outer_product (x1_ (:, c)) +...
                  self_outer_product (x2_ (:, c)));
end

end