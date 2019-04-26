[audio, fs] = audioread('czyste-dwa.wav');


chorusEffect = audioexample.Chorus;
flangerEffect = audioexample.Flanger;

modulo = floor(size(audio,1)/192000);
display(modulo);
audio_chorused = [];
audio_flangered = [];

if(modulo ~= 0)
    for i = 0:modulo
        if(i==modulo)
          
            chorused = chorusEffect(audio(i*192000+1:size(audio,1))); 
            audio_chorused = [audio_chorused, chorused'];
        else
       
        chorused = chorusEffect(audio(i*192000+1:192000*(i+1)));
        audio_chorused = [audio_chorused, chorused'];
        end
    end
end
        
if(modulo ~= 0)
    for i = 0:modulo
        if(i==modulo)
          
            flangered = flangerEffect(audio(i*192000+1:size(audio,1))); 
            audio_flangered = [audio_flangered, flangered'];
        else
       
        flangered = flangerEffect(audio(i*192000+1:192000*(i+1)));
        audio_flangered = [audio_flangered, flangered'];
        end
    end
end