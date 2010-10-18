function meuInfo = meuDeconstruct(model)

% MEUDECONSTRUCT break MEU in pieces for saving.
% FORMAT
% DESC takes an maximum entropy unfolding model structure and breaks it into
% component parts for saving. 
% ARG model : the model that needs to be saved.
% RETURN meuInfo : a structure containing the other information
% from the maximum entropy unfolding.
%
% SEEALSO : meuCreate, meuReconstruct
%
% COPYRIGHT : Neil D. Lawrence 2009
 
% MEU


  meuInfo = model;
  removeFields = {'Y'};
  
  for i = 1:length(removeFields)
    if isfield(meuInfo, removeFields{i})
      meuInfo = rmfield(meuInfo, removeFields{i});
    end
  end
end
