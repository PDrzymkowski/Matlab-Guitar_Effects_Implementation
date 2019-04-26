%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Efekt chorus
%   Efekt chorus (brzmienia chóralnego) sygna³u dŸwiêkowego
%   Parametry:
%       input- sygna³ wejœciowy (podany w próbkach)
%       Fs- czêstotliwoœæ próbkowania sygna³u oryginalnego 
%       delay- bazowa wartoœæ opóznienia sygna³u
%       rate_1, rate_2- czêstotliwoœæ "przemiatania" sygna³u oscylatorem 
%       LFO (pierwszego oraz drugiego)
%       depth_1, depth_2- amplituda sygna³u moduluj¹cego obu oscylatorów
%       wzglêdem sygna³u wejœciowego
%       version- wersja efektu FIR lub IIR
%   Opis dzialania:
%       Struktura podobna do struktury efektu flanger. Na sygna³ nak³adane
%       s¹ dwa lekko opóŸnione i zmodulowane sygna³y, czego efektem jest 
%       charakterystyczne "chóralne" brzmienie dŸwiêku. Czêstotliwoœæ
%       sygna³ów moduluj¹cych powinna byæ w granicach (0.1-0.5Hz).
%       Amplitudy tych sygna³ów wzglêdem sygna³u oryginalnego mog¹ byæ
%       modyfikowane.
%       
%   Przyk³adowe wywo³anie
%       output = chorus(sygna³_audio, 44100, 15, 0.1, 0.5, 0.2, 0.3 'FIR');  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = chorus(input, Fs, delay, rate_1, depth_1, rate_2, depth_2, version)

max_delay = floor(delay*Fs/1000);

frequency_change_1= rate_1/Fs;
frequency_change_2= rate_2/Fs;

output = zeros(length(input),1);

for i = 1:max_delay
    output(i) = input(i);
end

if(strcmp(version,'FIR'))
    for i = max_delay:length(input)
        delayTime_1 = 1 + round(max_delay/2*(1-cos(2*pi*frequency_change_1*i)));
        delayTime_2 = 1 + round(max_delay/2*(1-cos(2*pi*frequency_change_2*i)));
        output(i) =1/((1+depth_1+depth_2))* (input(i) + depth_1*input(i-delayTime_1) + depth_2*input(i-delayTime_2));
    end
else
     for i = max_delay:length(input)
         delayTime_1 = 1 + round(max_delay/2*(1-cos(2*pi*frequency_change_1*i)));
         delayTime_2 = 1 + round(max_delay/2*(1-cos(2*pi*frequency_change_2*i)));
        output(i) = 1/((1+depth_1+depth_2))*(input(i) + depth_1*output(i-delayTime_1) + depth_2*output(i-delayTime_2));
     end
end
