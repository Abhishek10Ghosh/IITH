%%%% TOPOLOGY OPTIMIZATION WITH HELMHOLTZ FILTER FOR CANTILEVER BEAM %%%%
function top88_helmholtz_Q2(nelx,nely,volfrac,penalMax,rmin)
% input example: >> top88_cantilever(80,20,0.5,3,2)
% Cantilever beam with angled force at the top-right corner

%% MATERIAL PROPERTIES
E0 = 1;
Emin = 1e-9;
nu = 0.3;
penal = 0.96;
%% PREPARE FINITE ELEMENT ANALYSIS
A11 = [12  3 -6 -3;  3 12  3  0; -6  3 12 -3; -3  0 -3 12];
A12 = [-6 -3  0  3; -3 -6 -3 -6;  0 -3 -6  3;  3 -6  3 -6];
B11 = [-4  3 -2  9;  3 -4 -9  4; -2 -9 -4 -3;  9  4 -3 -4];
B12 = [ 2 -3  4 -9; -3  2  9 -2;  4  9  2  3; -9 -2  3  2];
KE = 1/(1-nu^2)/24*([A11 A12;A12' A11]+nu*[B11 B12;B12' B11]);
nodenrs = reshape(1:(1+nelx)*(1+nely),1+nely,1+nelx);
edofVec = reshape(2*nodenrs(1:end-1,1:end-1)+1,nelx*nely,1);
edofMat = repmat(edofVec,1,8)+repmat([0 1 2*nely+[2 3 0 1] -2 -1],nelx*nely,1);
iK = reshape(kron(edofMat,ones(8,1))',64*nelx*nely,1);
jK = reshape(kron(edofMat,ones(1,8))',64*nelx*nely,1);

%% DEFINE LOADS AND SUPPORTS FOR CANTILEVER BEAM PROBLEM
% Initialize force vector
F = sparse(2*(nely+1)*(nelx+1),1);

% Calculate the force components (F = √12 at 45°)
F_magnitude = sqrt(12);
F_x = F_magnitude * cos(pi/4);  % F*cos(45°)
F_y = F_magnitude * sin(pi/4);  % F*sin(45°)

% Apply force at the top-right corner
topRightNode = nodenrs(1, nelx+1);
F(2*topRightNode-1) = F_x;      % Horizontal component (positive x)
F(2*topRightNode) = -F_y;       % Vertical component (negative y)

U = zeros(2*(nely+1)*(nelx+1),1);

% Define supports: Fixed at left end (cantilever)
fixeddofs = [];
for i = 1:nely+1
    leftNode = nodenrs(i, 1);
    fixeddofs = [fixeddofs, 2*leftNode-1, 2*leftNode]; % Fix both x and y DOFs
end

alldofs = 1:2*(nely+1)*(nelx+1);
freedofs = setdiff(alldofs, fixeddofs);

%% PREPARE HELMHOLTZ FILTER
Rmin = rmin/2/sqrt(3); % Conversion between classical and PDE filter radius
% Define filter stiffness matrix
KEF = [
    2/3 -1/6 -1/3 -1/6
    -1/6 2/3 -1/6 -1/3
    -1/3 -1/6 2/3 -1/6
    -1/6 -1/3 -1/6 2/3];
KEF = Rmin^2*KEF + [
    4/9 1/9 1/9 1/9
    1/9 4/9 1/9 1/9
    1/9 1/9 4/9 1/9
    1/9 1/9 1/9 4/9]/4;
% Setup filter FE matrices
edofVecF = reshape(nodenrs(1:end-1,1:end-1),nelx*nely,1);
edofMatF = repmat(edofVecF,1,4) + repmat([0 nely+[1 2] 1],nelx*nely,1);
iKF = reshape(kron(edofMatF,ones(4,1))',16*nelx*nely,1);
jKF = reshape(kron(edofMatF,ones(1,4))',16*nelx*nely,1);
sKF = reshape(KEF(:)*ones(1,nelx*nely),16*nelx*nely,1);
KF = sparse(iKF,jKF,sKF);
LF = chol(KF,'lower'); % Cholesky factorization for efficient solving
iTF = reshape(edofMatF,4*nelx*nely,1);
jTF = reshape(repmat([1:nelx*nely],4,1)',4*nelx*nely,1);
sTF = repmat(1/4,4*nelx*nely,1);
TF = sparse(iTF,jTF,sTF);

%% INITIALIZE ITERATION
x = repmat(volfrac,nely,nelx);
xPhys = x;
loop = 0;
change = 1;
%% START ITERATION
while change > 0.01
  loop = loop + 1;
  penal = min(penalMax, penal + 0.04);
  %% FE-ANALYSIS
  sK = reshape(KE(:)*(Emin+xPhys(:)'.^penal*(E0-Emin)),64*nelx*nely,1);
  K = sparse(iK,jK,sK); K = (K+K')/2;
  tic; U(freedofs) = K(freedofs,freedofs)\F(freedofs); toc;
  %% OBJECTIVE FUNCTION AND SENSITIVITY ANALYSIS
  ce = reshape(sum((U(edofMat)*KE).*U(edofMat),2),nely,nelx);
  c = sum(sum((Emin+xPhys.^penal*(E0-Emin)).*ce));
  dc = -penal*(E0-Emin)*xPhys.^(penal-1).*ce;
  dv = ones(nely,nelx);
  
  %% HELMHOLTZ FILTERING OF SENSITIVITIES
  dc(:) = TF'*(LF'\(LF\(TF*dc(:))));
  dv(:) = TF'*(LF'\(LF\(TF*dv(:))));
  
  %% OPTIMALITY CRITERIA UPDATE OF DESIGN VARIABLES AND PHYSICAL DENSITIES
  l1 = 0; l2 = 1e9; move = 0.2;
  while (l2-l1)/(l1+l2) > 1e-3
    lmid = 0.5*(l2+l1);
    xnew = max(0,max(x-move,min(1,min(x+move,x.*sqrt(-dc./dv/lmid)))));
    
    %% HELMHOLTZ FILTERING OF DENSITIES
    xPhys(:) = TF'*(LF'\(LF\(TF*xnew(:))));
    
    if sum(xPhys(:)) > volfrac*nelx*nely, l1 = lmid; else l2 = lmid; end
  end
  change = max(abs(xnew(:)-x(:)));
  x = xnew;
  %% PRINT RESULTS
  fprintf(' It.:%5i Obj.:%11.4f Vol.:%7.3f ch.:%7.3f\n',loop,c, ...
    mean(xPhys(:)),change);
  %% PLOT DENSITIES
  colormap(gray); imagesc(1-xPhys); caxis([0 1]); axis equal; axis off; drawnow;
end
