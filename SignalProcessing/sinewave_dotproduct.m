% Dot product and sine waves

% Create 2 vectors
v1 = [2 4 2 1 5 3 1];
v2 = [4 2 2 -3 2 5 5];

% 2 ways to create the dot product
dp1 = sum(v1.*v2)
dp2 = dot(v1,v2)

% the dot product with sine waves

% phase of signal
theta = 1*pi/2;

% simulation params
srate=1000;
time = -1:1/srate:1;

% signal
signal = sin(2*pi*5*time + theta) .* exp((-time.^2)/.1);

% sine wave frequencies (Hz)
sinefrex = 2:.5:10;

% plot signal
figure(1), clf
subplot(211)
plot(time,signal,'k','linew',2)

dps = zeros(size(sinefrex));
for fi=1:length(dps)
    sinew = sin(2*pi*time*sinefrex(fi));
    dps(fi) = dot(sinew,signal)/length(time);
end

subplot(212)
stem(sinefrex,dps,'k','linew',3,'markersize',10)
set(gca,'xlim',[sinefrex(1)-.5 sinefrex(end)+.5],'ylim', [-.2 .2])


