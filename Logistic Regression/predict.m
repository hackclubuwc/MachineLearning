function p = predict(theta, X)

m = size(X, 1);
p = zeros(m, 1);

decisionBoundary = 0.5;
p = round(sigmoid(X * theta));

end
