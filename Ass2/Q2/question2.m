%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Satya Prakash Panuganti 
% EE698G - Assignment 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; close all; clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%Building the required R matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x1 = [1;
      5];

x2 = [-5;
      1];

lambda1 = 10;
lambda2 = 2;

R = build_covariance_mat (x1, x2, lambda1, lambda2);

disp ('The value of R is :');
disp (R);
disp (' ')

%%%%%%%Generation of points with covariance R%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = 200;

X = gen_normal (R, 200);

%%%%%%%Plotting of the points%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

scatter (X (:, 1), X (:, 2), 'o');

%%%%%%%Estimation of covariance%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

C = cov (X (:, 1), X (:, 2));

disp ('The covariance of generated datapoints');
disp (C);
disp (' ')

%%%%%%%Obtaining the principal components of the covariance%%%%%%%%%%%%%%%%%%%%

[V, e] = eig (C);

% Scaling the principal components with their eigenvalues
V (:, 1) = V (:, 1) * e (1, 1);
V (:, 2) = V (:, 2) * e (2, 2);

disp ('The eigenvectors of the generated data are:');
disp (' ')
disp (V (:, 1))
disp (' ')
disp (V (:, 2))

%%%%%%%Plotting the principal components%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hold on;

quiver (zeros (1, 2), zeros (1, 2),...
        V (1, :),     V (2, :),...
        'r');
    
%%%%%%%Plotting the required principal components%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Scaling the principal components with their eigenvalues
x1 = x1 * lambda1 / norm (x1);
x2 = x2 * lambda2 / norm (x2);

x = [x1(1), x2(1)];
y = [x1(2), x2(2)];

quiver (zeros (1, 2), zeros (1, 2),...
        x,            y,...
        'black');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

legend ('Generated points',...
        'Principal Components of generated data',...
        'Original Eigenvectors');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%