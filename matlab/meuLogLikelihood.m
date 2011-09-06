function ll = meuLogLikelihood(model)

% MEULOGLIKELIHOOD Log likelihood of MEU model.
% FORMAT
% DESC computes the log likelihood of  the maximum entropy unfolding model.
% ARG model : the model structure for which log likelihood is being computed.
% RETURN ll : the computed log likelihood.
%
% SEEALSO : meuCreate, meuLogLikeGradients, modelLogLikelihood
%
% COPYRIGHT : Neil D. Lawrence, 2009, 2011
 
% MEU

  if model.sigma2 == 0
    ll = -model.d*model.logDetK;
    ll = ll - sum(sum(model.Y.*((model.Kinv*model.Y))));

  else
    ll = -model.d*model.logDetSigma;
    ll = ll - sum(sum(model.Y.*(model.invSigma*model.Y)));
  end
  ll = ll*0.5;
end