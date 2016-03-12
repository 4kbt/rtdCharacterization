function out = matchSlopes( data1, data2)

	out = [];

	t = data1(:,1);

	for cal = 0.5:0.01:2
		
		r = data2(:,2)-cal*data1(:,2);

		P = mpsd([t,r-mean(r)],10);

		out = [out; cal, mean(sqrt(P(30:70,2)))];
	end

endfunction
