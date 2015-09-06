function [ neighbors ]  = NNTraining()
% NNTRAINING 
% Returns a 15x3 matrix containing the Hue moments 
% for each of the labeled samples in the training set.

neighbors = zeros(15, 3);

% For each labeled sample...
for class = 1:3	
	for sample = 1:5		
		filename = ['samples\S',char(48+class),'_',char(48+sample),'.tif']; 		
		
		% Get vector of characteristics 
		temp = HueMoments(double(imread(filename)) ./ 255);
		% Extract only the first 3 Hue moments
		hue = temp(1:3);

		% Insert into neighbors set
		neighbors(sample + (class-1)*5, :) = hue';
	end
end

end

