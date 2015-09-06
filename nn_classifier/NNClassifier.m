function [ class, hue ] = NNClassifier( image, neighbors)
% NNCLASSIFIER 
% Classifies given image according to the nearest 3 
% neighbors from the training set.

% Get vector of characteristics for given image
temp = HueMoments(image);
% Extract only the first 3 Hue moments
hue = temp(1:3);
clear temp;

% Get class that image was classified to by Nearest-neighbor Classifier
class = k_nn_classifier(neighbors, [1 1 1 1 1 2 2 2 2 2 3 3 3 3 3], 3, hue');

end

