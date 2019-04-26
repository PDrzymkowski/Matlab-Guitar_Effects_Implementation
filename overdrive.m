%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Efekt overdrive
%   Efekt przesterowania sygna³u audio
%   Parametry:
%       input- sygna³ wejœciowy (podany w próbkach)
%       Fs- czêstotliwoœæ próbkowania sygna³u oryginalnego 
%       clipValue- próg przesterowywania sygnalu
%   Opis dzia³ania:
%       Zmiana wartoœci próbki do opisanej algorytmem wartoœci w zale¿noœci
%       od poziomu tej¿e próbki
%
%   Przyk³adowe wywo³anie
%       output = overdrive(sygnal_audio, 44100, 0.05);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = overdrive(input, Fs, clipValue)

output = zeros(length(input), 1);

for i = 1:length(input)
    if ((input(i)) <= -(2/3)*clipValue)
        output(i) = -clipValue;
    else
        if (input(i) <= -(1/3)*clipValue)
            output(i) = clipValue*(-3+(2+3*input(i)/clipValue)^2)/3;
        else
            if (abs(input(i) <= (1/3)*clipValue))
                output(i) = 2*input(i);
            else
                if (input(i) <= (2/3)*clipValue)
                    output(i) = clipValue*(3-(2-3*input(i)/clipValue)^2)/3;
                else
                    output(i) = clipValue;
                end
            end
        end
    end
end
