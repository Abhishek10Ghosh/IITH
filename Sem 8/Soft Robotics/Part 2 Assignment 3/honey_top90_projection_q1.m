function honey_top90_projection_q1(HNex, HNey, volfrac, penal, rfill, ft)
%% ----------- Material Properties ----------- 
E0 = 1;
Emin = E0 * 1e-9;

%% ----------- Mesh Generation and DOF Assignment ----------- 
NstartVs = reshape(1:(1+2*HNex)*(1+HNey), 1+2*HNex, 1+HNey);
DOFstartVs = reshape(2*NstartVs(1:end-1,1:end-1)-1, 2*HNex*HNey, 1);
NodeDOFs = repmat(DOFstartVs, 1, 8) + repmat([2*(2*HNex+1)+[2 3 0 1] 0 1 2 3], 2*HNex*HNey, 1);

% Remove DOFs for edges based on honeycomb pattern 
skip = (2*HNex:2*HNex:2*HNex*HNey)' + mod(1:HNey,2)';
ActualDOFs = NodeDOFs(setdiff(1:2*HNex*HNey, skip), :);
HoneyDOFs = [ActualDOFs(2:2:end,1:2), ActualDOFs(1:2:end,:), ActualDOFs(2:2:end,7:8)];

% Nodal coordinates
Ncyi = repmat(reshape(repmat([-0.25 0.25]', HNey+1, 1), 2, HNey+1) + ...
              reshape(1.5*sort(repmat((0:HNey)',2,1)), 2, HNey+1), HNex+1, 1);
Ncyi(:,1:2:end) = flip(Ncyi(:,1:2:end));
Ncyf = Ncyi(1:end-1,:);

HoneyNCO = [repmat((0:cos(pi/6):2*HNex*cos(pi/6)),1,HNey+1)', Ncyf(:)];

if mod(HNey,2) == 0
    HoneyDOFs(end:-1:end-HNex+2,1:6) = HoneyDOFs(end:-1:end-HNex+2,1:6) - 2;
    idx = (2*HNex+1)*(HNey+1);
    HoneyNCO([idx-1, idx], :) = [];
end

[Nelem, Nnode] = deal(size(HoneyDOFs,1), size(HoneyNCO,1));

%% ----------- Force and Boundary Conditions ----------- 
L = max(HoneyNCO(:,1));
F = sparse(2*Nnode,1);

target_x = [L/4, L/2, 3*L/4];
Fvalue = 1;  
force_nodes = [];

for i = 1:length(target_x)
    [~, node_idx] = min(abs(HoneyNCO(:,1) - target_x(i)));
    force_nodes = [force_nodes; node_idx];
end

F(2*force_nodes) = -Fvalue;

% Vertical supports at x=0 and x=L
fixeddofs = 2*find(abs(HoneyNCO(:,1)) < 1e-6 | abs(HoneyNCO(:,1) - L) < 1e-6);
alldofs = 1:2*Nnode;
freedofs = setdiff(alldofs, fixeddofs);

%% ----------- Assembly Preparation ----------- 
iK = reshape(kron(HoneyDOFs, ones(12,1))', 144*Nelem, 1);
jK = reshape(kron(HoneyDOFs, ones(1,12))', 144*Nelem, 1);

KE = (E0/1000) * [
    616.43012  92.77147  -168.07333  65.54377  -232.28511 -0.00032 -120.65312 -83.28564 -71.60020 -92.77115 -23.81836  17.74187;
    92.77147  509.30685  101.02751  -71.90335  0.00032  -18.03857 -83.28564 -24.48314 -92.77179 -178.72347 -17.74187 -216.15832;
   -168.07333 101.02751  455.74522   0.00000 -168.07333 -101.02751 -71.60020 -92.77179  23.60185  -0.00000 -71.60020  92.77179;
    65.54377  -71.90335   0.00000   669.99176 -65.54377  -71.90335 -92.77115 -178.72347 -0.00000 -168.73811  92.77115 -178.72347;
   -232.28511  0.00032  -168.07333 -65.54377  616.43012 -92.77147 -23.81836 -17.74187 -71.60020  92.77115 -120.65312  83.28564;
   -0.00032  -18.03857 -101.02751 -71.90335 -92.77147  509.30685  17.74187 -216.15832  92.77179 -178.72347  83.28564 -24.48314;
   -120.65312 -83.28564 -71.60020 -92.77115 -23.81836  17.74187  616.43012  92.77147 -168.07333  65.54377 -232.28511 -0.00032;
   -83.28564 -24.48314 -92.77179 -178.72347 -17.74187 -216.15832  92.77147  509.30685 101.02751 -71.90335  0.00032  -18.03857;
   -71.60020 -92.77179  23.60185  -0.00000 -71.60020  92.77179 -168.07333  101.02751  455.74522  0.00000 -168.07333 -101.02751;
   -92.77115 -178.72347 -0.00000 -168.73811  92.77115 -178.72347  65.54377 -71.90335  0.00000  669.99176 -65.54377 -71.90335;
   -23.81836 -17.74187 -71.60020  92.77115 -120.65312  83.28564 -232.28511  0.00032 -168.07333 -65.54377  616.43012 -92.77147;
    17.74187 -216.15832  92.77179 -178.72347  83.28564 -24.48314 -0.00032 -18.03857 -101.02751 -71.90335 -92.77147  509.30685
];

%% ----------- Filter Preparation ----------- 
Cxx = repmat([sqrt(3)/2*(1:2:2*HNex-1), sqrt(3)*(1:HNex-1)], 1, ceil(HNey/2));
Cyy = repmat(3/4 + 3/2*(0:HNey-1), HNex, 1);
Cyy(HNex+1:2*HNex:end) = [];
ct = [Cxx(1:length(Cyy))', Cyy(:)];

DD = cell(Nelem,1);
for j = 1:Nelem
    dist = sqrt((ct(j,1) - ct(:,1)).^2 + (ct(j,2) - ct(:,2)).^2);
    idx = find(dist <= rfill);
    DD{j} = [idx, j*ones(size(idx)), dist(idx)];
end
DD = vertcat(DD{:});
HHs = sparse(DD(:,2), DD(:,1), 1 - DD(:,3)/rfill);
HHs = spdiags(1./sum(HHs,2), 0, Nelem, Nelem) * HHs;

%% ----------- Heaviside Projection Filter Parameters ----------- 
% Adding Heaviside projection filter parameters
beta = 1;        % Initial beta value
betamax = 128;   % Maximum beta value
eta = 0.5;       % Threshold parameter

%% ----------- Initialization ----------- 
x = volfrac * ones(Nelem,1);
[loop, change, maxiter, dv, move] = deal(0, 1, 200, ones(Nelem,1), 0.2);

%% ----------- Initialize variables based on filter type ----------- 
if ft == 0 || ft == 1  % No filter or sensitivity filter
    xPhys = x;
elseif ft == 2         % Density filter
    xPhys = HHs * x;
elseif ft == 3         % Heaviside projection filter
    xTilde = HHs * x;  % First apply density filter
    % Then apply Heaviside projection
    xPhys = (tanh(beta*eta) + tanh(beta*(xTilde-eta))) ./ (tanh(beta*eta) + tanh(beta*(1-eta)));
end

%% ----------- Optimization Loop ----------- 
while (change > 0.01 && loop < maxiter)
    loop = loop + 1;

    % Finite Element Analysis
    sK = reshape(KE(:) * (Emin + xPhys'.^penal * (E0-Emin)), 144*Nelem, 1);
    K = sparse(iK, jK, sK);

    U = zeros(2*Nnode,1);
    U(freedofs) = decomposition(K(freedofs,freedofs),'chol','lower') \ F(freedofs);

    % Objective and Sensitivities
    ce = sum((U(HoneyDOFs) * KE) .* U(HoneyDOFs), 2);
    c = sum((Emin + xPhys.^penal * (E0-Emin)) .* ce);
    dc = -penal * (E0-Emin) * xPhys.^(penal-1) .* ce;

    % Apply appropriate filtering to sensitivities
    if ft == 0      % No filtering
        % Do nothing
    elseif ft == 1  % Sensitivity filtering
        dc = HHs' * (x.*dc) ./ max(1e-3, x);
    elseif ft == 2  % Density filtering
        dc = HHs' * dc;
        dv = HHs' * dv;
    elseif ft == 3  % Heaviside projection filter
        % Chain rule for sensitivities
        dH = beta * (1 - tanh(beta*(xTilde-eta)).^2) ./ (tanh(beta*eta) + tanh(beta*(1-eta)));
        dc = HHs' * (dc .* dH);
        dv = HHs' * (dv .* dH);
    end

    % Optimality Criteria Update
    xold = x;
    [xUpp, xLow] = deal(xold + move, xold - move);
    OcC = xold .* sqrt(-dc ./ dv);
    
    % Set limits for the Lagrange multiplier
    if ft == 3
        l1 = 0; l2 = 1e9;  % For projection filter, use wide range to avoid numerical issues
    else
        l1 = 0; l2 = max(OcC) / volfrac;
    end

    while (l2-l1)/(l2+l1) > 1e-3
        lmid = 0.5*(l2+l1);
        x = max(0, max(xLow, min(1, min(xUpp, OcC / lmid))));
        if mean(x) > volfrac
            l1 = lmid;
        else
            l2 = lmid;
        end
    end

    % Update physical variables based on filter type
    if ft == 0 || ft == 1
        xPhys = x;
    elseif ft == 2
        xPhys = HHs * x;
    elseif ft == 3
        xTilde = HHs * x;
        xPhys = (tanh(beta*eta) + tanh(beta*(xTilde-eta))) ./ (tanh(beta*eta) + tanh(beta*(1-eta)));
    end

    change = max(abs(x - xold));

    % Print Results
    fprintf(' It.:%5i Obj.:%11.4f Vol.:%7.3f ch.:%7.3f\n', loop, c, mean(xPhys), change);

    % Plot intermediate designs
    colormap('gray');
    scatter(ct(:,1), ct(:,2), [], 1-xPhys, 'filled');
    axis equal off;
    drawnow;
    
    % Update beta parameter (continuation approach)
    if ft == 3 && mod(loop, 60) == 0 && beta < betamax
        beta = 2 * beta;
        fprintf(' Beta updated to: %g\n', beta);
    end
end
end
