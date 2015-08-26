function R = vR(n,r)
k = log(n)/log(r);
if n > r**2
	R = kron(eye(r),vR(n/r,r)) *vL(n,r);
else
	R = vL(n,r);
endif
