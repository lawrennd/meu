function [params, names] = meuExtractParam(model)

% MEUEXTRACTPARAM Extract parameters from the MEU model structure.
% FORMAT
% DESC extracts parameters from the maximum entropy unfolding
% model structure into a vector of parameters for optimisation.
% ARG model : the model structure containing the parameters to be
% extracted.
% RETURN param : vector of parameters extracted from the model. 
%
% FORMAT
% DESC extracts parameters and parameter names from the probabilistic maximum variance unfolding
% model structure.
% ARG model : the model structure containing the parameters to be
% extracted.
% RETURN param : vector of parameters extracted from the model. 
% RETURN names : cell array of strings containing names for each
% parameter.
%
% SEEALSO meuCreate, meuExpandParam, modelExtractParam, scg, conjgrad
%
% COPYRIGHT : Neil D. Lawrence 2009
%
% MEU


  params = model.kappa(:)';
  fhandle = str2func([model.kappaTransform 'Transform']);
  params = fhandle(params, 'xtoa');

  if ~model.sigma2Fixed
    fhandle = str2func([model.sigma2Transform 'Transform']);
    params(end+1) = fhandle(model.sigma2, 'xtoa');
  end
  if nargout>1
    counter = 0;
    for j = 1:size(model.kappa, 2)
      for i = 1:size(model.kappa, 1)
        counter = counter + 1;
        names{counter} = ['Spring ' num2str(i) ' to ' num2str(model.indices(i, j))] ;
      end
    end
    if model.sigma2>0
      names{counter+1} = 'Noise variance';
    end
  end
end
