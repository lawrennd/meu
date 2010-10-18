function drillInfo = drillDeconstruct(model)

% DRILLDECONSTRUCT break DRILL in pieces for saving.
% FORMAT
% DESC takes an DRILL model structure and breaks it into
% component parts for saving. 
% ARG model : the model that needs to be saved.
% RETURN drillInfo : a structure containing the other information
% from the maximum entropy unfolding.
%
% SEEALSO : drillCreate, drillReconstruct
%
% COPYRIGHT : Neil D. Lawrence 2010
 
% MEU


  drillInfo = model;
  removeFields = {'Y'};
  
  for i = 1:length(removeFields)
    if isfield(drillInfo, removeFields{i})
      drillInfo = rmfield(drillInfo, removeFields{i});
    end
  end
end
