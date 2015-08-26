function L = vL(k,n)
% reorders coordinates @ stride n, into n segments of length m
    m= k/n;
	L = zeros(k);
	for i = 1:n
		for j = 1:m
			L(j+(i-1)*m,(j-1)*n+i) = 1;
   	 	end
	end
end


