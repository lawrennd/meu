function meuDisplay(model, spacing)

% MEUDISPLAY Display parameters of the MEU model.
% FORMAT
% DESC displays the parameters of the maximum entropy unfolding
% model and the model type to the console.
% ARG model : the model to display.
%
% FORMAT does the same as above, but indents the display according
% to the amount specified.
% ARG model : the model to display.
% ARG spacing : how many spaces to indent the display of the model by.
%
% SEEALSO : meuCreate, modelDisplay
%
% COPYRIGHT : Neil D. Lawrence 2009

% MEU

  if nargin > 1
    spacing = repmat(32, 1, spacing);
  else
    spacing = [];
  end
  spacing = char(spacing);
  fprintf(spacing);
  fprintf('Maximum entropy unfolding model:\n')
  fprintf(spacing);
  fprintf('  Neighbours: %d\n', model.k);
end