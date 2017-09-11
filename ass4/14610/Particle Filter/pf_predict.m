 function [x,particles]=pf_predict(particles,v,g,Q,dt,p_w)
 
 % Input
 % particles
 % v,g - the actual controls i.e velocity and orientation
 % Q - covariance of noisy controls
 % p_w - weigths
 % dt - timestep
 
 
% Output
% x - The pose given by the most weighted particle. 

[~, n] = size (particles);

for idx = 1 : n
    [v_, g_] = add_control_noise (v, g, Q, 1);
    
    particles (:, idx) = vehicle_model (particles (:, idx), v_, g_, dt);
end

[~, I] = max (p_w);
x = particles (:, I(1));

end