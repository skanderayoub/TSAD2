function [testingData, testingLabels, testValData, testValLabels, testFileNames] = splitTestVal(testingData, testingLabels, ratio, testFileNames)
% SPLITTESTVAL % split testing data into testing set and validation set
%
% Description: split testing data into testing set and validation set
%
% Input:  testingData: data
%         testingLabels: labels
%         raio: double (0, 1] - ratio test/(test + val)
%         testFileNames: strings - filenames of testing files

%
% Output: testingData
%         tesingLabels
%         testValData
%         testValLabels
%         testFileNames: strings - new filenames of testing files


if size(testingData, 1) > 1 
    ratioSplit = 0.2;

    idx = randperm(size(testingData, 1));
    splitPoint = ceil(ratioSplit * size(testingData, 1));

    testValData = testingData(idx(1:splitPoint), 1);
    testValLabels = testingLabels(idx(1:splitPoint), 1);
    testingData = testingData(idx((splitPoint + 1):end), 1);
    testingLabels = testingLabels(idx((splitPoint + 1):end), 1);
    if ~isempty(testFileNames)
        testFileNames = testFileNames(1, idx((splitPoint + 1):end));
    end
else
    if ratio == 1
        testValData = testingData;
        testValLabels = testingLabels;
    else
        dataTmp = testingData{1, 1};
        labelsTmp = testingLabels{1, 1};
        testValData = cell(1, 1);
        testValLabels = cell(1, 1);
        
        splitPoint = round(ratio * size(dataTmp, 1));
        
        testValData{1, 1} = dataTmp(splitPoint:end, 1);
        testValLabels{1, 1} = labelsTmp(splitPoint:end, 1);
        testingData{1, 1} = dataTmp(1:(splitPoint - 1), 1);
        testingLabels{1, 1} = labelsTmp(1:(splitPoint - 1), 1);
    end
end
end