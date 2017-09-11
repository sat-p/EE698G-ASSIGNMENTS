function xv= vehicle_model(xv, V,G,dt)
%
% INPUTS:
%   xv - vehicle pose [x;y;phi]
%   V - velocity
%   G - steer angle (rad)
%   WB - wheelbase
%   dt - change in time
%
% OUTPUTS:
%   xv - new vehicle pose
% 
% xv= [xv(1) + V*dt*cos(G+xv(3,:)); 
%      xv(2) + V*dt*sin(G+xv(3,:));
%      pi_to_pi(xv(3) + V*dt*sin(G)/WB)];

% % new
xv= [xv(1) + V*dt*cos(G+xv(3,:)); 
     xv(2) + V*dt*sin(G+xv(3,:));
     pi_to_pi(xv(3) + G)];
 