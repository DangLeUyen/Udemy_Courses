% Fourier Transform from scratch

% random signal
N = 50;
signal = sin(linspace(0,4*pi,N)) + rand(1,N)/2; % data
fTime = ((1:N)-1)/N;

% initialize Fourier output matrix
fourierCoefs = zeros(size(signal));

for fi=1:N
    % complex sine wave for this frequency
    fourierSine = exp(-1i*2*pi*fTime*(fi-1));
    % dot product as sum ofpoint-wise multiplications
    fourierCoefs(fi) = dot(fourierSine, signal);
    % or sum(fourierSine .* signal)
end

% divide by N to scale coefs properly
fourierCoefs = fourierCoefs/N;

% use the fft function for comparison
fourierCoefsF = fft(signal)/N;

% plot
figure(1), clf
subplot(211)
plot(signal)

% amplitude of manual fourier transform
subplot(212), hold on
plot(abs(fourierCoefs)*2, '*-')

% amplitude of fft
plot(abs(fourierCoefsF)*2, 'ro')

xlabel('Frequency (a.u.)')
legend('Manual ft', 'fft')


    