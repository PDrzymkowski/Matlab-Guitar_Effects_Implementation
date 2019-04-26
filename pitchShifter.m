%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Efekt pitchShifter
%   Efekt przesuniêcia wysokoœci dŸwiêku sygna³u, zachowuj¹c zawart¹ w nim
%   harmoniê dŸwiêków i czas trwania.
%   Parametry:
%       input- sygna³ wejœciowy (podany w próbkach)
%       pitch- liczba pó³tonów
%       mode- okreœla, czy sygnal wyjsciowy ma zast¹piæ sygna³ wejœciowy
%       ("REPLACE"), czy zostaæ do niego dodany ("ADD")
%       gain- stosunek sygna³u przesuniêtego w wysokoœci do wejœciowego
%       (opcjonalny, tylko dla mode="ADD")
%   Opis dzia³ania:
%       Efekt dzia³a na bazie algorytmu wokodera fazowego. Czêstotliwoœæ
%       tonu podstawowego oraz wy¿szych harmonicznych jest przeskalowana
%       przez wspó³czynnik alpha. Nastêpuje przesuniêcie wysokoœci dŸwiêku
%       ('pitch shifting').
%
%   Przyk³adowe wywo³anie
%       output = pitchShifter(sygnal_audio, 2, 'ADD', 0.5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = pitchShifter(input, pitch, mode, gain)

alpha = 2.^(pitch/12); % wspolczynnika skalowania
N = 1024;              % dlugosc ramki dzielacej sygnal
Ra = N/4;              % przesuniecie miedzy ramkami (ramki nachodza na sb w 75%)
Rs = round(alpha*Ra);  % przesuniecie miedzy ramkami w etapie syntezy
h = hann(2*N+1);       % okno hanninga (symetryczne)
h = h(2:2:end);
Omega = ((0:N-1)*2*pi/N)';  % zbior pulsacji N-pktowej FFT

output = zeros(round(alpha*length(input)+N),1);

%algorytm wokodera fazowego
%faza poczatkowa

X = fft(h.*input(1:N));
phi_a = angle(X);      % faza ramki
phi_a_prev = phi_a;    % faza ramki poprzedniej (analiza)
phi_s_prev = phi_a;    % faza ramki poprzedniej (synteza)

for m = 2:length(input)/Ra-4   % m-indeks ramki
    %obliczanie poczatkow ramek
    ts = (m-1)*Rs;
    ta = ts/alpha;
    %obliczanie STFT porcji sygnalu wejsciowego
    X = fft(h.*input(floor(ta+1):floor(ta+N)));
    phi_a = angle(X);
    A = abs(X);
    %roznica faz miedzy kolejnymi ramkami
    deltaPhi = phi_a - phi_a_prev;
    phi_a_prev = phi_a;
    %odwijanie fazy
    deltaPhiUnwrap = mod(deltaPhi - Omega*Ra+pi, 2*pi) - pi;
    omega_a = Omega + deltaPhiUnwrap/Ra;
    
    %obliczanie fazy chwilowej
    phi_s = phi_s_prev + Rs*omega_a;
    phi_s_prev = phi_s;
    
    %STFT fragmentu sygnalu wyjsciowego
    Y = A.*exp(1i*phi_s);
    
    %synteza
    
    output(ts+1:ts+N) = output(ts+1:ts+N)+h.*real(ifft(Y));
   
end

% przywrocenie oryginalnej dlugosci sygnalu poprzez interpolacje
output = interp1((1:length(output)), output, ((1:length(output)/alpha)*alpha));



if mode == "ADD"
    if nargin == 4
        a = gain;
    else
        a = 1;
    end
    for n = 1:length(input)
        output(n) = 1/(1+a)*(a*output(n) + input(n));
    
    end
end



