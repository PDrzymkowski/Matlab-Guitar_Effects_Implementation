
% 1 sek. ciszy - 0.1 sek sinus 500Hz 1Vpp - 1 sek. ciszy
fs = 44100;
dt = 1/fs;
StopTime = 0.1; 
t = (0:dt:StopTime)';  
F = 500; % Sine wave frequency (hertz) 
data = 0.5*sin(2*pi*F*t);
data(0.1*44100+1:1:1.1*44100+1) = zeros();
t = (0:dt:2.1)'; % seconds 
zero_data = zeros(44100,1);
data = [zero_data; data];
figure();
plot(t,data)
axis([0 inf -1 1])
grid;
title('Nieokresowy sygna³ wejœciowy')
xlabel('Czas [s]')
ylabel('Amplituda')

%sound(data, fs);
audiowrite('soi_delay.wav', data, fs);

% 1 sek. ciszy - 0.1 sek sinus 500Hz 1Vpp - 3 sek. ciszy
StopTime = 0.1;
t = (0:dt:StopTime)'; 
F = 500; % Sine wave frequency (hertz) 
data = 0.5*sin(2*pi*F*t);
data(0.1*44100+1:1:3.1*44100+1) = zeros();
t = (0:dt:4.1)'; % seconds 
zero_data = zeros(44100,1);
data = [zero_data; data];
figure();
plot(t,data)
axis([0 inf -1 1])
grid;
title('Nieokresowy sygna³ wejœciowy')
xlabel('Czas [s]')
ylabel('Amplituda')

%sound(data, fs);
audiowrite('noi_delay.wav', data, fs);

% 5sek. Prostok¹t 500Hz 1Vpp
StopTime = 5;
t = (0:dt:StopTime)'; 
F = 500; % Sine wave frequency (hertz) 
data = 0.5*square(2*pi*F*t);
t = (0:dt:5)'; % seconds 
figure();
plot(t,data)
axis([0 inf -1 1])
grid;
title('Nieokresowy sygna³ wejœciowy')
xlabel('Czas [s]')
ylabel('Amplituda')

%sound(data, fs);
audiowrite('prostokat.wav', data, fs);