%     Generates  10 figures randomly selected fro the three classes and
%     presnded with random rotate shift and zoom
warning off MATLAB:MKDIR:DirectoryExists
mkdir randoms
      first(1)=1;
      for ishape=1:3
          filenam=['shape_',char(48+ishape),'.tif'];
          indxmx=imread(filenam,'tif');
          [height(ishape),width(ishape)]=size(indxmx);
          shape(first(ishape):first(ishape)+height(ishape)-1,1:width(ishape))=indxmx;
          first(ishape+1)=first(ishape)+height(ishape);
      end
      clear  indxmx;
      rand('seed',sum(100*clock));
      ranum=rand([10,5]);
      Generated_shapes=[];
                stat=1;
          if stat~=0
             stat=fclose('all');
         end

      for jshape =1:10
          %Select randomly for th shape jshape
          ishape=floor(3-ranum(jshape,1)*3)+1;%Select class
          firot=(floor(12-ranum(jshape,2)*12)+1)*30;%Select rotation
          xshift=floor(100-ranum(jshape,3)*100)-50;%Select xshift
          yshift=floor(100-ranum(jshape,4)*100)-50;%Select yshift
          half=floor(2-ranum(jshape,5)*2);%Select yshift zoom (*0.5 or *1)
          indxmx=shape(first(ishape):first(ishape)+height(ishape)-1,1:width(ishape));
          indxmx=con2_image(indxmx,half,firot,xshift,yshift);
          indxmx=uint8(indxmx);
          filename=['randoms\photo',setstr(48+jshape-1),'.tif'];
          imwrite(indxmx,filename);
Generated_shapes=[Generated_shapes,ishape];
      end
      % display(Generated_shapes)
      