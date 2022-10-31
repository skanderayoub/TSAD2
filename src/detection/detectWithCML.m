function [anomalyScores, YTest, labels, compTime] = detectWithCML(options, Mdl, XTest, YTest, labels)
% Fraction of outliers
if ~isempty(labels)
    numOfAnoms = sum(labels == 1);
    contaminationFraction = numOfAnoms / size(labels, 1);
else
    contaminationFraction = 0;
end

switch options.model
    case 'iForest'
        tStart = cputime;
        [~, anomalyScores] = isanomaly(Mdl, XTest);
        compTime = cputime - tStart;
    case 'OC-SVM'
        tStart = cputime;
        [~, anomalyScores] = predict(Mdl, XTest);
        anomalyScores = gnegate(anomalyScores);
        minScore = min(anomalyScores);
        anomalyScores = (anomalyScores - minScore) / (max(anomalyScores) - minScore);
        compTime = cputime - tStart;
    case 'ABOD'

        tStart = cputime;
        [~, anomalyScores] = ABOD(XTest);
        compTime = cputime - tStart;
    case 'LOF'

        tStart = cputime;
        [~, anomalyScores] = LOF(XTest, options.hyperparameters.model.k.value);  
        compTime = cputime - tStart;
    case 'Merlin'
        tStart = cputime;
        numAnoms = 0;
        i = 1;
        while i <= length(labels)
            if labels(i) == 1
                k = 0;
                while labels(k + i) == 1
                    k = k + 1;
                    if (k + i) > length(labels)
                        break;
                    end
                end
                i = i + k;
                numAnoms = numAnoms + 1;
            end
            i = i + 1;
        end
        if numAnoms == 0
            numAnoms = 1;
        end

        if options.hyperparameters.model.minL.value < options.hyperparameters.model.maxL.value
            anomalyScores = run_MERLIN(XTest,  options.hyperparameters.model.minL.value, ...
                options.hyperparameters.model.maxL.value, numAnoms);
        else
            anomalyScores = zeros(size(XTest, 1), 1);
        end
        anomalyScores = double(anomalyScores);
        compTime = cputime - tStart;
        return;
    case 'LDOF'
        tStart = cputime;
        anomalyScores = LDOF(XTest, options.hyperparameters.model.k.value);
        compTime = cputime - tStart;
end

anomalyScores = repmat(anomalyScores, 1, options.hyperparameters.data.windowSize.value);
anomalyScores = reshapeReconstructivePrediction(anomalyScores, options.hyperparameters.data.windowSize.value);
labels = labels(1:(end - options.hyperparameters.data.windowSize.value), 1);
YTest = YTest(1:(end - options.hyperparameters.data.windowSize.value), 1);
end
