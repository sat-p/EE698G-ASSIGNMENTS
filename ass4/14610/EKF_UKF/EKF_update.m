function [x,P]= EKF_update(x,P,z,R,idf,lm)
 
% Inputs:
%   x, P -  state and covariance
%   z, R - range-bearing measurements and covariances
%   idf - feature index for each z
 
% Outputs:
%   x, P - updated state and covariance

[~, n] = size (idf);

if n == 0
    return;
end

for it = 1 : n
    disp = lm (:, idf (it)) - x (1 : 2, 1);
    dist_2 = sum (disp .^ 2);
    dist   = sqrt (dist_2);
    
    h_x = measurement_model (x, lm (:, idf (it)));

    H = [ -disp(1) / dist,   -disp(2) / dist,     0;...
           disp(2) / dist_2, -disp(1) / dist_2,  -1];

    K = P * H' * ((H * P * H' + R) ^ (-1));
   
%     del_z = z (1 : 2, it) - h_x;
    del_z = z (: , it) - h_x;
    del_z (2) = pi_to_pi (del_z (2));
    
    x = x + K * del_z;
    x (3) = pi_to_pi (x (3));
    
    P = (eye (3) - K * H) * P;

end
end