function p = scaled_pdf (x, mu, sigma)
% function p = scaled_pdf (x, mu, sigma). Returns the pdf value evaluated at
% points x given the the mean, mu and covariance, sigma of the multivariate
% gaussian distribution. This function ignores the factors 2 * pi and
% det (Sigma) associated with the pdf. It later scales the probabilites
% such that sum becomes equal to 1.

[~, n] = size (x);
    
sigma_inv = sigma ^ (-1);

val = zeros (1, n);

for idx = 1 : n
    
    diff = x (:, idx) - mu;
    
    for angles = 2 : 2 : size (diff, 1)
        diff (angles) = pi_to_pi (diff (angles));
    end
    
    val (idx) = diff' * sigma_inv * diff / 2;
end

min_val = min (val);

p = zeros (1, n);

sum = 0;

for idx = 1 : n
    p (idx) = exp (-val(idx) + min_val);
    sum = sum + p (idx);
end

p = p / sum;

end