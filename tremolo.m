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
function output = tremolo(input, Fs, rate, depth, shape)

frequency_mod = rate / Fs;

output = zeros(length(input),1);

if shape == "TRI"
for i = 1:length(input)
    output(i) = (1/(1+depth))* input(i)*(1+depth*(sawtooth(2*pi*frequency_mod*i)));
end

elseif shape == "SQU"
for i = 1:length(input)
    output(i) = (1/(1+depth))* input(i)*(1+depth*(square(2*pi*frequency_mod*i)));
end

else
for i = 1:length(input)
    output(i) = (1/(1+depth))* input(i)*(1+depth*(cos(2*pi*frequency_mod*i)));
end

end





