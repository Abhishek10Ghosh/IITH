% clear; clc; close all;
% 
% % Optimization parameters
% nelx = 60;   % Number of elements in x-direction
% nely = 20;   % Number of elements in y-direction
% penal = 3;
% rmin = 1.5;
% 
% % Volume fractions to test
% volfracs = 0.2:0.1:0.8;
% compliances = zeros(size(volfracs));
% designs = cell(size(volfracs));
% 
% % Run optimization for each volume fraction
% for i = 1:length(volfracs)
%     volfrac = volfracs(i);
%     fprintf('Running topology optimization at volfrac = %.2f...\n', volfrac);
%     [xopt, c_hist] = topOptGripper(nelx, nely, volfrac, penal, rmin);
%     compliances(i) = c_hist(end);   % Store final compliance
%     designs{i} = xopt;              % Store final design
% end
% 
% % Plot 1: Compliance vs Volume Fraction
% figure;
% plot(volfracs, compliances, '-o', 'LineWidth', 2, 'MarkerSize', 6);
% xlabel('Volume Fraction');
% ylabel('Final Compliance (Strain Energy)');
% title('Compliance vs Volume Fraction');
% grid on;
% 
% % Plot 2: Final designs for selected volume fractions
% figure;
% for i = 1:length(volfracs)
%     subplot(2, ceil(length(volfracs)/2), i);
%     imagesc(1 - designs{i});
%     colormap(gray); axis equal off;
%     title(sprintf('volfrac = %.2f', volfracs(i)));
% end
% 
% 
% 
% function [x, c_history] = topOptGripper(nelx, nely, volfrac, penal, rmin)
% % Topology Optimization for Soft Kirigami Gripper
% % Returns final material distribution x and compliance history
% 
% E0 = 1;         % Young's modulus of solid
% Emin = 1e-9;    % Young's modulus of void
% x = repmat(volfrac, nely, nelx); % Initial design guess
% change = 1;
% loop = 0;
% maxloop = 100;
% 
% [KE] = lk(); % Element stiffness matrix
% 
% nodenrs = reshape(1:(1+nelx)*(1+nely), 1+nely, 1+nelx);
% edofVec = reshape(2*nodenrs(1:end-1,1:end-1)+1, nelx*nely, 1);
% edofMat = repmat(edofVec, 1, 8) + ...
%           repmat([0 1 2*nely+[2 3 0 1] -2 -1], nelx*nely, 1);
% iK = kron(edofMat, ones(1,8))';
% jK = kron(edofMat, ones(8,1))';
% 
% % F = sparse(2*(nelx+1)*(nely+1), 1, -1, 2*(nely+1)*(nelx+1), 1); % Tip load
% % fixeddofs = union(1:2*(nely+1):2*(nely+1)*(nelx+1), 2:2*(nely+1)); % Left edge fixed
% % --- new: fix bottom edge DOFs ---
% bottomNodes = nodenrs(1, :);          % nodes on bottom row
% fixeddofs = [2*bottomNodes-1, 2*bottomNodes];  % both x & y DOFs
% 
% % --- new: tensile load at mid of top edge ---
% midCol = ceil((nelx+1)/2);
% topNode = nodenrs(end, midCol);
% F = sparse(2*(nelx+1)*(nely+1),1);
% F(2*topNode) = +1;   % positive = upward
% 
% alldofs = (1:2*(nely+1)*(nelx+1))';
% freedofs = setdiff(alldofs, fixeddofs);
% 
% % Sensitivity filter
% iH = []; jH = []; sH = [];
% for i = 1:nelx
%     for j = 1:nely
%         e1 = (i-1)*nely+j;
%         for k = max(i-floor(rmin),1):min(i+floor(rmin),nelx)
%             for l = max(j-floor(rmin),1):min(j+floor(rmin),nely)
%                 e2 = (k-1)*nely+l;
%                 fac = rmin - sqrt((i-k)^2+(j-l)^2);
%                 if fac > 0
%                     iH = [iH; e1]; jH = [jH; e2]; sH = [sH; fac];
%                 end
%             end
%         end
%     end
% end
% H = sparse(iH,jH,sH); Hs = sum(H,2);
% 
% c_history = [];
% 
% while change > 0.01 && loop < maxloop
%     loop = loop + 1;
% 
%     % FE Analysis
%     sK = reshape(KE(:)*(Emin + x(:)'.^penal*(E0 - Emin)), 64*nelx*nely,1);
%     K = sparse(iK,jK,sK); K = (K+K')/2;
%     U = zeros(2*(nely+1)*(nelx+1),1);
%     U(freedofs) = K(freedofs,freedofs)\F(freedofs);
% 
%     % Objective and Sensitivity
%     ce = reshape(sum((U(edofMat)*KE).*U(edofMat),2),nely,nelx);
%     c = sum(sum((Emin + x.^penal*(E0 - Emin)).*ce));
%     c_history = [c_history; c];
% 
%     dc = -penal*(E0 - Emin)*x.^(penal-1).*ce;
%     dv = ones(nely,nelx);
% 
%     % Sensitivity Filtering
%     dc(:) = H*(dc(:)./Hs); dv(:) = H*(dv(:)./Hs);
% 
%     % OC Update
%     l1 = 0; l2 = 1e9; move = 0.2;
%     while (l2 - l1) > 1e-4
%         lmid = 0.5*(l2 + l1);
%         xnew = max(0.001, max(x - move, ...
%                min(1.0, min(x + move, x.*sqrt(-dc./dv/lmid)))));
%         if sum(xnew(:)) - volfrac*nelx*nely > 0
%             l1 = lmid;
%         else
%             l2 = lmid;
%         end
%     end
% 
%     change = max(abs(xnew(:) - x(:)));
%     x = xnew;
% end
% end
% 
% function [KE] = lk()
% % 2D 4-node element stiffness matrix
% E = 1; nu = 0.3;
% k = [ 1/2-nu/6, 1/8+nu/8,-1/4-nu/12,-1/8+3*nu/8,...
%      -1/4+nu/12,-1/8-nu/8, nu/6     , 1/8-3*nu/8];
% KE = E/(1-nu^2)* ...
%    [ k(1) k(2) k(3) k(4) k(5) k(6) k(7) k(8);
%      k(2) k(1) k(8) k(7) k(6) k(5) k(4) k(3);
%      k(3) k(8) k(1) k(6) k(7) k(4) k(5) k(2);
%      k(4) k(7) k(6) k(1) k(8) k(3) k(2) k(5);
%      k(5) k(6) k(7) k(8) k(1) k(2) k(3) k(4);
%      k(6) k(5) k(4) k(3) k(2) k(1) k(8) k(7);
%      k(7) k(4) k(5) k(2) k(3) k(8) k(1) k(6);
%      k(8) k(3) k(2) k(5) k(4) k(7) k(6) k(1)];
% end


clear; clc; close all;

% Optimization parameters
nelx = 60;   % Number of elements in x-direction
nely = 20;   % Number of elements in y-direction
penal = 3;
rmin = 1.5;

% Volume fractions to test
volfracs = 0.2:0.1:0.8;
compliances = zeros(size(volfracs));
designs = cell(size(volfracs));

% Run optimization for each volume fraction
for i = 1:length(volfracs)
    volfrac = volfracs(i);
    fprintf('Running topology optimization at volfrac = %.2f...\n', volfrac);
    [xopt, c_hist] = topOptGripper(nelx, nely, volfrac, penal, rmin);
    compliances(i) = c_hist(end);   % Store final compliance
    designs{i} = xopt;              % Store final design
end

% Plot 1: Compliance vs Volume Fraction
figure;
plot(volfracs, compliances, '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Volume Fraction');
ylabel('Final Compliance (Strain Energy)');
title('Compliance vs Volume Fraction');
grid on;

% Plot 2: Final designs for selected volume fractions
figure;
for i = 1:length(volfracs)
    subplot(2, ceil(length(volfracs)/2), i);
    imagesc(1 - designs{i});
    colormap(gray); axis equal off;
    title(sprintf('volfrac = %.2f', volfracs(i)));
end



function [x, c_history] = topOptGripper(nelx, nely, volfrac, penal, rmin)
% Topology Optimization for Soft Kirigami Gripper
% Returns final material distribution x and compliance history

E0 = 1;         % Young's modulus of solid
Emin = 1e-9;    % Young's modulus of void
x = repmat(volfrac, nely, nelx); % Initial design guess
change = 1;
loop = 0;
maxloop = 100;

[KE] = lk(); % Element stiffness matrix

nodenrs = reshape(1:(1+nelx)*(1+nely), 1+nely, 1+nelx);
edofVec = reshape(2*nodenrs(1:end-1,1:end-1)+1, nelx*nely, 1);
edofMat = repmat(edofVec, 1, 8) + ...
          repmat([0 1 2*nely+[2 3 0 1] -2 -1], nelx*nely, 1);
iK = kron(edofMat, ones(1,8))';
jK = kron(edofMat, ones(8,1))';

% F = sparse(2*(nelx+1)*(nely+1), 1, -1, 2*(nely+1)*(nelx+1), 1); % Tip load
% fixeddofs = union(1:2*(nely+1):2*(nely+1)*(nelx+1), 2:2*(nely+1)); % Left edge fixed
% % Apply tensile load at the center top node in the upward direction
% top_center_node = (nelx / 2 + 1)*(nely + 1);  % Node number in grid
% F = sparse(2*top_center_node, 1, 1.0, 2*(nely+1)*(nelx+1), 1);  % y-direction (upward) force
% 
% % Fix bottom edge (both x and y DOFs)
% fixeddofs = [];
% for i = 1:nelx+1
%     node = i;
%     fixeddofs = [fixeddofs, 2*node - 1, 2*node];  % x and y DOFs of each node on bottom
% end
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

% Sensitivity filter
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

c_history = [];

while change > 0.01 && loop < maxloop
    loop = loop + 1;

    % FE Analysis
    sK = reshape(KE(:)*(Emin + x(:)'.^penal*(E0 - Emin)), 64*nelx*nely,1);
    K = sparse(iK,jK,sK); K = (K+K')/2;
    U = zeros(2*(nely+1)*(nelx+1),1);
    U(freedofs) = K(freedofs,freedofs)\F(freedofs);

    % Objective and Sensitivity
    ce = reshape(sum((U(edofMat)*KE).*U(edofMat),2),nely,nelx);
    c = sum(sum((Emin + x.^penal*(E0 - Emin)).*ce));
    c_history = [c_history; c];

    dc = -penal*(E0 - Emin)*x.^(penal-1).*ce;
    dv = ones(nely,nelx);

    % Sensitivity Filtering
    dc(:) = H*(dc(:)./Hs); dv(:) = H*(dv(:)./Hs);

    % OC Update
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

    change = max(abs(xnew(:) - x(:)));
    x = xnew;
end
end

function [KE] = lk()
% 2D 4-node element stiffness matrix
E = 1; nu = 0.3;
k = [ 1/2-nu/6, 1/8+nu/8,-1/4-nu/12,-1/8+3*nu/8,...
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

