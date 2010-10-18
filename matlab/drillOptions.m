function options = drillOptions(neighbours)

% DRILLOPTIONS Options for a DRILL model.
% FORMAT
% DESC returns the default options for the drill model.
% ARG neighbours : the number of neighbours to use.
% RETURN options : default options structure for the DRILL.
%
% SEEALSO : drillCreate, modelCreate
%
% COPYRIGHT : Neil D. Lawrence, 2010

% MEU

  if nargin < 1
    neighbours = 7;
  end
  options.numNeighbours = neighbours;
  options.isNormalised = true;
  options.regulariser = 1.0;
  options.regulariserType = 'none';
end