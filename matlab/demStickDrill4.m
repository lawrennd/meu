% DEMSTICKDRILL4  Model the stick man with DRILL using different neighbours.

% MEU

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'stick';
experimentNo = 4;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set up model
latentDim = 2;
d = size(Y, 2);
neighbors = [3:10];
clear model
for i = 1:length(neighbors)
  options = drillOptions(neighbors(i));
  options.regulariser = 0;
  model = drillCreate(latentDim, d, Y, options);

  % Optimise the model.
  iters = 3000;
  display = 3;
  
  model = drillOptimise(model, display, iters);
  model.score = lvmScoreModel(model);

  save(['demStickDrill' num2str(experimentNo) '_n' num2str(neighbors(i))], 'model');
  
end

