function [f, g] = meuObjectiveGradient(params, model)

% MEUOBJECTIVEGRADIENT Wrapper function for MEU objective and gradient.
% FORMAT
% DESC returns the negative log likelihood of a MEU model given the model
% structure and a vector of parameters. This allows the use of NETLAB
% minimisation functions to find the model parameters.
% ARG params : the parameters of the model for which the objective
% will be evaluated.
% ARG model : the model structure for which the objective will be
% evaluated.
% RETURN f : the negative log likelihood of the MEU model.
% RETURN g : the gradient of the negative log likelihood of the MEU
% model with respect to the parameters.
%
% SEEALSO : minimize, meuCreate, meuGradient, meuLogLikelihood, meuOptimise
% 
% COPYRIGHT : Neil D. Lawrence, 2005, 2006

% MEU

% Check how the optimiser has given the parameters
if size(params, 1) > size(params, 2)
  % As a column vector ... transpose everything.
  transpose = true;
  model = meuExpandParam(model, params');
else
  transpose = false;
  model = meuExpandParam(model, params);
end

f = - meuLogLikelihood(model);
if nargout > 1
  g = - meuLogLikeGradients(model);
end
if transpose
  g = g';
end