function x = state_model (x, v, g, dt)
% function x = state_model (x, v, g, dt). Returns the new expected state vector
% given the previous state vector estimate.
%
% x  : previous state vector estimate.
% v  : control velocity
% g  : control gamma (steer angle)
% dt : timestep.

new_theta = pi_to_pi (x (3) + g);
dist = v * dt;

x = x + [dist * cos(new_theta);
         dist * sin(new_theta);
                 g            ];

x (3) = new_theta;

end