function [x,particles,p_w]= resample_particles(particles,p_w, N_eff)

% resample particles
% I've implemented the efficient re-sampling algorithm suggested in the
% lecture slides.

[~, I] = max (p_w);
x = particles (:, I(1));

% Calucating n_eff

n_eff = 1 / sum (p_w .^ 2);

if n_eff > N_eff
    return;
end

[~, N] = size (p_w);

w_sum = sum (p_w);
 
del_size = 1 / N;

% Constructing the cdf

c = zeros (1, N);
c (1) = p_w (1);

for i = 2 : N
    c (i) = c (i - 1) + p_w (i);
end
c = c / w_sum;

particles_ = zeros (3, N);

u1 = rand * del_size;
i = 1;
for j = 1 : N
  
  u_j = u1 + del_size * (j - 1);
  
  while u_j > c (i)
    i = i + 1;
  end
  
  particles_ (:, j) = particles (:, i);
  p_w (j)        = del_size;
end

particles = particles_;

end