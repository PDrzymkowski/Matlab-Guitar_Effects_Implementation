%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Efekt reverb
%   Efekt symuluj¹cy pog³os sygna³u wynikaj¹cy z propagacji fali
%   akustycznej w zamkniêtej przestrzeni/pomieszczeniu.
%   Parametry:
%       input- sygna³ wejœciowy (podany w próbkach)
%       Fs- czêstotliwoœæ próbkowania sygna³u oryginalnego 
%       room_size- rozmiar pomieszczenia, czyli iloœæ generowanego pog³osu 
%       depth1- intensywnoœæ generowanego pog³osu (wspó³czynnik filtrów
%       grzebieniowych)
%       depth2- intensywnoœæ generowanego pog³osu (wspó³czynnik filtrów
%       wszechprzepustowych)
%       pre_delay1- pierwszy efekt wczesnego echa 
%       pre_delay2- drugi efekt wczesnego echa 
%   Opis dzia³ania:
%       Dzia³anie efektu oparte jest o dzia³anie filtru grzebieniowego,
%       zmodyfikowanego tak, aby posiada³ p³ask¹ charakterystykê
%       amplitudow¹. Transformuje siê zatem uk³ad filtru celem otrzymania
%       uk³adu filtru wszechprzepustowego (celem uzyskania sprzê¿onych par
%       biegunów charakterystyki czêstotliwoœciowej). Celem minimalizacji
%       wp³ywu efektu na barwê dŸwiêków stosuje sie ³¹czenie filtrów:
%       -grzebioneowych równolegle(z okreœlonymi opóŸnieniami), aby uzyskaæ 
%       maksima ka¿dego filtru sk³adowego w char. amplitudowej 
%       -wszechprzepustowe szeregowo, aby zwiêkszyc efekt echa bez wp³ywu
%       na char. amplitudow¹.
%
%   Przyk³adowe wywo³anie
%       output = reverb(sygnal_audio, 44100, 30, 0.7, 3, 5);                                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = reverb(input, fs, room_size, depth1, depth2, pre_delay1, pre_delay2)

% Wartoœci opóŸnieñ filtrów grzebieniowych
D1 = round(room_size*fs/1000);
D2 = round(room_size*1.17*fs/1000);
D3 = round(room_size*1.33*fs/1000);
D4 = round(room_size*1.5*fs/1000);
% Wartoœci opóŸnieñ filtrów wszechpzepustowych
D5 = round(pre_delay1*fs/1000);
D6 = round(pre_delay2*fs/1000);

% Wartoœci wspó³czynników filtrów grzebieniowych
a1 = depth1;
a2 = depth1;
a3 = depth1;
a4 = depth1;
% Wartoœci wspó³czynników filtrów wszechprzepustowych
a5 = depth2;
a6 = depth2;

comb1_out = zeros(length(input), 1);
comb2_out = zeros(length(input), 1);
comb3_out = zeros(length(input), 1);
comb4_out = zeros(length(input), 1);
allpass1_out = zeros(length(input), 1);
comb_sect_out = zeros(length(input), 1);

output = input(:, 1);

for n = max([D1,D2,D3,D4,D5,D6])+1:length(input)
    
    % Sygna³y wyjœciowe poszczególnych filtrów grzebieniowych
    comb1_out(n) = input(n, 1) + a1*comb1_out(n-D1);
    comb2_out(n) = input(n, 1) + a2*comb2_out(n-D2);
    comb3_out(n) = input(n, 1) + a3*comb3_out(n-D3);
    comb4_out(n) = input(n, 1) + a4*comb4_out(n-D4);
    
    % Suma sygna³ów z filtrów grzebieniowych
    comb_sect_out(n) = comb1_out(n) + comb2_out(n) + comb3_out(n) + comb4_out(n);
    
    % Sygna³ wyjœciowy pierwszego stopnia filtru wszechprzepustowego
    allpass1_out(n) = -a5*comb_sect_out(n)+comb_sect_out(n-D5)+a5*allpass1_out(n-D5);
    
    % Sygna³ wyjœciowy drugiego stopnia filtru wszechprzepustowego
    output(n) = (-a6*allpass1_out(n)+allpass1_out(n-D6)+a6*output(n-D6));
end
% Przeskalowanie próbek sygna³u do zakresu <-1; 1>
output = output/max(abs(output));

end
