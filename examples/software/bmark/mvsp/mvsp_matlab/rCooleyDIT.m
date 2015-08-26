function C = rCooleyDIT(k,m)
n = k*m;
C = kron(vF(k),eye(m)) * vT(n,m) * kron(eye(k),vF(m)) * vL(n,k);






