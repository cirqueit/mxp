function F = vF2(N)
n = log2(N);
F=vR(2,n);
for i = n:-1:1
	F = kron(eye(2**(i-1)),vFI(2,2**(n-i)))*kron(eye(2**(i-1)),vT(2**(n-i+1),2**(n-i))) *F;
endfor




