% The complex dot product

% two vector
v1 = [3i 4 5 -3i];
v2  = [-3i 1i 1 0];

sum(v1.*v2)

% Complex dot product with wavelet
% phase of signal
theta = 3*pi/4;

% simulation params
srate=1000;
time = -1:1/srate:1;

% signal
signal = sin(2*pi*5*time + theta) .* exp((-time.^2)/.1);

% sine wave frequencies
sinefrex = 2:.5:10;

% plot signal
figure(2), clf
subplot(211)
plot(time,signal,'k','linew',2)

dps = zeros(size(sinefrex));
for fi=1:length(dps)
    csw = exp(1i*2*pi*time*sinefrex(fi));
    dps(fi) = dot(csw,signal)/length(signal);
end

subplot(212)
stem(sinefrex,abs(dps),'k','linew',3,'markersize',10)
set(gca,'xlim',[sinefrex(1)-.5 sinefrex(end)+.5],'ylim', [-.2 .2])


% IS the dot product still spectrum still dependent on the phase of the
% signal?
% NOOOO. 
