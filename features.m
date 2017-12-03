% Load Nist digits Dataset
a = prnist([0:9],[1:5:1000])
% Preprocessing for the images (set in square bounding box and resize for same number of pixels)
preproc = im_box([], 0, 1) * im_resize([], [20 20]);
a = a * preproc;

% Extract features
x = im_features(a, a, {'Area', 'Centroid', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'Extent', 'MajorAxisLength','MinorAxisLength', 'Orientation', 'Perimeter', 'Solidity', 'WeightedCentroid'});
% Feature Names
feat_names = ["Area", "Centroid X", "Centroid Y", "ConvexArea", "Eccentricity", "EquivDiameter", "EulerNumber", "Extent", "MajorAxisLength","MinorAxisLength", "Orientation", "Perimeter", "Solidity", "WeightedCentroid X", "WeightedCentroid Y"];
% Retrieve labels of loaded dataset
labels = getnlab(a) - 1;

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