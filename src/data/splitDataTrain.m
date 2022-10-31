function [XTrain, YTrain, XVal, YVal] = splitDataTrain(data, windowSize, stepSize, ratioTrainVal, modelType, dataType)
% SPLITDATATRAIN % split data for training
%
% Description: apply slinding window on dataset for each channel and file
%              separately
%
% Input:  data: data
%         labels: labels
%         windowSize: double [1, inf] - size of the sliding window
%         stepSize: double [1, inf] - size of step separating the windows
%         ratioTrainVal: double (0, 1] - ratio train/(train + val)
%         modelType: string - one of (Predictive, Reconstructive)
%         dataType: double - this adjusts what shape the ouptut data should
%                            have together with the modelType
%                            see TSADPlatform_Documentation for more
%                            information                            
%
% Output: XTrain
%         YTrain
%         XVal
%         YVal

numChannels = size(data{1, 1}, 2);

XTrain = cell(1, numChannels);
YTrain = cell(1, numChannels);
XVal = cell(1, numChannels);
YVal = cell(1, numChannels);

for ch_idx = 1:numChannels
    XTrain_c = [];
    YTrain_c = [];
    for i = 1:size(data, 1)
        numOfWindows = round((size(data{i, 1}, 1) - windowSize - stepSize + 1) / stepSize);

        data_tmp = data{i, 1};
        XTrainLag = lagmatrix(data_tmp(:, ch_idx), 1:windowSize);
        XTrainAll = XTrainLag((windowSize + 1):end, :);                
        
        if dataType == 1
            XTrainTmp = zeros(numOfWindows, windowSize);
            for j = 1:numOfWindows
                XTrainTmp(j, :) = flip(XTrainAll(j * stepSize, :));
            end
        elseif dataType == 2
            XTrainTmp = cell(numOfWindows, 1);
            for j = 1:numOfWindows
                XTrainTmp{j, 1} = flip(XTrainAll(j * stepSize, :));
            end
        elseif dataType == 3
            XTrainTmp = cell(numOfWindows, 1);
            for j = 1:numOfWindows
                XTrainTmp{j, 1} = flip(XTrainAll(j * stepSize, :))';
            end
        end
        
        XTrain_c = [XTrain_c; XTrainTmp];

        if strcmp(modelType, 'Predictive')
            YTrainCell = data{i, 1};
            YTrainAll = YTrainCell((windowSize + 1):end, ch_idx);

            if dataType == 3
                YTrainTmp = cell(numOfWindows, 1);
                for j = 1:numOfWindows
                    YTrainTmp{j, 1} = YTrainAll((j * stepSize), 1);
                end
            else
                YTrainTmp = zeros(numOfWindows, 1);
                for j = 1:numOfWindows
                    YTrainTmp(j, 1) = YTrainAll((j * stepSize), 1);
                end
            end

            YTrain_c = [YTrain_c; YTrainTmp];
        else
            YTrain_c = XTrain_c;
        end
    end

    if ratioTrainVal ~= 1
        numOfWindows = size(XTrain_c, 1);
    
        l = round(ratioTrainVal * numOfWindows);
        
        XVal_c = XTrain_c((l + 1):end, :);
        YVal_c = YTrain_c((l + 1):end, :);
        XTrain_c = XTrain_c(1:l, :);
        YTrain_c = YTrain_c(1:l, :);
    else
        XVal_c = 0;
        YVal_c = 0;
    end

    XTrain{1, ch_idx} = XTrain_c;
    YTrain{1, ch_idx} = YTrain_c;
    XVal{1, ch_idx} = XVal_c;
    YVal{1, ch_idx} = YVal_c;
end
end
