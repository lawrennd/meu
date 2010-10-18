function model = meuReconstruct(meuInfo, y)

% MEURECONSTRUCT Reconstruct an maximum entropy unfolding from component parts.
% FORMAT
% DESC takes component parts of an maximum entropy unfolding model and reconstructs the
% maximum entropy unfolding model. The component parts are normally retrieved from a
% saved file.
% ARG meuInfo : the active set and other information stored in a structure.
% ARG y : the output target training data for the maximum entropy unfolding.
% RETURN model : an maximum entropy unfolding model structure that
% combines the component parts.
%
% SEEALSO : meuCreate, meuReconstruct
%
% COPYRIGHT : Neil D. Lawrence 2009
 
% MEU

  model = meuInfo;
  model.Y = y;
  
end