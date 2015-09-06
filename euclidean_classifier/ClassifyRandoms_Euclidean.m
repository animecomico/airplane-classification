function [ errors, errorRate ] = ClassifyRandoms_Euclidean(Generated_shapes)
% CLASSIFYRANDOMS
% Classifies 10 random images generated by shape_generator2.m
% Returns number of errors and error rate.

global DISPLAY

% Generate shapes only if not already generated 
if ~exist('Generated_shapes', 'var')
	shape_generator2;
end

% Get mean values from the training set
[mean1 mean2 mean3] = EuclideanTraining();

% Keep basic class images for displaying interactively
classIm1 = imread('Shape_1.tif');
classIm2 = imread('Shape_2.tif');
classIm3 = imread('Shape_3.tif');

% Set figure's position
figure('position', [200, 50, 600, 600]);

errors = 0;
% For all randomly generated images...
for imageNo = 0:9
	filename=['randoms\photo',char(48+imageNo),'.tif']; 
	image = imread(filename);	

	% Classify based on euclidean distance from mean values
	[class hue] = EuclideanClassifier(double(image) ./ 255, [mean1' mean2' mean3']);
	
	% Update errors
	if (class ~= Generated_shapes(imageNo + 1))
		errors = errors + 1;
		result = 'FAIL'; color = 'r';
	else
		result = 'PASS'; color = 'g';
	end	

	if DISPLAY
		% Image being classified
		h = subplot(221); subimage(image);				
		
		% Grave result as text in classified image
		xl = xlim(h); 
		xPos = xl(1) + diff(xl) / 2; 
		yl = ylim(h); 
		yPos = yl(1) + diff(yl) / 2;
		text(xPos-20, yPos-20, result, 'color', color, 'fontweight', 'bold', 'fontsize', 14);					
		axis off;

		% Class-shape that image was classified to
		eval(sprintf('classImage = classIm%d;', class));
		subplot(222); 
		subimage(classImage);		
		axis off;

		% Scatter plot class-points in 3D space
		subplot(2,2, [3 4]);		
		
		scatter3(mean1(1), mean1(2), mean1(3), 'MarkerFaceColor', 'c', 'MarkerEdgeColor', 'c');
		hold on;
		scatter3(mean2(1), mean2(2), mean2(3), 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'g');
		hold on;
		scatter3(mean3(1), mean3(2), mean3(3), 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b');	
		hold on;
		
		% Point being classified
		scatter3(hue(1), hue(2), hue(3), 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');
		hold on;

		% Line from point being classified to class-point to which it was classified
		eval(sprintf('pts = [hue ; mean%d];', class));
		plot3(pts(:,1), pts(:,2), pts(:,3), 'Color', 'r');	
		hold on;

		% Change view angle
		view([30 30]);

		axis([-1.6 -1 -9 -2 -9 -2]); % x,y,z axis limits	
		axis on;
		legend('Class 1','Class 2', 'Class 3', 'Current Shape', 'Match','Location','northoutside','Orientation','horizontal')
				
		% Next button
		uicontrol('Style', 'pushbutton', 'String', 'Next','Position', [500 5 70 25], 'Callback', 'uiresume(gcbf)');  

		uiwait(gcf);
	end
	hold off;
end

% Calculate error rate
errorRate = errors * 10;

close all;

end

