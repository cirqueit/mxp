function C = rSixStep(k,m)
n = k*m;
C = vL(n,k) * kron(eye(m),vF(k)) * vL(n,m) * vT(n,m) * kron(eye(k),vF(m)) * vL(n,k);






