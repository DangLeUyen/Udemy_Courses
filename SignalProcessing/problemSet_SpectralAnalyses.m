%%%%%%%% Problem set: Spectral analyses %%%%%%%%%%

%% 1. Generate 10 seconds of data at 1 Hz, comprising 4 sine waves with
% different frequencies (1-30 Hz) and different amplitudes

srate = 1000;
frex = [3 10 15 30];
amplit = [5 15 5 7];
phases = [pi/8 pi pi/2 -pi/4];
time = -1:1/srate:1;
pnts = length(time);
% Create sine waves
sine_waves =  zeros(length(frex),length(time));

for fi=1:length(frex)
    sine_waves(fi,:) = amplit(fi) * sin(2*pi*time*frex(fi) + phases(fi));
end

littleNoise = randn(size(time)) * 10;
lotsofNoise = randn(size(time)) * 50;

figure(1), clf

for snum=1:4
    subplot(4,1,snum)
    plot(time,sine_waves(snum,:))
end
xlabel("Time"), ylabel("Amplitude")

% Plot summed sine waves with little noise
figure(2), clf
subplot(211)
plot(time, sum(sine_waves)+littleNoise)
title('Time series with litte noise')

subplot(212)
plot(time, sum(sine_waves)+lotsofNoise)
title('Time series with lots of noise')

%% 2. Compute the power spectrum of the simulated time series (use FFT)

figure(3), clf

for noisei=1:2
    % FFT
    if noisei==1
        f = fft(sum(sine_waves,1)+littleNoise)/pnts;
    else
        f = fft(sum(sine_waves,1)+lotsofNoise)/pnts;
    end
    % compute frequencies in Hz
    hz = linspace(0,srate,pnts);
    % plot the amplitude spectrum
    
    subplot(2,1,noisei)
    plot(hz,2*abs(f),'k','linew',2)
    xlabel('Frequencies (Hz)'), ylabel('Amplitude')
    set(gca,'xlim',[0 35], 'ylim', [0 max(amplit)*1.2])

    if noisei==1
        title('FFT with Little noise')
    else
        title('FFT with Lots of noise')
    end
end

%% 3. Compute the power spectrum of data from electrode 7 in the laminar V1 dât.

% load the LFP data
load v1_laminar.mat
pnts = length(timevec);
% pick which channel
chan2use = 7;

% FFT of all trials individually
powspectSeparate = fft(squeeze(csd(chan2use,:,:)),[],1)/pnts;
% Average the single-trial spectra together
powspectSeparate = mean(2*abs(powspectSeparate),1);

% now average first, then take the FFT of the trial average
powspectAverage = 2 * abs(fft(mean(csd(chan2use,:,:),3))/pnts);

% frequencies in Hz
hz = linspace(0,srate/2,floor(pnts/2)+1);

% plot
figure(4), clf 
subplot(211)
plot(hz,powspectSeparate(1:length(hz)),'linew',4)
set(gca,'xlim',[0 100])
xlabel('Frequency (Hz)'), ylabel('Amplitude')

subplot(212)
plot(hz,powspectAverage(1:length(hz)),'LineWidth',4)
xlabel('Frequency(Hz)'), ylabel('Amplitude')
set(gca,'xlim',[0 100])

%% 4. Fourier transform ffrom scratch!

N = 20;
signal = randn(1,N);
fTime = (0:N-1)/N;

% initialize Fourier output matrix
fourierCoefs = zeros(size(signal));

for fi=1:N
    fourierSine = exp(-1i*2*pi*(fi-1)*fTime);
    fourierCoefs(fi) = dot(signal,fourierSine);
end

fourierCoefs = fourierCoefs/N;

figure(5), clf
subplot(211)
plot(signal)
title('Data')

subplot(212)
plot(abs(fourierCoefs)*2,'*-')
xlabel('Frequency (a.u.)')

fourierCoefsF = fft(signal)/N;

hold on
plot(abs(fourierCoefsF)*2,'ro')
legend({'Manual FT';'FFT'})

%% 5. Zero-padding and interpolation

load uANTS_timefreq_MATLABfiles/v1_laminar.mat
chan2use = 7;
pnts = length(timevec);
tidx(1) = dsearchn(timevec',0);
tidx(2) = dsearchn(timevec',.5);

nfft = 2 * (diff(tidx)+1);

powspect = mean(2*abs(fft(squeeze(csd(chan2use,tidx(1):tidx(2),:)),nfft,1)/pnts).^2,2);
hz = linspace(0, srate/2, floor(nfft/2)+1);

figure(7), clf
plot(hz, powspect(1:length(hz)),'k-o')
set(gca, 'xlim', [0 120])

%% 6. Poor man's filter via frequency-domain manipulations.

srate=1234;
npnts = srate*3;
time = (0:npnts-1)/srate;

% the key parameter of pink noise is the exponential decay
ed = 50;
as = rand(1,npnts).* exp(-(0:npnts-1)/ed);
fc = as.* exp(1i*2*pi*rand(size(as)));

signal = real(ifft(fc)) * npnts;

% add 50 Hz line noise
signal = signal + sin(2*pi*50*time);

% compute its spectrum
hz =linspace(0,srate/2, floor(npnts/2)+1);
signal1X = fft(signal);

figure(8), clf
subplot(211)
plot(time,signal, 'k')
xlabel('TIme'), ylabel('Activity')

subplot(212)
plot(hz, (2*abs(signal1X(1:length(hz)))/npnts).^2,'k')
set(gca,'xlim',[0 80])
xlabel('Frequency'), ylabel('Amplitude')

% zero-out the 50 Hz component
% find the index into the frequencies vector at 50 hz
hz50ix = dsearchn(hz',50);

% create a copy of the Fourier transform
signal1Xf = signal1X;

%sero-out the 50Hz component
signal1Xf(hz50ix) = 0;
signal1Xf(end-hz50ix+2) = 0;

% take the ifft
signalff = real(ifft(signal1Xf));

signal1Xf = fft(signalff);

% plot
figure(9), clf
subplot(211), hold on
plot(time,signal, 'k')
plot(time,signalff,'r')
xlabel('TIme'), ylabel('Activity')

subplot(212), hold on
plot(hz, (2*abs(signal1X(1:length(hz)))/npnts),'k')
plot(hz, (2*abs(signal1Xf(1:length(hz)))/npnts),'ro-')
set(gca,'xlim',[0 80])
xlabel('Frequency'), ylabel('Amplitude')


