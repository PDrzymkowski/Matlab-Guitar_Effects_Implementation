%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Efekt tremolo
%   Efekt tremolo sygna³u audio
%   Parametry:
%       input- sygna³ wejœciowy (podany w próbkach)
%       Fs- czêstotliwoœæ próbkowania sygna³u oryginalnego 
%       rate- czestotliwosc sygnalu modulujacego
%       depth- amplituda sygnalu modulujacego   
%       shape- kszta³t sygna³u moduluj¹cego(SIN, TRIangle lub SQUare)
%   Opis dzia³ania:
%       Efekt polega na modulacji amplitudowej sygna³u wejœciowego 
%       odpowiednim sygna³em moduluj¹cym.
%       
%   Przyk³adowe wywo³anie
%       output = tremolo(sygnal_audio, 44100, 2, 0.5, "SQU");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = tremolo(input, fs, rate, depth, shape)

%Obliczenie czêstotliwoœci unormowanej sygna³u moduluj¹cego
frequency_mod = rate / fs;

output = input(:,1);
n = 1:length(input);

% Sygna³ moduluj¹cy - trójk¹t
if shape == "TRI"
    output(n) = (1/(1+depth))*input(n, 1)'.*(1+depth*(sawtooth(2*pi*frequency_mod*n)));

% Sygna³ moduluj¹cy - prostok¹t
elseif shape == "SQU"
    output(n) = (1/(1+depth))*input(n, 1)'.*(1+depth*(square(2*pi*frequency_mod*n)));
    
% Sygna³ moduluj¹cy - sinus
else
    output(n) = (1/(1+depth))*input(n, 1)'.*(1+depth*(sin(2*pi*frequency_mod*n)));
end





