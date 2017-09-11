%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; close all; clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load ('data_epipolar.mat', 's');

%% Setting the POI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

POI = [900; 185; 1]; % The provided point of interest doesn't correspond to the
                     % bottom of the parking meter

%% Computing the transformation matrix from camera 1's frame to camera 2's frame
    
    H_hc1 = pos2transform_deg (s.X_hc1);
    H_hc2 = pos2transform_deg (s.X_hc2);

    H_c2c1 = H_hc2 ^ (-1) * H_hc1;
    R_c2c1 = H_c2c1 (1 : 3, 1: 3);
    T_c2c1 = H_c2c1 (1 : 3, 4);

%% Obtaining the points which lie on the epipolar line in camera 2's frame %%%%
% In this implemenataion, I've used :
% p_2 (c) = K_2 * (c (R * K_1^-1 * p_1) + T) (where c is any real number) to
% determine the locus of p_2 instead of computing the fundamental matrix.

[m, c] = cam1_2_cam2 (s.K1, s.K2,...
                      R_c2c1,...
                      T_c2c1,...
                      POI)

%% Obatining the points which lie on the epipolar line in camera 2's frame %%%%
% In this implemenataion, I've used the fundamental matrix to compute the
% coefficients of the epipolar line.

F = fundamental_matrix (s.K1, s.K2,...
                        R_c2c1,...
                        T_c2c1);

[m_F, c_F] = cam1_2_cam2_F (POI, F)
% NOTE : It can be seen that that m_F = m & c = c_F

%% Visualization of results %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[x_size, y_size, ~] = size (s.Image2);

subplot (1, 2, 1);
imshow (rot90 (s.Image1, 3)); % Rotating the image 90 degrees clockwise
hold on;

scatter (x_size - POI (2), POI (1), 5, 'r', 'filled'); %Effectively rotating
                                                       % the point 90
                                                       % degrees clockwise

% Computing points which lie along the epipolar line using the determined
% coefficients
x = 1 : y_size;
y = m * x + c;

subplot (1, 2, 2);
imshow (rot90 (s.Image2, 3)); % Rotating the image 90 degrees clockwise
hold on;

plot (x_size - y, x, 'r'); %Effectively rotating the points 90 deg clockwise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%