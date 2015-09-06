function [ class, hue ] = EuclideanClassifier( image, means )
% EUCLIDEANCLASSIFIER 
% Classifies given image according to the euclidean distance from 
% the mean values of the training set.

% Get vector of characteristics for given image
temp = HueMoments(image);
% Extract only the first 3 Hue moments
hue = temp(1:3);

clear temp;

% Get class that image was classified to by Euclidean Classifier
class = euclidean_classifier(means, hue');

end

