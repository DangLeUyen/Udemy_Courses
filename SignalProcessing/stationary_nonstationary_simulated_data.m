%% FFT of stationary and non-stationary simulated data

%% 1. Frequency non-stationarity

srate = 1000;
n = 4000;
t = (0:n-1)/srate;

% create signals (sine wave and linear chirp)
f = [2 10]; % 2 frequencies
ff = linspace(f(1), mean(f), n);
signal1 = sin(2*pi.*ff.*t);
signal2 = sin(2*pi.*mean(f).*t);

% Fourier spectra
signal1X = fft(signal1)/n;
signal2X = fft(signal2)/n;
hz = linspace(0,srate/2,floor(n/2)+1);

% amplitude spectra
signal1Amp = abs(signal1X(1:length(hz)));
signal1Amp(2:end-1) = 2*signal1Amp(2:end-1);

signal2Amp = abs(signal2X(1:length(hz)));
signal2Amp(2:end-1) = 2*signal2Amp(2:end-1);

% plot the signals
figure(1), clf
subplot(211)
plot(t, signal1,'b'), hold on
plot(t, signal2,'r')
xlabel('Time'), ylabel('Amplitude')

subplot(212)
plot(hz,signal1Amp, '.-', 'linew',2), hold on
plot(hz,signal2Amp, 'r.-','linew',2)
set(gca,'xlim',[0 20])
xlabel('Frequency (Hz)'), ylabel('Amplitude')
legend({'Non-stationary';'Stationary'})

%% 2. Amplitude non-stationary
srate = 1000;
n = 4000;
t = (0:n-1)/srate;

% create signals
f = 6;
ampmod = 2*interp1(rand(1,10),linspace(1,10,n),'pchip');

signal1 = ampmod .* sin(2*pi.*f.*t);
signal2 = sin(2*pi.*f.*t);

% Fourier spectra
signal1X = fft(signal1)/n;
signal2X = fft(signal2)/n;
hz = linspace(0,srate/2,floor(n/2));

% amplitude spectra
signal1Amp = abs(signal1X(1:length(hz)));
signal1Amp(2:end-1) = 2*signal1Amp(2:end-1);

signal2Amp = abs(signal2X(1:length(hz)));
signal2Amp(2:end-1) = 2*signal2Amp(2:end-1);

% plot the signals
figure(2), clf
subplot(211)
plot(t, signal1,'b'), hold on
plot(t, signal2,'r')
xlabel('Time'), ylabel('Amplitude')

subplot(212)
plot(hz,signal1Amp, '.-', 'linew',2), hold on
plot(hz,signal2Amp, 'r.-','linew',2)
set(gca,'xlim',[0 20])
xlabel('Frequency (Hz)'), ylabel('Amplitude')
legend({'Non-stationary';'Stationary'})
