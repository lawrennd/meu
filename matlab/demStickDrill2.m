% DEMSTICKDRILL2  Model the stick man with DRILL using 20 neighbors and structure learning.

% MEU

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'stick';
experimentNo = 2;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set up model
latentDim = 2;
options = drillOptions(20);
options.regulariserType = 'l1';

d = size(Y, 2);
origModel = drillCreate(latentDim, d, Y, options);
reg = [0 0.00001 0.00002 0.00005 0.0001 0.0002 0.0005 0.001 0.002 0.005 0.01 0.02 0.05 0.1];
clear model
for i = 1:length(reg)
  regStr = num2str(reg(i));
  regStr(find(regStr=='.')) = 'p';
  origModel.regulariser = reg(i);
  % Optimise the model.
  iters = 500;
  display = 3;
  
  model = drillOptimise(origModel, display, iters);
  model.score = lvmScoreModel(model);
  save(['demStickDrill' num2str(experimentNo) '_' regStr], 'model');
end

