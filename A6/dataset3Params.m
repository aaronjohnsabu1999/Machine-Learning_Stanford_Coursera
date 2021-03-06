function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))

C_range     = [0.03, 0.1, 0.3, 1, 3];
sigma_range = [0.03, 0.1, 0.3, 1, 3];

model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
predictions = svmPredict(model, Xval);
bestPred = mean(double(predictions ~= yval));

for cVal = 1:length(C_range)
  for sVal = 1:length(sigma_range)
    model = svmTrain(X, y, C_range(cVal), @(x1, x2) gaussianKernel(x1, x2, sigma_range(sVal)));
    predictions = svmPredict(model, Xval);
    if mean(double(predictions ~= yval)) < bestPred
      C        = C_range(cVal);
      sigma    = sigma_range(sVal);
      bestPred = mean(double(predictions ~= yval));
    endif
  endfor
endfor

% =========================================================================

end
