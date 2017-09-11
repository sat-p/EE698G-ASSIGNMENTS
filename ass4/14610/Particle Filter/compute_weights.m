function  [p_w] = compute_weights(particles,p_w,z,idf,R,lm)

 % Compute weights of particles.
 
 % Input 
 % particles
 % p_w - current weights
 % z - observations
 % idf - landmark identifier.
 % R - covariance of noisy observations
 % lm - set of landmarks
  
 % Output
 % p_w - new weights
 
[~, n]  = size (z);
[~, np] = size (particles);

if (n == 0)
    return;
end

%% The gaussian mean and covariance of p (z | x[m])
% p (z | x[m]) can also be seen as a gaussian with mean z, with x[m] as the
% random vector

sigma = kron (eye (n), R);
mean  = reshape (z, [], 1);

%% The expected measurements z_ for each of the particles.

z_ = zeros (2 * n, np);

for idx1 = 1 : np
    
    s = 1;
    e = 2;
    
    for idx2 = 1 : n
        
        z_ (s : e, idx1) = measurement_model (particles (:, idx1), lm (:, idf (idx2)));
        
        s = s + 2;
        e = s + 1;
    end
end

%% Assigning weights

% Function which uses a gaussian model to assign weights
p_w = scaled_pdf (z_, mean, sigma);

end