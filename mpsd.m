%determines the average psd from psdChunk

function psdM = mpsd(data, nchunks)

	psdC = psdChunk(data, nchunks);

	psdM = [psdC(:,1), mean(psdC(:,2:end),2)];	

endfunction
