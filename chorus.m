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
function output = chorus(input, fs, delay, rate_1, depth_1, rate_2, depth_2, version)

% Obliczenie liczby probek opoznienia sygnalu audio
max_delay = floor(delay*fs/1000);

% Obliczenie czêstotliwoœci unormowanych sygna³ów moduluj¹cych
frequency_change1= rate_1/fs;
frequency_change2= rate_2/fs;

output = input(:, 1);
n = max_delay+1:length(input);
delay_time1 = floor(max_delay*abs(sin(2*pi*frequency_change1*n)));
delay_time2 = floor(max_delay*abs(sin(2*pi*frequency_change2*n)));

if(strcmp(version,'FIR'))
    % Realizacja efektu Chorus w wersji SOI 
    output(n) =1/((1+depth_1+depth_2))* (input(n, 1) + depth_1*input(n-delay_time1, 1) + depth_2*input(n-delay_time2, 1));
    
else
     for n = max_delay+1:length(input)
         % Realizacja efektu Chorus w wersji NOI 
        output(n) = 1/((1+depth_1+depth_2))*(input(n, 1) + depth_1*output(n-delay_time1(n-max_delay)) + depth_2*output(n-delay_time2(n-max_delay)));
     end
end
