function model = drillReconstruct(drillInfo, y)

% DRILLRECONSTRUCT Reconstruct an DRILL model..
% FORMAT
% DESC takes component parts of a DRILL model and reconstructs the
% model. The component parts are normally retrieved from a
% saved file.
% ARG drillInfo : the active set and other information stored in a structure.
% ARG y : the output target training data for the maximum entropy unfolding.
% RETURN model : an maximum entropy unfolding model structure that
% combines the component parts.
%
% SEEALSO : drillCreate, drillReconstruct
%
% COPYRIGHT : Neil D. Lawrence 2010
 
% MEU

  model = drillInfo;
  model.Y = y;
  
end