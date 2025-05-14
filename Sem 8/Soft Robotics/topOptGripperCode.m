topOptGripper(60,20,0.3,3,1.5)

function topOptGripper(nelx, nely, volfrac, penal, rmin)
% Topology Optimization for Soft Robotic Gripper
% Inputs:
% nelx, nely  : Number of elements in x and y directions
% volfrac     : Volume fraction constraint
% penal       : Penalization factor (e.g., 3)
% rmin        : Filter radius

% Initialize parameters
E0 = 1;         % Young's modulus of solid
Emin = 1e-9;    % Young's modulus of void
x = repmat(volfrac, nely, nelx); % Initial design guess
change = 1;
loop = 0;
maxloop = 100;

% Initialize history for plotting
complianceHist = [];
volumeHist = [];
changeHist = [];

% Prepare finite element analysis
[KE] = lk; % Element stiffness matrix

% Node numbering and element connectivity
nodenrs = reshape(1:(1+nelx)*(1+nely), 1+nely, 1+nelx);
edofVec = reshape(2*nodenrs(1:end-1,1:end-1)+1, nelx*nely, 1);
edofMat = repmat(edofVec, 1, 8) + ...
          repmat([0 1 2*nely+[2 3 0 1] -2 -1], nelx*nely, 1);
iK = kron(edofMat, ones(1,8))';
jK = kron(edofMat, ones(8,1))';

% Define loads and supports (basic example)
% F = sparse(2*(nelx+1)*(nely+1), 1, -1, 2*(nely+1)*(nelx+1), 1); % Load at one node
% fixeddofs = union(1:2*(nely+1):2*(nely+1)*(nelx+1), 2:2*(nely+1)); % Left edge fixed
% alldofs = (1:2*(nely+1)*(nelx+1))';
% freedofs = setdiff(alldofs, fixeddofs);

% Apply tensile load at the center node of the top edge (vertical beam)
top_nodes = (nelx)*(nely+1) + (1:nely+1);  % Top edge node numbers
top_center_node = top_nodes(floor((nely+1)/2));  % Center node at the top
F = sparse(2*top_center_node, 1, 1.0, 2*(nely+1)*(nelx+1), 1);  % Apply upward force (y-direction)

% Fix the bottom edge (both x and y DOFs)
fixeddofs = [];
bottom_nodes = 1:(nely+1);  % Nodes on bottom edge
for i = 1:length(bottom_nodes)
    node = bottom_nodes(i);
    fixeddofs = [fixeddofs, 2*node - 1, 2*node];  % Fix both x and y DOFs
end


alldofs = (1:2*(nely+1)*(nelx+1))';
freedofs = setdiff(alldofs, fixeddofs);

% Filter (sensitivity averaging)
iH = []; jH = []; sH = [];
for i = 1:nelx
    for j = 1:nely
        e1 = (i-1)*nely+j;
        for k = max(i-floor(rmin),1):min(i+floor(rmin),nelx)
            for l = max(j-floor(rmin),1):min(j+floor(rmin),nely)
                e2 = (k-1)*nely+l;
                fac = rmin - sqrt((i-k)^2+(j-l)^2);
                if fac > 0
                    iH = [iH; e1]; jH = [jH; e2]; sH = [sH; fac];
                end
            end
        end
    end
end
H = sparse(iH,jH,sH); Hs = sum(H,2);

% Iteration loop
while change > 0.01 && loop < maxloop
    loop = loop + 1;
    
    % FE-Analysis
    sK = reshape(KE(:)*(Emin + x(:)'.^penal*(E0 - Emin)), 64*nelx*nely,1);
    K = sparse(iK,jK,sK); K = (K+K')/2;
    U = zeros(2*(nely+1)*(nelx+1),1);
    U(freedofs) = K(freedofs,freedofs)\F(freedofs);
    
    % Objective and sensitivity
    ce = reshape(sum((U(edofMat)*KE).*U(edofMat),2),nely,nelx);
    c = sum(sum((Emin + x.^penal*(E0 - Emin)).*ce));
    dc = -penal*(E0 - Emin)*x.^(penal-1).*ce;
    dv = ones(nely,nelx);
    
    % Filtering sensitivities
    dc(:) = H*(dc(:)./Hs); dv(:) = H*(dv(:)./Hs);

    % Optimality criteria update
    l1 = 0; l2 = 1e9; move = 0.2;
    while (l2 - l1) > 1e-4
        lmid = 0.5*(l2 + l1);
        xnew = max(0.001, max(x - move, ...
            min(1.0, min(x + move, x.*sqrt(-dc./dv/lmid)))));
        if sum(xnew(:)) - volfrac*nelx*nely > 0
            l1 = lmid;
        else
            l2 = lmid;
        end
    end
    
    % Convergence check
    change = max(abs(xnew(:) - x(:)));
    x = xnew;
    
    % Save history for plotting
    complianceHist(end+1) = c;
    volumeHist(end+1) = mean(x(:));
    changeHist(end+1) = change;

    % Plotting section
    figure(1); clf;
    
    % 1. Design plot
    subplot(2,2,1);  
    colormap(gray); imagesc(1 - x); axis equal off;
    title(['Iteration: ', num2str(loop), ' | Change: ', num2str(change)]);
    
    % 2. Raw vs Filtered Sensitivity
    subplot(2,2,2);
    imagesc(dc); axis equal off; 
    title('Filtered Sensitivity');
    
    % 3. Strain Energy Overlay
    subplot(2,2,3);  
    imagesc(ce); axis equal off; colormap(jet); colorbar;
    title('Element Strain Energy');
    
    % 4. Compliance and Volume vs Iteration
    subplot(2,2,4);  
    yyaxis left
    plot(complianceHist, 'r-', 'LineWidth', 1.5); ylabel('Compliance');
    yyaxis right
    plot(volumeHist, 'b--', 'LineWidth', 1.5); ylabel('Volume Fraction');
    xlabel('Iteration'); title('Compliance & Volume History');
    legend('Compliance','Volume','Location','best');
    
    drawnow;  % Update plot in real-time
end
end

% 2D four-node element stiffness matrix
function [KE] = lk()
E = 1; nu = 0.3;
k = [
  1/2-nu/6, 1/8+nu/8,-1/4-nu/12,-1/8+3*nu/8,...
 -1/4+nu/12,-1/8-nu/8, nu/6     , 1/8-3*nu/8];
KE = E/(1-nu^2)* ...
    [ k(1) k(2) k(3) k(4) k(5) k(6) k(7) k(8);
      k(2) k(1) k(8) k(7) k(6) k(5) k(4) k(3);
      k(3) k(8) k(1) k(6) k(7) k(4) k(5) k(2);
      k(4) k(7) k(6) k(1) k(8) k(3) k(2) k(5);
      k(5) k(6) k(7) k(8) k(1) k(2) k(3) k(4);
      k(6) k(5) k(4) k(3) k(2) k(1) k(8) k(7);
      k(7) k(4) k(5) k(2) k(3) k(8) k(1) k(6);
      k(8) k(3) k(2) k(5) k(4) k(7) k(6) k(1)];
end
