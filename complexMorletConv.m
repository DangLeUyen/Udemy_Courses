clear

load uANTS_timefreq_MATLABfiles/v1_laminar.mat
% Data
data = csd(6,:,10); % only one trial

% Create a complex Morlet wavelet
time = (0:2*srate)/srate;
time = time - mean(time);
frex = 45; % Frequency of wavelet, in Hz

% Create Gaussian window
s = 7 / (2*pi*frex); % using num-cycles formula
cmw = exp(1i*2*pi*frex*time) .* exp(-time.^2/(2*s^2));

% CONVOLUTION
% Step 1: N's of convolution
nData = length(timevec);
nKern = length(cmw);
nConv = nData + nKern - 1;
halfK = floor(nKern/2);

% Step 2: FFTs
dataX = fft(data, nConv);
kernX = fft(cmw,nConv);
% Step 2.5: normalize the wavelet
kernX = kernX ./ max(kernX);

% Step 3: multiply spectra
convresK = dataX .* kernX;

% Step 4: IFFT
convres = ifft(convresK);

% Step 5: cut off 'wings'
convres = convres(halfK+1:end-halfK+1);

