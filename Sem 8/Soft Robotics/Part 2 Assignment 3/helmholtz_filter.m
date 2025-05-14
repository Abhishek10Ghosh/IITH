function xPhys = helmholtz_filter(x, nelx, nely, rmin)
    e = ones(nelx,1);
    Tx = spdiags([e -2*e e], [-1 0 1], nelx, nelx);
    e = ones(nely,1);
    Ty = spdiags([e -2*e e], [-1 0 1], nely, nely);
    L = kron(speye(nely), Tx) + kron(Ty, speye(nelx));
    A = (rmin^2)*L - speye(nelx*nely);
    x_filtered = A\(-x(:));
    xPhys = reshape(x_filtered, nely, nelx);
end