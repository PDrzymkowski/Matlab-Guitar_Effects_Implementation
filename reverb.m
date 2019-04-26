%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Efekt reverb
%   Efekt symuluj¹cy pog³os sygna³u wynikaj¹cy z propagacji fali
%   akustycznej w zamkniêtej przestrzeni/pomieszczeniu.
%   Parametry:
%       input- sygna³ wejœciowy (podany w próbkach)
%       Fs- czêstotliwoœæ próbkowania sygna³u oryginalnego 
%       room_size- rozmiar pomieszczenia, czyli iloœæ generowanego pog³osu 
%       depth- intensywnoœæ generowanego pog³osu 
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
function output = reverb(input, Fs, room_size, depth, pre_delay1, pre_delay2)


D1 = round(0.001*room_size*Fs);
D2 = round(0.001*room_size*1.17*Fs);
D3 = round(0.001*room_size*1.33*Fs);
D4 = round(0.001*room_size*1.5*Fs);
D5 = round(0.001*pre_delay1*Fs);
D6 = round(0.001*pre_delay2*Fs);

a1 = depth;
a2 = depth;
a3 = depth;
a4 = depth;
a5 = 0.7;
a6 = 0.7;

comb1_out = zeros(length(input),1);
comb2_out = zeros(length(input),1);
comb3_out = zeros(length(input),1);
comb4_out = zeros(length(input),1);
allpass1_out = zeros(length(input),1);
comb_sect_out = zeros(length(input),1);

output = zeros(length(input), 1);

for i = max([D1,D2,D3,D4,D5,D6])+1:length(input)
    comb1_out(i) = input(i) + a1*comb1_out(i-D1);
    comb2_out(i) = input(i) + a2*comb2_out(i-D2);
    comb3_out(i) = input(i) + a3*comb3_out(i-D3);
    comb4_out(i) = input(i) + a4*comb4_out(i-D4);
    
    comb_sect_out(i) = comb1_out(i) + comb2_out(i) + comb3_out(i) + comb4_out(i);
    
    allpass1_out(i) = -a5*comb_sect_out(i)+comb_sect_out(i-D5)+a5*allpass1_out(i-D5);
    
    output(i) = (-a6*allpass1_out(i)+allpass1_out(i-D6)+a6*output(i-D6));
end

output = output/max(abs(output));

end



