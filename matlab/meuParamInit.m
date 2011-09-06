function model = meuParamInit(model)

% MEUPARAMINIT MEU model parameter initialisation.
% FORMAT
% DESC initialises the maximum entropy unfolding
%  model structure with some default parameters.
% ARG model : the model structure which requires initialisation.
% RETURN model : the model structure with the default parameters placed in.
%
% SEEALSO : meuCreate, modelCreate, modelParamInit
%
% COPYRIGHT : Neil D. Lawrence 2009

% MEU

[model.indices, model.D2] = findNeighbours(model.Y, model.k);
model.kappa = ones(model.N, model.k);
model.gamma = 1e-4;
model.traceY = sum(sum(model.Y.*model.Y));
params = meuExtractParam(model);
model = meuExpandParam(model, params);
if model.reduceRank
  model = spectralUpdateX(model);
  model.X = ppcaEmbed(model.Y, model.q);
end
if model.gammaOptimize
  model.gamma = exp(1);
end
