function o = cleanUpTiming( data )

	%preallocate for speed
	tout = zeros(rows(data)/3, 4);

	ctr = 1;
	outctr = 1;

	while( ctr < (rows(data) - 3) )

		nextThree = data(ctr:(ctr+2) , :);

		if(nextThree(:,1) == ones(3,1) * mean(nextThree(:,1)) )
	
			tout(outctr,:) = [nextThree(1,1) transpose(nextThree(:,2)) ];

			outctr = outctr + 1;

		ctr = ctr + 3;

		else

		ctr = ctr + 1;

		end %if

	end %while

	if( mod(ctr, 10000) == 0 )
			'Percent done'
			ctr/rows(data)	
	end

	o = tout;

endfunction
