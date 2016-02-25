d = load('overnight.dat');

%sensors are interlaced
T1 = d(1:2:end,:);
T2 = d(2:2:end,:);

%compute the difference between the sensors
residuals = [T1(:,1), T1(:,2) - T2(:,2)];

%quick plot to make sure things look reasonable.
plot(T1(:,1), T1(:,2), T2(:,1), T2(:,2))

%compute power spectra
PT1 = psd(T1(:,1), T1(:,2)-mean(T1(:,2)));
PT2 = psd(T2(:,1), T2(:,2)-mean(T2(:,2)));
PResiduals = psd(residuals(:,1), residuals(:,2) - mean(residuals(:,2)));

%Plot power spectra
loglog( ...
	PResiduals(:,1), sqrt(PResiduals(:,2)), ';residuals;',
	PT1(:,1)       , sqrt(PT1(:,2))       , ';Temperature Sensor 1;',
	PT2(:,1)       , sqrt(PT2(:,2))       , ';Temperature Sensor 2;'
	);
%Make the graph understandable
xlabel ('frequency (Hz)');
ylabel ('Temperature spectral amplitude (K/rtHz)');
title  ('Comparing two PT1000 sensors using a ProtoVoltaics readout');
