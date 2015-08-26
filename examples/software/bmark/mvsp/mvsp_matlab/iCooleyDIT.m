function P = iCooleyDIT(n,r)
P=1;
if !(r ==2 | r ==4 | r ==8 )
	disp("use radix 2, 4, or 8")
else
	k = log(n)/log(r);
	for i = 0:k-1
		%V = kron( eye(r**i) , vFI( r , r**(k-i-1)) );
		V = vIFI(r**i , r , r**(k-i-1) );
		D = vIT( r**i , r**(k-i),r**(k-i-1) );
		%D = kron( eye(r**i) , vT(r**(k-i),r**(k-i-1)) );
		P = P*V*D;
	end
	P=P*vR(r**k,r);
end
