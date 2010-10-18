function model = drillOptimise(model, display, iters)

% DRILLOPTIMISE Optimise an DRILL model.
% FORMAT
% Optimisation of the dimensionality reduction through iterative log
% likleihood maximizaiton (DRILL) model.
% DESC optimises a DRILL model.
% ARG model : the model to be optimised.
% RETURN model : the optimised model.
%
% SEEALSO : drillCreate, modelOptimise
%
% COPYRIGHT : Neil D. Lawrence, 2010

% MEU
  tol = 1e-4;
  model.indices = findNeighbours(model.Y, model.k);
  meanY = mean(model.Y);
  Ycent = model.Y - repmat(meanY, model.N, 1);
  
  model.S = 1./model.d*Ycent*Ycent';
  model.K = model.S;
  model.K(1:(model.N+1):end) = diag(model.S) + model.regulariser;
  
  A = [eye(model.N-1,model.N-1);-eye(model.N-1,model.N-1)];
  f = zeros(model.N-1,1);
  switch model.regulariserType
   case 'l1'
    optionsReg = glmnetSet;
    optionsReg.lambda = 2*model.regulariser;
    optionsReg.nlambda = 1;
    optionsReg.lambda_min = 1;
    optionsReg.type = 'naive';
   otherwise
    optionsReg = [];
  end
  maxBchange = 1e-4;
  model.B = spalloc(model.N, model.N, model.k*model.N);
  for iter = 1:iters
    for i = 1:model.N
      neighbors = model.indices(i, :);
      indRemain = model.indices;
      indRemain(neighbors, :) = 0;
      if any(any(indRemain==i))
        % Pick up non-symmetric neighbors.
        for j = 1:model.k
          neighbors = [neighbors find(indRemain(:, j)==i)'];
        end
      end
      otherInd = [1:(i-1) (i+1):model.N];
      s_12 = model.S(neighbors, i);
      W_11 = model.K(neighbors, neighbors);
      %      beta = pdinv(W_11)*s_12;
      switch model.regulariserType
       case 'l1'
        Xeq = sqrtm(W_11);
        yeq = Xeq\s_12;
        beta = LassoShooting(Xeq,yeq,2*model.regulariser,'verbose',0);
        %beta = fit.beta;
       case 'none'
        beta = W_11\s_12;
      end
      W_1all = model.K(otherInd, neighbors);
      w = W_1all*beta;
      model.B(:, i) = spalloc(model.N, 1, length(neighbors));
      model.B(neighbors, i) = beta;
      model.Lii(i) = 1/(model.K(i, i) - model.K(i, neighbors)*beta);
      model.K(otherInd, i) = w;
      model.K(i, otherInd) = w';
    end
    if iter>1
      maxBchange = max(max(abs(oldB - model.B)));
      if display
        fprintf('Iteration %d, max change %2.4f\n', iter, full(maxBchange));
      end      
    end
    if maxBchange < tol
      fprintf('Converged after %d iterations\n', iter)
      break;
    end
    oldB = model.B;
  end
  if iter>=iters
    fprintf('Warning: maximum iterations exceed.\n')
  end
  for i = 1:model.N
    model.L(:, i) = -model.B(:, i)*model.Lii(i);
  end
  model.L = 0.5*(model.L + model.L');
  model.L(1:model.N+1:end) = model.Lii;
  %model.K = pdinv(model.L);
  %[U, V] = eigs(model.L, model.q+1, 'sm');
  [U, V] = eig(centeringMatrix(model.N)*model.K*centeringMatrix(model.N));
  v = diag(V);
  [v, order] = sort(v);
  ind = order(end:-1:end-model.q+1);
  model.X = U(:, ind);
  meanX = mean(model.X);
  model.X = model.X-ones(model.N, 1)*meanX;
  varX = var(model.X);
  model.X = model.X*diag(sqrt(1./varX));

end