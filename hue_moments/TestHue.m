fd = fopen('moments.txt', 'w');
for shape = 1:3
    for sample = 1:5
        filename=['samples\S',char(48+shape),'_',char(48+sample),'.tif']; 
        image = double(imread(filename));
        f = HueMoments(image);
        fprintf(fd, '%d_%d\t', shape, sample);    
        for moment = 1:7
           fprintf(fd, '%.4f\t', f(moment)); 
        end
        fprintf(fd, '\n');
    end
end



