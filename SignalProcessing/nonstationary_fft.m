% Sharp non-stationarities on power spectra

% sharp transitions
a = [10 2 5 8];
f = [3 1 6 12];

srate = 1000;
t = 0:1/srate:10;
n = length(t);

timechunks = round(linspace(1,n,length(a)+1));

% create the signal
signal=0;
for i =1:length(a)
    signal = cat(2,signal,a(i)*sin(2*pi*f(i)*t(timechunks(i):timechunks(i+1)-1)));
end

% compute its spectrum
signalX = fft(signal)/n;
hz = linspace(0, srate/2, floor(n/2)+1);

figure(10), clf
subplot(211)
plot(t,signal)

subplot(212)
plot(hz,2*abs(signalX(1:length(hz))),'s-')
set(gca, 'xlim', [0 20])

% edges and edge artifacts
x = (linspace(0,1,n)>.5)+0;

% nonstationarity
% x = x + .08*sin(2*pi*6*t);
figure(11), clf
subplot(211)
plot(t,x)
set(gca,'ylim',[-.1 1.1])

subplot(212)
xX = fft(x)/n;
plot(hz,2*abs(xX(1:length(hz))))
set(gca, 'xlim', [0 20], 'ylim', [0 .1])