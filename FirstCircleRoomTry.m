d = load('FirstCircleRoomTry.dat');

startSample = 10000;
endSample = 30000;

t1 = d(1:3:end,:);
t2 = d(2:3:end,:);
t3 = d(3:3:end,:);

t1full = t1;
t2full = t2;
t3full = t3;

t1 = t1(startSample:endSample,:);
t2 = t2(startSample:endSample,:);
t3 = t3(startSample:endSample,:);

p1 = polyfit(t1(:,2), t2(:,2),1);
p3 = polyfit(t3(:,2), t2(:,2),1);

T1 = polyval(p1, t1(:,2));
T3 = polyval(p3, t3(:,2));

T1 = 0.795*T1;

R = T1-T3;

DR = detrend(R,1);

PR = mpsd([t1(:,1), DR],10);
P1 = mpsd([t1(:,1), T1-mean(T1)],10);
P3 = mpsd([t3(:,1), T3-mean(T3)],10);

loglog(P1(:,1), sqrt(P1(:,2)),';sensor 1;', P3(:,1), sqrt(P3(:,2)), ';sensor 3;', PR(:,1),sqrt(PR(:,2)), ';difference;')
xlabel('frequency (Hz)');
ylabel('residual temperature spectral amplitude (K/rtHz)')
title ('RTD comparison, 20000s early on March 11')

m  = matchSlopes([t1(:,1), T1], [t3(:,1), T3]);

