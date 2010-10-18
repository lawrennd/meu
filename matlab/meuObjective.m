function f = meuObjective(params, model)

% MEUOBJECTIVE Wrapper function for MEU objective.
% FORMAT
% DESC returns the negative log likelihood of a MEU
% model given the model structure and a vector of parameters. This
% allows the use of NETLAB minimisation functions to find the model
% parameters.
% ARG params : the parameters of the model for which the objective
% will be evaluated.
% ARG model : the model structure for which the objective will be
% evaluated.
% RETURN f : the negative log likelihood of the MEU model.
%
% SEEALSO : scg, conjgrad, meuCreate, meuGradient, meuLogLikelihood, meuOptimise
% 
% COPYRIGHT : Neil D. Lawrence, 2005, 2006, 2009

% MEU

model = meuExpandParam(model, params);
f = - meuLogLikelihood(model);
