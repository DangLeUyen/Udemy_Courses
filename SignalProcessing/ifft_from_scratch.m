% Inverse fft from scratch

N = 50;
signal = sin(linspace(0,4*pi,N)) + rand(1,N)/2; % data
fTime = ((1:N)-1)/N;

% initialize Fourier output matrix
fourierCoefs = zeros(size(signal));

for fi=1:N
    % complex sine wave for this frequency
    fourierSine = exp(-1i*2*pi*fTime*(fi-1));
    % dot product as sum ofpoint-wise multiplications
    fourierCoefs(fi) =  sum(fourierSine .* signal);
    
end

% divide by N to scale coefs properly
fourierCoefs = fourierCoefs/N;

% use the fft function for comparison
fourierCoefsF = fft(signal)/N;

% reconstruct signal
reconSig = zeros(size(signal));

for fi=1:N
    % create "template" sine waves
    fourierSine = exp(1i*2*pi*fTime*(fi-1));
    % modulate by fourier coefficient and add to reconstruted signal
    reconSig = reconSig + fourierCoefs(fi)*fourierSine;
end

% plot
figure(1), clf, hold on
plot(signal, 'b*-')
plot(real(reconSig), 'ro')
plot(real(ifft(fourierCoefsF))*N, 'ko')
xlabel('Time')