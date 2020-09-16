function [r] = array_model(G)
x = G(1);
y = G(2);
r = sqrt(abs(x^2+y^2));
end