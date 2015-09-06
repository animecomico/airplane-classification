function [ mean1, mean2, mean3 ]  = EuclideanTraining()
% EUCLIDEANTRAINING 
% Returns the mean values utilizing the training set.

% For each labeled sample...
for class = 1:3
	eval(sprintf('mean%d = [0 0 0];', class));
	for sample = 1:5		
		filename = ['samples\S',char(48+class),'_',char(48+sample),'.tif']; 
				
		% Get vector of characteristics 
		temp = HueMoments(double(imread(filename)) ./ 255);
		% Extract only the first 3 Hue moments
		hue = temp(1:3);

		% Update mean value
		eval(sprintf('mean%d = mean%d + hue;', class, class));
	end
	eval(sprintf('mean%d = mean%d ./ 5;', class, class));	
end

end

