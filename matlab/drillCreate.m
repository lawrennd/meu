function model = drillCreate(inputDim, outputDim, Y, options)

% DRILLCREATE Loglikelihood for dimensinality reduction.
% FORMAT
% DESC creates a structure for a locally linear embedding.
% ARG latentDimension : dimension of latent space.
% ARG outputDim : dimension of data.
% ARG Y : the data to be modelled in design matrix format (as many
% rows as there are data points).
% ARG options : options structure as returned by drillOptions.
% RETURN model : model structure containing DRILL model.
% 
% COPYRIGHT : Neil D. Lawrence, 2010
%
% SEEALSO : drillOptions, modelCreate


% MEU

model.type = 'drill';

if size(Y, 2) ~= outputDim
  error(['Input matrix Y does not have dimension ' num2str(d)]);
end
model.isNormalised = options.isNormalised;
model.regulariser = options.regulariser;
model.regulariserType = options.regulariserType;
model.k = options.numNeighbours;
model.Y = Y;
model.d = outputDim;
model.q = inputDim;
model.N = size(Y, 1);
model.discardLowest = false; % Don't discard lowest eigenvector of L. (it
                             % won't be the constant zero eigenvector.