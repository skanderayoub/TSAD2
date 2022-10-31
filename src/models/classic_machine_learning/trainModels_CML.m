function trainedModels_CML = trainModels_CML(models, trainingData, testValData, testValLabels, thresholds)
for i = 1:length(models)    
    options = models(i).options;

    if ~options.trainOnAnomalousData
        [XTrain, XVal] = prepareDataTrain_CML(options, trainingData);
    else
        [XTrain, XVal] = prepareDataTrain_CML(options, testValData);
    end
    
    Mdl = trainCML(options, XTrain);

    [staticThreshold, pd] = getStaticThreshold_CML(options, Mdl, XTrain, XVal, testValData, testValLabels, thresholds);

    trainedModel.staticThreshold = staticThreshold;        
    trainedModel.options = options;
    trainedModel.Mdl = Mdl;
    trainedModel.pd = pd;

    trainedModels_CML.(models(i).options.id) = trainedModel;
end
end
