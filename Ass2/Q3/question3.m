%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; close all; clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load 'data.mat'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot (data (:, 1), data (:, 2), '.');
xlabel ('\theta');
ylabel ('r');
hold on;

%%%%%%%Generating points for the 3-sigma ellipse%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mu_theta = 1;
mu_r = 3;

psi = 0 : 0.01 : 2 * pi;

% The locus of the 3-sigma ellipse is given by :
% 2 * (theta - mu_theta)^2 + (r - mu_r)^2 = 3.
% Therefore, the locus can be parameterized as :
% theta = mu_theta + sqrt (3 / 2) * cos (psi),
% r = mu_r + sqrt (3) * sin (psi)

theta = mu_theta + sqrt (3 / 2) * cos (psi);
r = mu_r + sqrt (3) * sin (psi);

%%%%%%%Plotting the 3-sigma ellipse%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot (theta, r, 'r');

legend ('The provided points',...
        '3-\sigma error ellipse');
    
%%%%%%%Transforming points from polar to euclidean%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = data (:, 2) .* cos (data (:, 1));
y = data (:, 2) .* sin (data (:, 1));

%%%%%%%Plotting the transformed points%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot (x, y, '.')
xlabel ('x');
ylabel ('y');
hold on;

%%%%%%%Generating the 3-sigma locus%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mu_x = mean (x);
mu_y = mean (y);

mu_euc = [mu_x;
          mu_y]

sigma_sam = cov (x, y)

sigma_sam_inv = sigma_sam^(-1);

% Using eigen value decomposition to find principal components of the locus of
% the ellipse.
[v, e] = eig (sigma_sam_inv);

% Computing the directions of the principal components.
theta1 = atan2 (v (1, 2), v (1, 1));
theta2 = atan2 (v (2, 2), v (2, 1));

% x1, x2 are the components of the ellipse along the principal components 
% measure from the mean. It can be shown that the radii of the ellipse are
% sqrt (3 / e1) & sqrt (3 / e2) where e1, e2 are the eigenvalues of the
% inverse of the covariance matrix.
x1 = sqrt (3 / e (1, 1)) * cos (psi);
x2 = sqrt (3 / e (2, 2)) * sin (psi);

% Projecting the components x1, x2 onto the x & y axes.
x_ = mu_x + x1 * cos (theta1) + x2 * cos (theta2);
y_ = mu_y + x1 * sin (theta1) + x2 * sin (theta2);

%%%%%%%Plotting the 3-sigma ellipse%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot (x_, y_);

%%%%%%%Computing the 3-sigma ellipse of the transformed points%%%%%%%%%%%%%%%%%

s = sin (mu_theta);
c = cos (mu_theta);

% The Jacobain matrix, A
A = [-mu_r * s, c;...
      mu_r * c, s];

sigma_x = [0.5, 0;
           0,   1];

% The approximate covariance matrix
sigma_lin = A * sigma_x * A'

sigma_lin_inv= sigma_lin^(-1);

% Using EVD to compute the 3-sigma locus from the approximate inverse of
% covariance matrix, sigam_inv_
[v_, e_] = eig (sigma_lin_inv);

theta1_ = atan2 (v_ (1, 2), v_ (1, 1));
theta2_ = atan2 (v_ (2, 2), v_ (2, 1));

x1_ = sqrt (3 / e_ (1, 1)) * cos (psi);
x2_ = sqrt (3 / e_ (2, 2)) * sin (psi);

x__ = mu_x + x1_ * cos (theta1_) + x2_ * cos (theta2_);
y__ = mu_y + x1_ * sin (theta1_) + x2_ * sin (theta2_);

%%%%%%%Plotting the approximate 3-sigma ellipse%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot (x__, y__, 'g');

legend ('The transformed points',...
        'The actual 3\sigma ellipse',...
        'The approximate 3\sigma ellipse');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%