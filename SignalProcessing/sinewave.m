% Sine waves and their parameters

% sample rate
srate = 1000;

% list some frequences
frex = [3 10 5 15 35];

% some amplitudes
amplit = [5 15 10 5 7];

% phrase
phrases = [pi/7 pi/8 pi pi/2 -pi/4];

% define time
time = -1:1/srate:1;

% Loop through frequencies and create sine waves
sine_waves = zeros(length(frex), length(time));
for fi=1:length(frex)
    sine_waves(fi,:) = amplit(fi) * sin(2*pi*time*frex(fi) + phrases(fi));
end

% plot
figure(1), clf
for sinei=1:length(amplit)
    subplot(length(amplit),1,sinei)
    plot(time,sine_waves(sinei,:),'k')
end

figure(2), clf
subplot(211)
plot(time,sum(sine_waves,1),'k')
xlabel('Time (s)')
