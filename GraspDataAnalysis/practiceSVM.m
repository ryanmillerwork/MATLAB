clear all

% Load training and test data using |imageDatastore|.
syntheticDir   = fullfile(toolboxdir('vision'), 'visiondata','digits','synthetic');
handwrittenDir = fullfile(toolboxdir('vision'), 'visiondata','digits','handwritten');

% |imageDatastore| recursively scans the directory tree containing the
% images. Folder names are automatically used as labels for each image.
trainingSet = imageDatastore(syntheticDir,   'IncludeSubfolders', true, 'LabelSource', 'foldernames');
testSet     = imageDatastore(handwrittenDir, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

img = readimage(trainingSet, 206);
cellSize = [8 8];
[hog_8x8, vis8x8] = extractHOGFeatures(img,'CellSize',cellSize);
hogFeatureSize = length(hog_8x8);

[trainingFeatures, trainingLabels] = helperExtractHOGFeaturesFromImageSet(trainingSet, hogFeatureSize, cellSize); % Extract HOG features from the test set. The procedure is similar to what was shown earlier and is encapsulated as a helper function for brevity.
classifier = fitcecoc(trainingFeatures, trainingLabels);    % fitcecoc uses SVM learners and a 'One-vs-One' encoding scheme.

[testFeatures, testLabels] = helperExtractHOGFeaturesFromImageSet(testSet, hogFeatureSize, cellSize); % Extract HOG features from the test set. The procedure is similar to what was shown earlier and is encapsulated as a helper function for brevity.
[predictedLabels, score] = predict(classifier, testFeatures);        % Make class predictions using the test features.

confMat = confusionmat(testLabels, predictedLabels); % Tabulate the results using a confusion matrix.
helperDisplayConfusionMatrix(confMat)
figure; imagesc(confMat)