function features = diagnosticFeatures(inputData)
%DIAGNOSTICFEATURES computes features of time series data
%
% Input: inputData - time series data
% Output: features - the computed features of the input data
try
    % Compute signal features
    ClearanceFactor = max(abs(inputData))/(mean(sqrt(abs(inputData)))^2);
    CrestFactor = peak2rms(inputData);
    ImpulseFactor = max(abs(inputData))/mean(abs(inputData));
    Kurtosis = kurtosis(inputData);
    Mean = mean(inputData,'omitnan');
    PeakValue = max(abs(inputData));
    SINAD = sinad(inputData);
    SNR = snr(inputData);
    ShapeFactor = rms(inputData,'omitnan')/mean(abs(inputData),'omitnan');
    Skewness = skewness(inputData);
    Std = std(inputData,'omitnan');

    % Concatenate signal features.
    features = [ClearanceFactor, ...
                CrestFactor, ...
                ImpulseFactor,...
                Kurtosis,...
                Mean, ...
                PeakValue, ...
                SINAD,...
                SNR,...
                ShapeFactor,...
                Skewness,...
                Std];
catch
    % Package computed features into a table.
    features = NaN(1, 11);
end
features = array2table(features);
features.Properties.VariableNames = ["ClearanceFactor", ...
                                        "CrestFactor", ...
                                        "ImpulseFactor", ...
                                        "Kurtosis", ...
                                        "Mean", ...
                                        "PeakValue", ...
                                        "SINAD", ...
                                        "SNR", ...
                                        "ShapeFactor", ...
                                        "Skewness", ...
                                        "Std"];
end