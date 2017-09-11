function z = measurement_model (x, lm)
% function z = measurement_model (x, lm). Returns the expected measurement
% for a robot with state x and positiioned at lm.
%
% x  : The expected state vector of the robot.
% lm : The position of the observed landmark.
%
% z : The expected measurement.

disp   = lm - x (1 : 2, 1);
dist_2 = sum (disp .^ 2);
dist   = sqrt (dist_2);

z = [dist;
     pi_to_pi(atan2 (disp(2), disp(1)) - x(3))];

end