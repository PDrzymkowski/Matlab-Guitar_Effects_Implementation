[audio1, Fs1] = audioread('czyste-dwa.wav');

%delay
    delay_del = 400;
    gain_del = 0.7;
    version_del = 'FIR';
delayed = delay(audio1, Fs1, delay_del, gain_del, version_del);

%reverb
    predelay1_reverb = 4;
    predelay2_reverb = 10;
    roomSize_reverb = 60;
    depth_reverb = 0.7;
reverbed = reverb(audio1, Fs1, roomSize_reverb, depth_reverb, predelay1_reverb, predelay2_reverb);

%flanger
    delay_flang = 15;
    rate_flang = 0.4;
    gain_flang = 0.5;
    version_flang = 'FIR';
flangered = flanger(audio1, Fs1, delay_flang, rate_flang, gain_flang, version_flang);

%tremolo
    rate_trem = 5;
    depth_trem = 0.3;
    shape_trem = "SIN";
tremolod = tremolo(audio1, Fs1, rate_trem, depth_trem, shape_trem);

%overdrive
    clipValue_overd = 0.05;
overdrived = overdrive(audio1, Fs1, clipValue_overd);

%pitchShifter
    pitch_pitchShift = -12;
    gain = 0.7;
    mode = "";
pitchShifted = pitchShifter(audio1, pitch_pitchShift, mode, gain);

%chorus
    delay_chor = 10;
    rate_1_chor = 0.4;
    depth_1_chor = 0.8;
    rate_2_chor = 0.4;
    depth_2_chor = 0.3;
    version_chor = "FIR";
chorused = chorus(audio1, Fs1, delay_chor, rate_1_chor, depth_1_chor,...
    rate_2_chor, depth_2_chor, version_chor);

% sound(audio1, Fs1);
% sound(delayed, Fs1);
sound(reverbed, Fs1);
% sound(flangered, Fs1);
% sound(tremolod, Fs1);
% sound(overdrived, Fs1);
%  sound(pitchShifted, Fs1);
% sound(chorused, Fs1); 
 
 
 
 %Sygnal zmiksowany
 audio1_mix = audio1;
%     audio1_mix = delay(audio1_mix, Fs1, delay_del, gain_del, version_del); 
%     audio1_mix = reverb(audio1_mix, Fs1, a, D);
%     audio1_mix = flanger(audio1_mix, Fs1, delay_flang, rate_flang, gain_flang, version_flang);
%     audio1_mix = tremolo(audio1_mix, Fs1, rate_trem, depth_trem, shape_trem);
%     audio1_mix = overdrive(audio1_mix, Fs1, clipValue_overd);
%     audio1_mix = pitchShifter(audio1_mix, pitch_pitchShift);
%     sound(audio1_mix, Fs1);