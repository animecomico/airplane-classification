function [] = Evaluator(N, dis)
% CLASSIFYRANDOMS
% Classifies a total of N*10 random shapes and evaluates the two classifiers based on error rate.
% N: Number of iterations
% dis: DISPLAY boolean value


close all;

global DISPLAY 
DISPLAY = dis; 	% 1: Interactive display
			 	% 0: Silent run

eu = zeros(1, N);
nn = zeros(1, N);

for i = 1:N
	% Generate random images
	shape_generator2;

	% Classify 10 random images using both classifiers and get errors
	eu(i) = ClassifyRandoms_Euclidean(Generated_shapes);
	close all;		
	nn(i) = ClassifyRandoms_NN(Generated_shapes);
end

% Calculate total errors
eu_total_errors = sum(eu);
nn_total_errors = sum(nn);

% Calculate total error rate of each classifier
eu_errorRate = (eu_total_errors*100) / (N*10);
nn_errorRate = (nn_total_errors*100) / (N*10);

% Display evaluation using 3D pie charts
figure('position', [200, 50, 600, 600])

% Display zero values too
if eu_total_errors == 0
	eu_total_errors = 0.0001;
end
if nn_total_errors == 0
	nn_total_errors = 0.0001;
end

subplot(121);
pie([eu_total_errors (N*10 - eu_total_errors)], [1 0]);
colormap([1 0 0 ; 0 1 0]); 
title(sprintf('Euclidean Classifier\n'), 'fontsize',13,'fontweight','bold');
legend('Fail', 'Pass','Location','southoutside','Orientation','horizontal');

subplot(122);
pie([nn_total_errors (N*10 - nn_total_errors)], [1 0]);
colormap([1 0 0 ; 0 1 0]); 
legend('Fail', 'Pass','Location','southoutside','Orientation','horizontal');
title(sprintf('Nearest-neighbor Classifier\n'), 'fontsize',14,'fontweight','bold');

clear all;

