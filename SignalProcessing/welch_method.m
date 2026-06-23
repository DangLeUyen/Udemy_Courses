% Welch's method for smooth spectral decomposition
% Smooths over non-systematic noise
% Robust to some non-stationarities
% Reduced spectral precision >< maximal spectral precision of full fft
% No temporal dynamics

% ON PHASE-SLIP DATA
srate = 1000;
time = (0:srate-1)/srate;

signal = [ sin(2*pi*10*time) sin(2*pi*10*time(end:-1:1))];

figure(1), clf
subplot(211)
plot(signal)

subplot(223)
bar(linspace(0,srate,length(signal)),2*abs(fft(signal))/length(signal));
set(gca, 'xlim', [5 15])
title('Static FFT')
xlabel('Frequency (Hz)')

% Welch's parameters
winlen = 500;
skip=100;

hzL = linspace(0,srate/2, floor(winlen/2)+1);

welchspect = zeros(1,length(hzL));

hwin = .5*(1-cos(2*pi*(1:winlen)/(winlen-1)));

nbins=1;
% loop over time windows
for ti=1:skip:length(signal)-winlen
    % extract part of the signal
    tidx = ti:ti+winlen-1;
    tmpdata=signal(tidx);
    x = fft(hwin.*tmpdata)/winlen;
    welchspect = welchspect + 2*abs(x(1:length(hzL)));
    nbins = nbins+1;
end

welchspect = welchspect/nbins;

subplot(224)
bar(hzL,welchspect)
set(gca,'xlim',[5 15])
title('Welch method') 
xlabel('Frequency (Hz)')