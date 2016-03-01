function [J, grad] = costFunction(theta, X, y)

function hyp = hyp(index)
	hyp = sigmoid(X(index, :)*theta);
endfunction

function cost = computeCost
	cost = 0.0;
	for index = [1:m]
		cost += -y(index)*log(hyp(index)) - (1-y(index))*log(1-(hyp(index)));
	endfor
endfunction

function derivatives = computeDerivatives
	derivatives = zeros(size(theta)(1), size(theta)(2));
	for jay = [1:size(derivatives)(1)]
		for index = [1:m]
			singularCost = (hyp(index) - y(index));
			derivatives(jay) += singularCost * X(index, jay);
		endfor
	endfor
	derivatives /= m;
endfunction

m = size(y, 1);
J = (1/m) * computeCost;
grad = computeDerivatives;

end
