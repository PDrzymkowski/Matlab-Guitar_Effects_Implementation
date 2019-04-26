%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Efekt delay
%   Efekt symuluj¹cy echo sygna³u poprzez dodanie do orygina³u sygna³u
%   opóŸnionego i st³umionego
%   Parametry:
%       input- sygna³ wejœciowy (podany w próbkach)
%       Fs- czêstotliwoœæ próbkowania sygna³u oryginalnego 
%       delay- opóŸnienie sygna³u w ms
%       gain- przyrost sygna³u opóŸnionego wzglêdem orygina³u
%       version - okreœla wersjê FIR lub IIR u¿ywanego efektu
%   Opis dzia³ania:
%       Dodanie do obecnej próbki wartoœci próbki z przed "delayTime"
%       próbek temu, uwzglêdniajac zysk sygna³u opóŸnionego do orygina³u.
%
%   Przyk³adowe wywo³anie
%       output = delay(sygnal_audio, 44100, 200, 0.5, 'FIR');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = delay(input, Fs, delay, gain, version)

delayTime = floor(delay*Fs/1000);
output = zeros(length(input), 1);

for i = 1:delayTime
    output(i) = input(i);
end

if(strcmp(version, 'FIR'))
    for i = delayTime+1:length(input)
        output(i) = (1/(1+gain))*(input(i) + gain*input(i-delayTime));
    end
else
    for i = delayTIme+1:length(signal)
        output(i) = (1/(1+gain))*(input(i) + gain*output(i-delayTime));
    end
end
