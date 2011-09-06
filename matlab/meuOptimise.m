function model = meuOptimise(model, display, iters, gradcheck);

% MEUOPTIMISE Optimise maximum entropy unfolding.
% FORMAT
% DESC optimises the MEU model for a given number of iterations.
% ARG model : the model to be optimised.
% ARG display : whether or not to display while optimisation
% proceeds, set to 2 for the most verbose and 0 for the least
% verbose.
% ARG iters : number of iterations for the optimisation.
% RETURN model : the optimised model.
%
% SEEALSO : scg, conjgrad, meuCreate, meuGradient, meuObjective
%
% COPYRIGHT : Neil D. Lawrence, 2009

% MEU

if(nargin<4)
  gradcheck = false;
  if nargin < 3
    iters = 2000;
    if nargin < 2
      display = 1;
    end
  end
end


params = meuExtractParam(model);

options = optOptions;
if display
  options(1) = 1;
  if length(params) <= 100 && gradcheck
    options(9) = 1;
  end
end
options(14) = iters;

if isfield(model, 'optimiser')
  optim = str2func(model.optimiser);
else
  optim = str2func('scg');
end

if strcmp(func2str(optim), 'optimiMinimize')
  % Carl Rasmussen's minimize function 
  params = optim('meuObjectiveGradient', params, options, model);
else
  % NETLAB style optimization.
  params = optim('meuObjective', params,  options, ...
                 'meuGradient', model);
end

model = meuExpandParam(model, params);

%[U, V] = eigs(model.L, model.q+1, 'sm');
if ~model.Xoptimize % Set X
  if model.sigma2>0
    [U, V] = eig(centeringMatrix(model.N)*model.Sigma*centeringMatrix(model.N));
  else
    [U, V] = eig(centeringMatrix(model.N)*model.K*centeringMatrix(model.N));
  end
  v = diag(V);
  [v, order] = sort(v);
  ind = order(end:-1:end-model.q+1);
  model.X = U(:, ind);
  meanX = mean(model.X);
  model.X = model.X-ones(model.N, 1)*meanX;
  varX = var(model.X);
  model.X = model.X*diag(sqrt(1./varX));
end
