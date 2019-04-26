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
function output = flanger(input, Fs, delay, rate, gain, version)

max_delay = floor(delay*Fs/1000);

frequency_change= rate/Fs;

output = zeros(length(input),1);

for i = 1:max_delay
    output(i) = input(i);
end

if(strcmp(version,'FIR'))
    for i = max_delay:length(input)
        delayTime = 1 + round(max_delay/2*(1-cos(2*pi*frequency_change*i)));
        output(i) = (1/(1+gain)) * (input(i) + gain*input(i-delayTime));
    end
else
     for i = max_delay:length(input)
         delayTime = 1 + round(max_delay/2*(1-cos(2*pi*frequency_change*i)));
        output(i) = (1/(1+gain)) * (input(i) + gain*output(i-delayTime));
     end
end
