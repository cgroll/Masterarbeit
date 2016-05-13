function [mse, rmse] = evalMseRmse( allModels, nRep, kPerc, uniqueDates, filteredData)
% EVALMSERMSE evaluates the mean-squared-error and the root-mean-squared
% error for all days of the sample using out-of-sample testing
%   The different rows represent the different days,
%   The different columns are created in the function evalDiffModels by
%   evaluating the mse and rmse for all five possible models

mse = zeros(length(uniqueDates)*nRep,size(allModels,1));
rmse = zeros(length(uniqueDates)*nRep,size(allModels,1));

for j = 1:length(uniqueDates);
    thisDate = uniqueDates(j);
    [thisObs,thisObsSize] = getObs(thisDate,filteredData);
    
    [dataInSample, dataOutOfSample] = getSub(thisObsSize,thisObs,nRep,kPerc);
    [mse(j*nRep-nRep+1:j*nRep,:), rmse(j*nRep-nRep+1:j*nRep,:)] = evalDiffModels(allModels, dataInSample, dataOutOfSample, nRep );
end

end

