neighbors = NNTraining();

for class = 1:3	
	for sample = 1:5		
		filename = ['samples\S',char(48+class),'_',char(48+sample),'.tif']; 
		image = double(imread(filename));
		classAns = NNClassifier(image, neighbors');
		
		classFilename = ['Shape_',char(48+classAns),'.tif']; 
		classImage = imread(classFilename);

		if (class == classAns)
			result = 'PASS'; color = 'g';
		else
			result = 'FAIL'; color = 'r';
		end

		% Image being classified
		h = subplot(211); subimage(image)				
		
		% Grave result as text in classified image
		xl = xlim(h); 
		xPos = xl(1) + diff(xl) / 2; 
		yl = ylim(h); 
		yPos = yl(1) + diff(yl) / 2;
		text(xPos-20, yPos-20, result, 'color', color, 'fontweight', 'bold', 'fontsize', 14);				
		axis off;

		% Class-shape that image was classified to
		subplot(212), subimage(classImage)			
				
		uicontrol('Style', 'pushbutton', 'String', 'Next','Position', [440 20 70 25]);
        axis off;

		waitforbuttonpress
	end
end

close all