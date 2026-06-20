% Normalisation of Fourier Transform

% create a signal
srate=1000;
time=(0:3*srate-1)/srate; % time vector in second
pnts=length(time); % number of time points
signal=2.5*sin(2*pi*4*time);

% Prepare for Fourier Transform
fourTime = (0:pnts-1)/pnts;
fCoefts=zeros(size(signal));

for fi=1:pnts
    csw=exp(-1i*2*pi*(fi-1)*fourTime);
    fCoefts(fi)=sum(signal.*csw);
end

%extract amplitudes
ampls=abs(fCoefts/pnts);

% compute frequencies vector
hz = linspace(0,srate/2,floor(pnts/2)+1);

figure(1), clf
stem(hz,ampls(1:length(hz)),'ks-', 'linew', 3)

set(gca,'xlim',[0 10])


%%%%%%% DC reflects the mean offet
figure(2), clf

signalX1 = fft(signal+2)/pnts;
signalX2=fft(signal-mean(signal))/pnts;
signalX3=fft(signal+10)/pnts;


% plot
subplot(211), hold on
plot(ifft(signalX1)*pnts,'bo-')
plot(ifft(signalX2)*pnts,'rd-')
plot(ifft(signalX3)*pnts,'k*-')

subplot(212)
plot(hz,2*abs(signalX1(1:length(hz))),'bo-','Linew',2)
plot(hz,2*abs(signalX2(1:length(hz))),'rd-','Linew',2)
plot(hz,2*abs(signalX3(1:length(hz))),'k*-','Linew',2)
