function [particles,p_w] = generate_particles(x,Np,P)

% Input
% x - initial starting pose
% P - covariance
% Np - number of particles

% Output
% p_w - weights of particles
% particles- each particle represents a potential pose of the robot at any time t

particles = gen_normal (P, Np)' + repmat (x, 1, Np);
p_w = repmat (1 / Np, 1, Np);
 
end