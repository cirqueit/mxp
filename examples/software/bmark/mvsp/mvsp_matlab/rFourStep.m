function C = rFourStep(k,m)
n = k*m;
C = kron(vF(k),eye(m)) * vT(n,m) * vL(n,k) * kron(vF(m),eye(k));






