function [feature] = find_features(a)

imgsize = [20 20];
% Preprocessing for the images (set in square bounding box and resize for same number of pixels)
preproc = im_box([], 0, 1) * im_resize([], imgsize);
a = a * preproc;
x = im_features(a, a, {'Area'});

% Retrieve labels of loaded dataset
labels = getnlab(a) - 1;
other_feat = [];
fourWidth = imgsize(2) / 4;
fourHeight = imgsize(1) / 4;
for i=1:size(a,1)
    pic = reshape(+a(i, :), imgsize);
    totalPix = sum(sum(pic));
    %Percent of pixels 
    pixel1= sum(sum(pic(1:fourHeight, 1:fourWidth))) / totalPix;
  
    pixel2= sum(sum(pic(fourHeight+1:2*fourHeight, 1:fourWidth))) / totalPix;
    
    pixel3= sum(sum(pic(2*fourHeight+1:3*fourHeight, 1:fourWidth))) / totalPix;
    
    pixel4= sum(sum(pic(3*fourHeight+1:imgsize(1), 1:fourWidth))) / totalPix;
    
    pixel5 = sum(sum(pic(1:fourHeight, fourWidth + 1: 2*fourWidth))) / totalPix;
    
    pixel6 = sum(sum(pic(fourHeight+1:2*fourHeight, fourWidth + 1: 2*fourWidth))) / totalPix;
    
    pixel7 = sum(sum(pic(2*fourHeight+1:3*fourHeight, fourWidth + 1: 2*fourWidth))) / totalPix;
    
    pixel8 = sum(sum(pic(3*fourHeight+1:imgsize(1), fourWidth + 1: 2*fourWidth))) / totalPix;

    pixel9 = sum(sum(pic(1:fourHeight, 2*fourWidth + 1: 3*fourWidth))) / totalPix;
    
    pixel10 = sum(sum(pic(fourHeight+1:2*fourHeight, 2*fourWidth + 1: 3*fourWidth))) / totalPix;
    
    pixel11 = sum(sum(pic(2*fourHeight+1:3*fourHeight, 2*fourWidth + 1: 3*fourWidth))) / totalPix;
    
    pixel12 = sum(sum(pic(3*fourHeight+1:imgsize(1), 2*fourWidth + 1: 3*fourWidth))) / totalPix;
    
    pixel13 = sum(sum(pic(1:fourHeight, 3*fourWidth + 1: 4*fourWidth))) / totalPix;
    
    pixel14 = sum(sum(pic(fourHeight+1:2*fourHeight, 3*fourWidth + 1: 4*fourWidth))) / totalPix;
    
    pixel15 = sum(sum(pic(2*fourHeight+1:3*fourHeight, 3*fourWidth + 1: 4*fourWidth))) / totalPix;
    
    pixel16 = sum(sum(pic(3*fourHeight+1:imgsize(1), 3*fourWidth + 1: 4*fourWidth))) / totalPix;
   
    other_feat = [other_feat; pixel1, pixel2,pixel3, pixel4,pixel5, pixel6,pixel7, pixel8,pixel9, pixel10,pixel11, pixel12,pixel13, pixel14,pixel15, pixel16];
end

feature = [x, other_feat];
end