% DEMSTICKDRILL1 Model the stick man with DRILL using 6 neighbors.

% MEU

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'stick';
experimentNo = 1;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set up model
latentDim = 2;
options = drillOptions(6);
options.regulariser = 0;
d = size(Y, 2);
model = drillCreate(latentDim, d, Y, options);

% Optimise the model.
iters = 3000;
display = 3;

model = drillOptimise(model, display, iters);

if exist('printDiagram') & printDiagram
  lvmPrintPlot(model, lbls, dataSetName, experimentNo);
else
  clf;
  lvmScatterPlot(model, lbls);
end
fprintf('Scoring model.\n');
model.lambda = eig(model.K)/trace(model.K);
model.score = lvmScoreModel(model);
fprintf('Model score %2.4f\n', model.score);

% Save the results.
modelWriteResult(model, dataSetName, experimentNo);

