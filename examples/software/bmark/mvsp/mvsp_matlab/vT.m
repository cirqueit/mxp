function T = vT(k,n)
	if n == 0
		n=1
	end
	m = k/n;
	v = zeros(1,k);
	index = 1;
	for i = 0:(m-1)
		for j = 0:(n-1)
			v(index) = exp(-2i*pi*i*j / k);
			index = index + 1;
		end
    end
	T = diag(v);
end

