more off

'loading'
d = load('copyableData.dat');

'cleaning'
clean = cleanUpTiming(d);

residual = [clean(:,1) clean(:,2) - clean(:,4)];

%remove spikes, brute force
residual = residual( abs(residual(:,2) - mean(residual(:,2)) )< 40000 ,:);
residual = residual( residual(:,2) > 50 ,:);

%rezero timing
residual(:,1) = residual(:,1) - residual(1,1) + 1;


'resampling'
%resample, brute force, could use interp?
state = residual(1,2);
ctr = 1;
resampledResidual = zeros(residual(end,1), 2);;

for time = 1:residual(end,1)
	nowTime = residual(ctr,1);

	%time cannot stop, nor flow backward
	if (nowTime < time ) 
		ctr = ctr + 1;
	%resample
	elseif(nowTime == time)
		state = residual(ctr,2);
		ctr = ctr + 1;
	end %for

	resampledResidual(time,:) = [time, state];
end % for

%trim off equilibration
data = resampledResidual(10000:end,:);

P = psd(data(:,1), data(:,2) - mean(data(:,2)));


