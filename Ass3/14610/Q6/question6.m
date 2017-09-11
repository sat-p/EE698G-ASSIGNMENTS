%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; close all; clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load 'data_kalman.mat';

%% Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

g = 9.8;

init_speed = 300;
del_t = 0.1;

rt_Q = 200;

k = 1e-5; % The coefficient for R_t in the modified Kalman Filter in which we 
          % model the prediction noise to be proportional to the square of
          % the instantaneous velocity

%% Plotting of actual trajectory and measurements %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[n, ~] = size (data.z);
t = del_t * (0 : n - 1);

figure;
plot (t, data.orig_state (:, 1), '--k'); hold on;
plot (t, data.z, '.', 'color', [0.8 0.5 0]);

xlabel ('Time (in seconds)');
ylabel ('Height (in m)');

%% Estimating trajectory without measurements%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X_no_meas = zeros (2, n); % Here, X_n = X (:, n) = [h_n; v_n]
X_no_meas (2, 1) = init_speed;

% We have X_(n + 1) = AX_n + BU where :

A = [1, del_t;...
     0, 1];

BU = [-0.5 * (del_t ^ 2) * g;...
            -del_t * g      ];

for idx = 1 : 499
    X_no_meas (:, idx + 1) = A * X_no_meas (:, idx) + BU;
end

%% Plotting of estimated trajectory (without measurements) %%%%%%%%%%%%%%%%%%%%

plot (t, X_no_meas (1, :), 'b');

%% Estimating trajectory with measurements and Kalman Filter %%%%%%%%%%%%%%%%%%

X_Kalman = zeros (2, n); % Here, X_n = X (:, n) = [h_n; v_n]
X_Kalman (2, 1) = init_speed;

sigma = zeros (2, 2); % The intial covariance matrix

% Here, we have :
% X_(n + 1) = AX_n + BU  + zero-mean gaussian noise with covariance R
% Z_(n + 1) = CZ_(n + 1) + zero-mean gaussian noise with covariance Q

C = [1, 0];

R = [0.1, 0;...
     0,   0.1];

Q = rt_Q ^ 2;

for idx = 1 : 499
    
    % Prediction
    mean_ = A * X_Kalman (:, idx) + BU;
    sigma_ = A * sigma * A' + R;
    
    % Correction
    K = sigma_ * C' * ((C * sigma_ * C' + Q) ^ -1); % Kalman Gain
    X_Kalman (:, idx + 1) = mean_ + K * (data.z (idx + 1) - C * mean_);
    sigma = (eye (2) - K * C) * sigma_;
end

%% Plotting of estimated trajectory (with measurements and Kalman) %%%%%%%%%%%%

plot (t, X_Kalman (1, :), 'r');

legend ('Actual trajectory',...
        'Measurements',...
        'Without measurements',...
        'Kalman filter');

%% Estimating trajectory with measurements and modified Kalman Filter (Part C)
% In this version, R_n is not taken as a constant.
% It is instead taken a diagnal matrix with the diagnol elements being
% equal to v_n ^ 2 * k

X_Kalman_ = zeros (2, n); % Here, X_n = X (:, n) = [h_n; v_n]
X_Kalman_ (2, 1) = init_speed;

sigma = zeros (2, 2); % The intial covariance matrix

% Here, we have :
% X_(n + 1) = AX_n + BU  + zero-mean gaussian noise with covariance R_n
% Z_(n + 1) = CZ_(n + 1) + zero-mean gaussian noise with covariance Q

norm_Kalman = zeros (1, 499);
norm_R      = zeros (1, 499);

for idx = 1 : 499
    
    % Prediction
    mean_ = A * X_Kalman_ (:, idx) + BU;
    
    R_n = (X_Kalman_ (2, idx) ^ 2) * k;
    sigma_ = A * sigma * A' + R_n;
    
    % Correction
    K = sigma_ * C' * ((C * sigma_ * C' + Q) ^ -1); % Kalman Gain
    X_Kalman_ (:, idx + 1) = mean_ + K * (data.z (idx + 1) - C * mean_);
    sigma = (eye (2) - K * C) * sigma_;
    
    % For part (c) :
    norm_R (idx) = R_n (1);
    norm_Kalman (idx) = norm (K);
end

%% Plotting of normalized Kalman Gain and normalized ||R_t|| %%%%%%%%%%%%%%%%%%

figure;

plot (t (2 : end), norm_Kalman);
hold on;
plot (t (2 : end), norm_R);
legend ('Kalman', 'R');

%% Computation of error in estimation from both Kalman filters %%%%%%%%%%%%%%%%
% I'm calculating the root mean square errors of the estimates of both the
% Kalman filters

% The first Kalman Filter
diff = X_Kalman (1, :) - data.orig_state (:, 1)';
RMSE1 = sqrt (mean (diff.^2))

% The second Kalman Filter
diff = X_Kalman_ (1, :) - data.orig_state (:, 1)';
RMSE2 = sqrt (mean (diff.^2))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%