% Amplitude non-stationarity

srate = 1000;
t = 0:1/srate:10;
n = length(t);
f = 3; % frequency in Hz

% sine wave with time-increasing amplitude
%ampl1 = linspace(1, 10, n);
ampl1 = abs(interp1(linspace(t(1),t(end),10),10*rand(1,10),t,'spline'));
ampl2 =mean(ampl1);

signal1 = ampl1 .* sin(2*pi*f*t);
signal2 = ampl2 .* sin(2*pi*f*t);

% obtain Fourier coefs and Hz vector
signal1X = fft(signal1)/n;
signal2X = fft(signal2)/n;
hz = linspace(0,srate,n);

figure(13), clf
subplot(211)
plot(t, signal2,'r', 'linew', 2), hold on
plot(t, signal1,'b', 'linew', 2)

subplot(212)
plot(hz, 2*abs(signal2X(1:length(hz))), 'ro-')
hold on
plot(hz, 2*abs(signal1X(1:length(hz))), 'bs-')
set(gca,'xlim', [1 7])
legend({'Stationary';'Non-stationary'})

% Frequency non-stationarity
f = [2 10];
ff = linspace(f(1),mean(f),n);
signal1 = sin(2*pi.*ff.*t);
signal2 = sin(2*pi.*mean(ff).*t);

signal1X = fft(signal1)/n;
signal2X = fft(signal2)/n;
hz = linspace(0,srate/2, floor(n/2));

figure(14), clf    
subplot(211)
plot(t, signal1,'r', 'linew', 2), hold on
%plot(t, signal2,'r', 'linew', 2)
set(gca,'ylim',[-1.1 1.1])

subplot(212)
plot(hz, 2*abs(signal2X(1:length(hz))), 'ro-')
hold on
plot(hz, 2*abs(signal1X(1:length(hz))), 'bs-')
set(gca,'xlim', [0 20])

% examples of rhythmic non-sinusoidal time series

srate=1000;
time=(0:srate*6-1)/srate;
npnts = length(time);
hz=linspace(0,srate,npnts);

% various mildly interesting signals
signal = detrend(sin(cos(2*pi*time)-1));
%signal=sin(cos(2*pi*time)+time);
%signal=detrend(cos(sin(2*pi*time).^4));

figure(15), clf    
subplot(211)
plot(time, signal,'k', 'linew', 2)

subplot(212)
plot(hz, abs(fft(signal)), 'k', 'linew',3)
set(gca,'xlim', [0 20])
