function P = iCooleyDIF(n,r)
P=1;
if !(r ==2 | r ==4 | r ==8 )
	disp("use radix 2, 4, or 8")
else
	k = log(n)/log(r);
	for i = 0:k-1
		%D = kron( eye(r**(k-i-1)) , vT(r**(i+1),r**i) );
		D = vIT( (r**(k-i-1)) ,r**(i+1),r**i );
		V = vIFI( (r**(k-i-1)) ,  r , r**i );
		%V = kron( eye(r**(k-i-1)) , vFI( r , r**i) );
		P = P*D*V;
	end
	P = vR(r**k,r)*P;
end
