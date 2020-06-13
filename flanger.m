%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Efekt flanger
%   Efekt flanger sygna³u audio
%   Parametry:
%       input- sygna³ wejœciowy (podany w próbkach)
%       Fs- czêstotliwoœæ próbkowania sygna³u oryginalnego 
%       delay- bazowa wartoœæ opóznienia sygna³u
%       rate- czestotliwosc "przemiatania" sygna³u oscylatorem LFO
%       gain- stosunek sygna³u opóŸnianego do oryginalnego
%       version- wersja efektu FIR lub IIR
%   Opis dzia³ania:
%       Struktura podobna do struktury efektu delay. Sygna³ wejœciowy
%       zostaje wstêpnie opózniony o ma³¹ wartoœæ a nastêpnie zmodulowany
%       sygna³em sinusoidalnym. OpóŸnienie ka¿dej próbki jest zmienne i
%       zale¿ne od czêstotliwoœci "przemiatania" oscylatorem
%       LFO. Stosunek sygna³u opóznionego do oryginalnego mo¿e byæ
%       modyfikowany.
%       
%   Przyk³adowe wywo³anie
%       output = flanger(sygnal_audio, 44100, 15, 0.5, 0.3, 'FIR');  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = flanger(input, fs, delay, rate, gain, version)

% Obliczenie liczby probek opoznienia sygnalu audio
max_delay = floor(delay*fs/1000);

% Obliczenie czêstotliwoœci unormowanej sygna³u moduluj¹cego
frequency_change= rate/fs;

output = input(:, 1);
n = max_delay+1:length(input);
delay_time = floor(max_delay*abs(sin(2*pi*frequency_change*n)));

if(strcmp(version,'FIR'))
    % Realizacja efektu Flanger w wersji SOI 
    output(n) =  (1/(1+gain)) * (input(n, 1) + gain*input(n-delay_time, 1));
else
     for n = max_delay+1:length(input)
         % Realizacja efektu Flanger w wersji NOI 
         output(n) =  (1/(1+gain)) * (input(n, 1) + gain*output(n-delay_time(n-max_delay)));
     end
end
