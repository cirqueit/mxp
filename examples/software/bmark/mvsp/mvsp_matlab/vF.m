function F = vF(n) 
	F = zeros(n);
	for i = 0:n-1
		for j = 0:n-1
			F(i+1,j+1) = exp(-2i*pi*i*j/n); 
		end
    end
end


