function p = scaled_inv_pdf (x, mu, sigma)
% function p = scaled_inv_pdf (x, mu, sigma). Returns the pdf value evaluated at
% points x given the the mean, mu and covariance, sigma. It assumes that probability of a
% measurement in inversely proportion to the norm of the weighted error squared.
% It later scales the probabilites such that sum becomes equal to 1.

[~, n] = size (x);
    
val = zeros (1, n);

sum = 0;

sigma_inv = sigma;

for idx = 1 : n
    
    diff = x (:, idx) - mu;
    diff (2) = pi_to_pi (diff (2));
    
    p (idx) = 1 / (diff' * sigma_inv * diff);
    sum = sum + p (idx);
end

p = p / sum;

end