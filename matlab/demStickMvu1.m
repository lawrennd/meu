% DEMSTICKMVU1 Model the stick man with MVU using 6 neighbors.

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
options = mvuOptions(6);

d = size(Y, 2);
model = mvuCreate(latentDim, d, Y, options);

% Optimise the model.
iters = 1000;
display = 3;

model = mvuOptimise(model, display, iters);

if exist('printDiagram') & printDiagram
  lvmPrintPlot(model, lbls, dataSetName, experimentNo);
else
  clf;
  lvmScatterPlot(model, lbls);
end
fprintf('Scoring model.\n');
model.score = lvmScoreModel(model);
fprintf('Model score %2.4f\n', model.score);

% Save the results.
modelWriteResult(model, dataSetName, experimentNo);

