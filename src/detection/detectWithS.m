function [anomalyScores, YTest, labels, compTime] = detectWithS(options, Mdl, XTest, YTest, labels)
% Fraction of outliers
if ~isempty(labels)
    numOfAnoms = sum(labels == 1);
    contaminationFraction = numOfAnoms / size(labels, 1);
else
    contaminationFraction = 0;
end

% Detect with model
switch options.model
    case 'Grubbs test'
        tStart = cputime;
        anomalyScores = grubbs_test(XTest, options.hyperparameters.model.alpha.value);
        compTime = cputime - tStart;
    case 'OD_wpca'
        tStart = cputime;
        [~, anomalyScores, ~] = OD_wpca(XTest, options.hyperparameters.model.ratioOversample.value);
        compTime = cputime - tStart;
end

anomalyScores = repmat(anomalyScores, 1, options.hyperparameters.data.windowSize.value);
anomalyScores = reshapeReconstructivePrediction(anomalyScores, options.hyperparameters.data.windowSize.value);
labels = labels(1:(end - options.hyperparameters.data.windowSize.value), 1);
YTest = YTest(1:(end - options.hyperparameters.data.windowSize.value), 1);
end
