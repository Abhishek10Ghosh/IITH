function honey_top90_projection_Q3(HNex, HNey, volfrac, penal, rfill, ft)
%% ----------- Material Properties ----------- 
E0 = 1;
Emin = E0 * 1e-9;

%% ----------- Mesh Generation and DOF Assignment ----------- 
NstartVs = reshape(1:(1+2*HNex)*(1+HNey), 1+2*HNex, 1+HNey);
DOFstartVs = reshape(2*NstartVs(1:end-1,1:end-1)-1, 2*HNex*HNey, 1);
NodeDOFs = repmat(DOFstartVs, 1, 8) + repmat([2*(2*HNex+1)+[2 3 0 1] 0 1 2 3], 2*HNex*HNey, 1);

skip = (2*HNex:2*HNex:2*HNex*HNey)' + mod(1:HNey,2)';
ActualDOFs = NodeDOFs(setdiff(1:2*HNex*HNey, skip), :);
HoneyDOFs = [ActualDOFs(2:2:end,1:2), ActualDOFs(1:2:end,:), ActualDOFs(2:2:end,7:8)];

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

%% ----------- Force and Boundary Conditions (Uniformly Distributed Simply Supported Beam) ----------- 
L = max(HoneyNCO(:,1));
F = sparse(2*Nnode,1);

% Apply uniform downward load
totalLoad = -1;  % Total load (negative = downward)
topNodes = find(abs(HoneyNCO(:,2) - max(HoneyNCO(:,2))) < 1e-6);
loadPerNode = totalLoad / length(topNodes);

F(2*topNodes) = F(2*topNodes) + loadPerNode;

% Find left and right nodes
leftNodes = find(abs(HoneyNCO(:,1)) < 1e-6);
rightNodes = find(abs(HoneyNCO(:,1) - max(HoneyNCO(:,1))) < 1e-6);

% Fix vertical DOFs at left and right nodes
fixeddofs = [2*leftNodes; 2*rightNodes];

% Additionally, fix horizontal movement at one left node
[~, idxMin] = min(HoneyNCO(:,1));
fixeddofs = [fixeddofs; 2*idxMin-1];

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
Cyy(HNex+1:2*HNex:end)*
