% Constants
iters = 100;

% Feature Preparation
data = csvread('safe-data.csv');
trainingSet = data(:, 2:11);
X = trainingSet(:, 1:9);
y = trainingSet(:, 10);
m = size(y, 1);
for i = 1:m
   if y(i) == 2
       y(i) = 0;
   else
       y(i) = 1;
   end
end
x1 = X(:, 5);
x2 = X(:, 2);
X = [ones(m, 1) x1 x2];

% Plot/Graph Setup
plotData([x1 x2], y);
xlabel('Single Epithelial Cell Size')
ylabel('Uniformity of Cell Size')
legend('Malignant', 'Benign')
title('Logistic Regression of Two Tumor Features')

% Setting Up Parameters
[m, n] = size(X);
initial_theta = zeros(n, 1);
[initialCost, grad] = costFunction(initial_theta, X, y);

% Printing Initial Statistics
fprintf('Initial theta is: ')
initial_theta
fprintf('Initial gradients of Gradient Descent are: ')
grad
fprintf('Initial cost was %f\n', initialCost)

% Optimization
options = optimset('GradObj', 'on', 'MaxIter', iters);
[theta, cost, exitFlag] = fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);

% Plotting Results
plotDecisionBoundary(theta, X, y);

% Printing Result Statistics
fprintf('=========ALGORITHM HAS TRAINED==========\n\n')
fprintf('Algorithm computed optimum weights: ')
theta
[costF, gradF] = costFunction(theta, X, y);
fprintf('Final cost is %f\n', costF)
fprintf('Final gradients of Gradient Descent are: ')
gradF
% Accuracy
numberOfCorrect = 0;
p = round(sigmoid(X*theta));
for i = 1:m
	if p(i) == y(i)
		numberOfCorrect = numberOfCorrect + 1;
	end
end
percentAccuracy = (numberOfCorrect/m) * 100;
fprintf('Final percent accuracy on training set is %f%%\n', percentAccuracy)
