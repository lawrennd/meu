function options = meuOptions(neighbours, sigma2, optimizeX)

% MEUOPTIONS Create a default options structure for the MEU model.
% FORMAT
% DESC creates a default options structure for the probabilistic maximum variance unfolding model
% structure.
% ARG neighbours : the number of neighbours to use.
% ARG sigma2 : noise level.
% ARG optimizeX : whether to use and optimize X.
% measure (default is false).
% RETURN options : the default options structure.
%
% SEEALSO : meuCreate, modelOptions
%
% COPYRIGHT : Neil D. Lawrence 2009, 2011

% MEU

  if nargin < 1
    neighbours = 7;
  end
  options.numNeighbours = neighbours;
  options.isNormalised = false;
  options.regulariser = 0.0;
  if nargin<2
    options.sigma2 = 0.0;
  else
    options.sigma2 = sigma2;
  end
  if nargin < 3
    options.reduceRank = false;
    options.Xoptimize = false;
    options.gammaOptimize = false;
  else
    options.reduceRank = optimizeX;
    options.Xoptimize = optimizeX;  % Whether to optimize W in gradient
                                    % based steps.
    options.gammaOptimize = optimizeX;
  end
end
