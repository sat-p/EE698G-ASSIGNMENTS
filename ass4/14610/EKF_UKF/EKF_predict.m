function [x,P]= EKF_predict(x,P,v,g,Q,dt)
%function [xn,Pn]= predict (x,P,v,g,Q,WB,dt)
%
% Inputs:
%   x, P - state and covariance
%   v, g - control inputs: velocity and gamma (steer angle)
%   Q - covariance matrix for velocity and gamma
%   dt - timestep
%
% Outputs: 
%   x, P - predicted state and covariance
 
new_theta = pi_to_pi (x (3) + g);
dist = v * dt;

J = [1, 0, -dist * sin(new_theta);
     0, 1,  dist * cos(new_theta);
     0, 0,           1           ];
 
x = state_model (x, v, g, dt);
 
M = [dt * cos(new_theta),  -dist * dt * sin(new_theta);
     dt * sin(new_theta),   dist * dt * cos(new_theta);
                0,                     dt             ];

P = J * P * J' + M * Q * M';

end