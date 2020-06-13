%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Efekt delay
%   Efekt symuluj¹cy echo sygna³u poprzez dodanie do orygina³u sygna³u
%   opóŸnionego i st³umionego
%   Parametry:
%       input- sygna³ wejœciowy (podany w próbkach)
%       Fs- czêstotliwoœæ próbkowania sygna³u oryginalnego 
%       delay_value- opóŸnienie sygna³u w ms
%       gain- przyrost sygna³u opóŸnionego wzglêdem orygina³u
%       version - okreœla wersjê FIR lub IIR u¿ywanego efektu
%   Opis dzia³ania:
%       Dodanie do obecnej próbki wartoœci próbki z przed "delayTime"
%       próbek temu, uwzglêdniajac zysk sygna³u opóŸnionego do orygina³u.
%
%   Przyk³adowe wywo³anie
%       output = delay(sygnal_audio, 44100, 200, 0.5, 'FIR');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = delay(input, fs, delay_value, gain, version)

% Obliczenie liczby probek opoznienia sygnalu audio
delay_time = floor(delay_value*fs/1000);

output = input(:,1);
n = delay_time+1:length(input);
 
if(strcmp(version, 'FIR'))
    % Dodanie opoznionej probki do bie¿¹cej w wersji SOI efektu
    output(n) = (1/(1+gain))*(input(n, 1) + gain*input(n-delay_time, 1));              
else
    % Dodanie opoznionej probki do bie¿¹cej w wersji NOI efektu
    for n = delay_time+1:length(input)
        output(n) = (1/(1+gain))*(input(n, 1) + gain*output(n-delay_time));
    end                       
end

