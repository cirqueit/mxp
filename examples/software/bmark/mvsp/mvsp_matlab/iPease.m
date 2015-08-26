function P = iPease(n,r)
P=1;
if !(r ==2 | r ==4 | r ==8 )
	disp("use radix 2, 4, or 8")
else
	k = log(n)/log(r);
	for i = 0:k-1
		L = vL( r**k , r);
		I = vIF( r**(k-1) , r);
		D = vL( r**k , r**(k-1) ) * vTI( r**(k-i) , r**(k-i-1), r**i) * vL( r**k , r );
		P = P*L*I*D;
	end
	P = P*vR(r**k,r);
end
