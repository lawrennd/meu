function model = meuCreate(inputDim, outputDim, Y, options)

% MEUCREATE Create a MEU model.
% FORMAT
% DESC creates a maximum entropy unfolding
% model structure given an options structure. 
% ARG inputDim : the input dimension of the model.
% ARG outputDim : the output dimension of the model.
% ARG Y : the data to be modelled in design matrix format (as many
% rows as there are data points).
% ARG options : an options structure that determines the form of the model.
% RETURN model : the model structure with the default parameters placed in.
%
% SEEALSO : meuOptions, modelCreate
%
% COPYRIGHT : Neil D. Lawrence 2009

% MEU

model.type = 'meu';

if size(Y, 2) ~= outputDim
  error(['Input matrix Y does not have dimension ' num2str(d)]);
end
model.isNormalised = options.isNormalised;
model.regulariser = options.regulariser;
model.k = options.numNeighbours;
model.Y = Y;
model.d = outputDim;
model.q = inputDim;
model.N = size(Y, 1);
model.sigma2 = options.sigma2;
model.sigma2Fixed = true;
model.kappaTransform = optimiDefaultConstraint('positive');
model.sigma2Transform = optimiDefaultConstraint('positive');
model.gammaTransform = optimiDefaultConstraint('positive');
model.reduceRank = options.reduceRank;
model.Xoptimize = options.Xoptimize;
model.gammaOptimize = options.gammaOptimize;
if options.reduceRank
  model.X = zeros(model.N, model.q);
end
model = meuParamInit(model);
