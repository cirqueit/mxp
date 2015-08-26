function P = iKorn(n,r)
P=1;
if !(r ==2 | r ==4 | r ==8 )
	disp("use radix 2, 4, or 8")
else
	k = log(n)/log(r);
	for i = 0:k-1
		V = vFI( r , r**(k-1));
		D = vTI( r**(k-i) , r**(k-i-1), r**i );
		L = vL( r**k , r);
		P = P*V*D*L;
	end
	P = P*vR(r**k,r);
end
