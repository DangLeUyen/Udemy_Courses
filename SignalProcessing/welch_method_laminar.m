% Welch's method on v1 laminar data

clear
load uANTS_timefreq_MATLABfiles/v1_laminar.mat
csd = double(csd);

% specify a channel for the analyses
chan2use = 7;

% create Hann window
hannw = .5 -cos(2*pi*linspace(0,1,size(csd,2)))./2;

% Welch's method using pwelch
[pxx, hz] = pwelch(squeeze(csd(chan2use,:,:)),hannw,round(size(csd,2)/10),1000,srate);

figure(3), clf
subplot(211)
plot(timevec,mean(csd(chan2use,:,:),3),'linew',2)
set(gca,'xlim',timevec([1 end]))

subplot(212)
plot(hz,mean(pxx,2),'linew',2)
set(gca,'xlim',[0 140])
