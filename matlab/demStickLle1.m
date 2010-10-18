% DEMSTICKLLE1 Model the stick man with LLE using 6 neighbors.

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
options = lleOptions(6);

d = size(Y, 2);
model = lleCreate(latentDim, d, Y, options);
% Optimise the model.
iters = 1000;
display = 3;

model = lleOptimise(model, display, iters);

if exist('printDiagram') & printDiagram
  lvmPrintPlot(model, lbls, dataSetName, experimentNo);
else
  clf;
  lvmScatterPlot(model, lbls);
end
fprintf('Scoring model.\n');
v = sort(eig(model.L));
v(1) = [];
v = 1./v;
model.lambda = v/sum(v);
model.score = lvmScoreModel(model);
fprintf('Model score %2.4f\n', model.score);

% Save the results.
modelWriteResult(model, dataSetName, experimentNo);


