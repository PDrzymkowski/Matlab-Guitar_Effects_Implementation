%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Efekt overdrive
%   Efekt przesterowania sygna³u audio
%   Parametry:
%       input- sygna³ wejœciowy (podany w próbkach)
%       clip_value- próg przesterowywania sygnalu
%   Opis dzia³ania:
%       Zmiana wartoœci próbki do opisanej algorytmem wartoœci w zale¿noœci
%       od poziomu tej¿e próbki
%
%   Przyk³adowe wywo³anie
%       output = overdrive(sygnal_audio, 44100, 0.05);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = overdrive(input, clip_value)

output = input(:, 1);

% Realizacja obciêcia sygna³u w zale¿noœci od poziomu amplitudy
for n = 1:length(input)
    switch true
        case input(n) <= -(2/3)*clip_value
            output(n) = -clip_value;
        case input(n) <= -(1/3)*clip_value
            output(n) = clip_value*(-3+(2+3*input(n)/clip_value)^2)/3;
        case abs(input(n)) <= (1/3)*clip_value
            output(n) = 2*input(n);
        case input(n) <= (2/3)*clip_value
            output(n) = clip_value*(3-(2-3*input(n)/clip_value)^2)/3;
        otherwise
            output(n) = clip_value;
    end
end