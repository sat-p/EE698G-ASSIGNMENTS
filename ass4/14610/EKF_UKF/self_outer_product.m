function A = self_outer_product (x)
% function self_outer_product (x). Returns x * x' given a column vector s.

A = outer_product (x, x);

end