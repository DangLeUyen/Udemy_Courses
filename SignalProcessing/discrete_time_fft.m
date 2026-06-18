% Discrete-time Fourier Transform

% define a sampling rate
srate=1000;

% params
frex=[3 10 5 15 35];
amplit=[5 15 10 5 7];

% define time
time=-1:1/srate:1;

% Loop through frequencies and create sine waves
signal=zeros(1,length(time));
for fi=1:length(frex)
    signal=signal+amplit(fi)*sin(2*pi*time*frex(fi));
end

% The Fourier transform in a loop
N = length(signal);
fourierTime = (0:N-1)/N;
nyquist = srate/2;

% initialise Fourier output matrix
fourierCoefs = zeros(size(signal));

% loop over frequences
for fi=1:N
    % create complex-valued sine  wave for this frequency
    fourierSine = exp(-1i*2*pi*fourierTime*(fi-1));
    % compute dot product between sine wave and signal
    fourierCoefs(fi) = dot(fourierSine,signal);
end

% scale Fourier coefs to original scale
fourierCoefs = fourierCoefs/N;

% actual frequencies in Hz
frequencies = linspace(0,nyquist,floor(N/2)+1);

figure(1), clf
subplot(221)
plot(real(exp(-2*pi*1i*(10) .* fourierTime)))

subplot(222)
plot(signal)

subplot(212)
plot(frequencies,abs(fourierCoefs(1:length(frequencies)))*2,'-*')

% The fast-Fourier Transform

% compute fourier transform and scale
fourierCoefsF = fft(signal)/N;

subplot(212), hold on
plot(frequencies,abs(fourierCoefsF(1:length(frequencies)))*2,'ro')
