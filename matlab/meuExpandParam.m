function model = meuExpandParam(model, params)

% MEUEXPANDPARAM Create model structure from MEU model's parameters.
% FORMAT
% DESC returns a maximum entropy unfolding model structure filled with the
% parameters in the given vector. This is used as a helper function to
% enable parameters to be optimised in, for example, the NETLAB
% optimisation functions.
% ARG model : the model structure in which the parameters are to be
% placed.
% ARG param : vector of parameters which are to be placed in the
% model structure.
% RETURN model : model structure with the given parameters in the
% relevant locations.
%
% SEEALSO : meuCreate, meuExtractParam, modelExpandParam
%
% COPYRIGHT : Neil D. Lawrence 2009

% MEU

  fhandle = str2func([model.kappaTransform 'Transform']);
  params(1:model.N*model.k) = fhandle(params(1:model.N*model.k), 'atox');
  model.kappa = reshape(params(1:model.N*model.k), model.N, model.k);
  model = spectralUpdateLaplacian(model);
  Kinv = model.L + model.gamma*eye(model.N);
  if model.sigma2>0
    if ~model.sigma2Fixed
      fhandle = str2func([model.sigma2Transform 'Transform']);
      model.sigma2 = fhandle(params(end), 'atox');
    end
    model.Sigma = pdinv(Kinv) + model.sigma2*eye(model.N);
    [model.invSigma, U] = pdinv(model.Sigma);
    model.logDetSigma = logdet(model.Sigma, U);
    A = speye(model.N) + model.sigma2*Kinv;
    model.Ainv = pdinv(A);
    model.AinvLinv = pdinv(A*Kinv);
  else
    [model.K, U] = pdinv(full(Kinv));
    model.logDetK = - logdet(Kinv, U);
  end
  if ~model.sigma2>0
    model.expD2 = zeros(model.N, model.k);
    for i = 1:model.N
      for j = 1:model.k
        ind = model.indices(i, j);
        model.expD2(i, j) = model.K(i, i) - 2*model.K(i, ind) + model.K(ind, ind);
      end
    end
  end
end
