function g = sigmoid(z)

g = (ones(size(z)) + exp(-z)).^(-1);

end
