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