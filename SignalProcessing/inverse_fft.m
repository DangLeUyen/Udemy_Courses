% Reconstruct a signal via inverse Fourier Transform


% create the signal
srate=1000;
time=-1:1/srate:1;

frex = [3 10 5 15 35];

signal = zeros(1, length(time))
for fi=1:length(frex)
    signal = signal + fi *sin(2*pi*time*frex(fi));
end


% Inverse the Fourier Transform
N = length(signal);
fourierTime = (0:N-1)/N;

reconSignal = zeros(size(signal));
fourierCoef = fft(signal)/N;

% lopp over frequencies

for fi=1:N
    fourierSine = fourierCoef(fi) * exp(-1i*2*pi*(fi-1).*fourierTime);

    reconSignal = reconSignal + fourierSine;
end

figure(5), clf
plot(real(reconSignal), '.-')
hold on
plot(signal, 'ro-')
zoom on
legend({'reconstructed', 'original'})