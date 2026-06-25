% Welch's method on resting-state EEG data

load uANTS_timefreq_MATLABfiles/EEGrestingState.mat
N = length(eegdata);

% time vector
timevec = (0:N-1)/srate;

% plot the data
figure(1), clf
plot(timevec, eegdata, 'k')
xlabel('Time (s)'), ylabel('Voltage')

% winlength = second*srate
winlength = 3.4*srate;

% number of points of overlap
nOverlap = round(srate/2);

% window onset times
winonsets = 1:nOverlap:N-winlength;

% note: different-length signal needs a different 
hzW = linspace(0,srate/2,floor(winlength/2)+1);

% hann window
hannw = .5 - cos(2*pi*linspace(0,1,winlength))./2;

% initialise the power matrix
eegpowW = zeros(1,length(hzW));

for wi=1:length(winonsets)
    datachunk = eegdata(winonsets(wi):winonsets());
    datachunk = datachunk .* hannw;
    % compute its power
    tmppow = abs(fft(datachunk)/winlength).^2;

    eegpowW = eegpowW + tmppow(1:length(hzW));
end

eegpowW = eegpowW/length(winonsets);

% Plotting
figure(2), clf
subplot(211), hold on
plot(hz,eegpow(1:length(hz)),'k','linew',2)
plot(hzW,eegpowW/10,'r','linew',2)
set(gca,'xlim',[0 40])
xlabel('Frequency (Hz)')

subplot(212)
winsize = 2*srate;
hannw = .5 - cos(2*pi*linspace(0,1,winsize))./2;

nfft = srate*100;
pwelch(eegdata,hannw,round(winsize/4),nfft,srate);
set(gca, 'xlim', [0 40])

