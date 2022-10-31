function [XTrain, XVal] = prepareDataTrain_S(options, trainingData)
% PREPAREDATATRAIN_S % prepare S data for training
%
% Description: prepare data for training Statistical models
%
% Input:  options: struct of model options
%         trainingData: data
%
% Output: XTrain: prepared data for training

switch options.model
    case 'Your model'
    otherwise
        [XTrain, ~, XVal, ~] = splitDataTrain(trainingData, ...
            options.hyperparameters.data.windowSize.value,  ...
            options.hyperparameters.data.stepSize.value, ...
            options.hyperparameters.training.ratioTrainVal.value, 'Reconstructive', 1);
        XTrain = cell2mat(XTrain);
        XVal = cell2mat(XVal);
end
end
