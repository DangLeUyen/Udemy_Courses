% Quantify "alpha" power over the scalp
clear
load uANTS_timefreq_MATLABfiles/restingstate64chans.mat

% nbchan: 64; trials:63; pnts:2028; srate:1024

EEG.data = double(EEG.data);

chanpowr = (2*abs(fft(EEG.data,[],2)/EEG.pnts)).^2;

% average over trials
chanpowr = mean(chanpowr,3);

% vector of frequencies
hz = linspace(0,EEG.srate/2, floor(EEG.pnts/2)+1);

figure(3), clf
plot(hz,chanpowr(:,1:length(hz)),'linew',2)

set(gca,'xlim',[0 30],'ylim',[0 50])

% extract alpha power
% boundaries in hz
alphabounds = [8 12]';

% convert to indices
freqidx = dsearchn(hz',alphabounds);

% extract average power
alphapower = mean(chanpowr(:, freqidx(1):freqidx(2)),2);

% plot
figure(4), clf
topoplotIndie(alphapower,EEG.chanlocs, 'numcontour')