% Complex numbers and Euler's formula

% Create a complex number
z = 4 + 3i;
z = 4 + 3*1i;
z = 4 + 3*sqrt(-1);
z = complex(4,3);

disp(['Real part is ' num2str(real(z)) ' and imaginary part is ' num2str(imag(z))])

% Beware of a common programming error
i = 2;
zz = 4 + 3*i;

% Note that it's not possible to set 1i to a variable

% Plot the complex number
figure(1), clf
plot(real(z), (z), 's')

% make plot look nicer
set(gca, 'xlim', [-5 5], 'ylim', [-5 5])
grid on, hold on, axis square
plot(get(gca , 'xlim'), [0 0], 'k', 'linew', 2)
plot([0 0], get(gca , 'ylim'), 'k', 'linew', 2)

%%%%%% EULER's FORMULA %%%%%%%%%

m = 4;
k = pi/3;
compnum = m*exp(1i*k);

% extract magnitude and angle
mag = abs(compnum); % OR mag = sqrt(real(compnum)^2 + imag(compnum)^2);
phs = angle(compnum);

% Plot
figure(2), clf
plot([0 real(compnum)], [0 real(compnum)], 'ro', 'linew',2)

set(gca, 'xlim', [-5 5], 'ylim', [-5 5])
grid on, hold on, axis square
plot(get(gca,'xlim'), [0 0], 'k', 'linew', 2)
plot([0 0], get(gca,'ylim'), 'k', 'linew', 2)

% draw a line using polar notation
h = polar([0 phs], [0 mag], 'r');
set(h, 'linewidth', 2)

% draw a unit circle
x = linspace(-pi, pi, 100);
h = plot(cos(x), sin(x));
set(h, 'color',[1 1 1]*.7)