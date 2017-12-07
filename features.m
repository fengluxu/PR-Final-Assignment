% Load Nist digits Dataset
a = prnist([0:9],[1:5:1000])
imgsize = [20 20];
% Preprocessing for the images (set in square bounding box and resize for same number of pixels)
preproc = im_box([], 0, 1) * im_resize([], imgsize);
a = a * preproc;

% Extract features
x = im_features(a, a, {'Area', 'Centroid', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'Extent', 'MajorAxisLength','MinorAxisLength', 'Orientation', 'Perimeter', 'Solidity', 'WeightedCentroid'});
% Feature Names
feat_names = ["Area", "Centroid X", "Centroid Y", "ConvexArea", "Eccentricity", "EquivDiameter", "EulerNumber", "Extent", "MajorAxisLength","MinorAxisLength", "Orientation", "Perimeter", "Solidity", "WeightedCentroid X", "WeightedCentroid Y", "NumPixels Horizontal Half", "NumPixels Vertical Half", "Reflect X", "Reflect Y"];
% Retrieve labels of loaded dataset
labels = getnlab(a) - 1;

other_feat = [];
halfWidth = imgsize(2) / 2;
halfHeight = imgsize(1) / 2;
for i=1:size(a,1)
    pic = reshape(+a(i, :), imgsize);
    totalPix = sum(sum(pic));
    %Percent of pixels above horizontal half point
    pixelHor = sum(sum(pic(1:halfHeight, :))) / totalPix;
    %Percent of pixels to right of vertical half point
    pixelVert = sum(sum(pic(:, halfWidth + 1:imgsize(2)))) / totalPix;
    %Is reflected x axis
    xReflect = sum(sum(flipud(pic(1:halfHeight, :)) == pic(halfHeight+1:imgsize(1), :))) / (halfHeight * imgsize(2));
    %Is reflected y axis
    yReflect = sum(sum(fliplr(pic(:, 1:halfWidth)) == pic(:, halfWidth+1:imgsize(2)))) / (halfWidth * imgsize(1));
    other_feat = [other_feat; pixelHor, pixelVert, xReflect, yReflect];
end

x = [x, other_feat];

for i=1:length(feat_names)
    % Boxplot features
    figure;
    boxplot(+x(:,i), labels);
    xlabel('PrNist Digit Class');
    ylabel(feat_names(i));
end

% Overall variance and mean for each feature
varFeat = var(+x);
meanFeat = mean(+x);

%Variance per class
for i=1:10
    class = seldat(x, i);
    i
    var(+class)
    mean(+class)
end
