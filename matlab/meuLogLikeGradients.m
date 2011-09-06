function g = meuLogLikeGradients(model)

% MEULOGLIKEGRADIENTS Gradient of MEU model log likelihood with respect to parameters.
% FORMAT
% DESC computes the gradient of the maximum entropy unfolding
% model's log likelihood with respect to the parameters.
% ARG model : model structure for which gradients are being
% computed.
% RETURN g : the returned gradients. 
%
% SEEALSO meuCreate, meuLogLikelihood, modelLogLikeGradients 
%
% COPYRIGHT : Neil D. Lawrence 2009

% MEU
  gX = [];
  gS = [];
  gGamma = [];
  if model.sigma2 == 0.0
    gV = 0.5*( model.d*model.expD2 - model.D2);
  else
    AinvY = model.Ainv*model.Y;
    AinvYYTAinv = AinvY*AinvY';
    for i = 1:model.N
      for j = 1:model.k
        ind = model.indices(i, j);
        gV(i, j) = model.d*(model.AinvLinv(i, i) ...
                            - 2*model.AinvLinv(i, ind) ...
                            + model.AinvLinv(ind, ind));
        gV(i, j) = gV(i, j) - AinvYYTAinv(i, i) ...
            + 2*AinvYYTAinv(i, ind) ...
            - AinvYYTAinv(ind, ind);
      end
    end
    gV = gV*0.5;
  end
  fhandle = str2func([model.kappaTransform 'Transform']);
  factors = fhandle(model.kappa, 'gradfact');
  gV = gV.*factors;
  
  if model.Xoptimize || model.gammaOptimize
    % This can be written much more efficiently, and should be in
    % expandParam (probably).
    CinvK = model.Cinv*model.K;
  end
  if model.Xoptimize
    CinvX = model.Cinv*model.X;
    gX = -model.d*CinvK*CinvX +  model.Cinv*model.Y*model.Y'*CinvX;
  end
  if model.gammaOptimize
    % This trace can be written more efficiently.
    ginvGamma = -model.d*sum(sum(CinvK.*model.Cinv)) + ...
        sum(diag(model.Cinv*model.Y*model.Y'*model.Cinv));
    ginvGamma = ginvGamma*0.5;
    gGamma = -ginvGamma/(model.gamma*model.gamma);
    fhandle = str2func([model.gammaTransform 'Transform']);
    factor = fhandle(model.gamma, 'gradfact');
    gGamma = gGamma*factor;
  end

  if ~model.sigma2Fixed
    invSigmaY = model.invSigma*model.Y;
    gS = -model.d*trace(model.invSigma) + sum(sum(invSigmaY.*invSigmaY));
    gS = gS*0.5;
    fhandle = str2func([model.sigma2Transform 'Transform']);
    factor = fhandle(model.sigma2, 'gradfact');
    gsigma = gS*factor;
  end
  g = [gV(:)' gX(:)' gGamma gS];

end