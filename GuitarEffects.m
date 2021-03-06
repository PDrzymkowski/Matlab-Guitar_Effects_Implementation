
function varargout = GuitarEffects(varargin)
%  GuitarEffects MATLAB code for  GuitarEffects.fig
%      GuitarEffects, by itself, creates a new GuitarEffects or raises the existing
%      singleton*.
%
%      H =  GuitarEffects returns the handle to a new GuitarEffects or the handle to
%      the existing singleton*.
%
%      GuitarEffects('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GuitarEffects.M with the given input arguments.
%
%      GuitarEffects('Property','Value',...) creates a new GuitarEffects or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GuitarEffects_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GuitarEffects_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GuitarEffects

% Last Modified by GUIDE v2.5 06-Jun-2019 11:05:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GuitarEffects_OpeningFcn, ...
                   'gui_OutputFcn',  @GuitarEffects_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


function setFile(imported)
global file;
file = imported;

function file_x = getFile
global file;
file_x = file;

function setProcessedFile(processed)
global procFile;
procFile = processed;

function procFile_x = getProcessedFile
global procFile;
procFile_x = procFile;


function showError(statement)
    error = errordlg(statement,'Error');
    set(error, 'WindowStyle', 'modal');
    uiwait(error);


% --- Executes just before GuitarEffects is made visible.
function GuitarEffects_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GuitarEffects (see VARARGIN)
clc;
clear global;
% Choose default command line output for GuitarEffects
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
assignin('base', 'delay_ON', 0);
    assignin('base', 'delay_delay', 0.5);
    assignin('base', 'delay_gain', 0.5);
    assignin('base', 'delay_version', 'FIR');
assignin('base', 'reverb_ON', 0);
    assignin('base', 'reverb_roomSize', 50.0);
    assignin('base', 'reverb_depth1', 0.5);
    assignin('base', 'reverb_depth2', 0.7);
    assignin('base', 'reverb_preDelay1', 5.0);
    assignin('base', 'reverb_preDelay2', 5.0);
assignin('base', 'chorus_ON', 0);
    assignin('base', 'chorus_delay', 5.0);
    assignin('base', 'chorus_rate1', 0.2);
    assignin('base', 'chorus_depth1', 0.5);
    assignin('base', 'chorus_rate2', 0.2);
    assignin('base', 'chorus_depth2', 0.5);
    assignin('base', 'chorus_version', 'FIR');
assignin('base', 'flanger_ON', 0);
    assignin('base', 'flanger_delay', 1.0);
    assignin('base', 'flanger_rate', 0.5);
    assignin('base', 'flanger_gain', 0.5);
    assignin('base', 'flanger_version', 'FIR');
assignin('base', 'overdrive_ON', 0);
    assignin('base', 'overdrive_clipValue', 0.5);
assignin('base', 'tremolo_ON', 0);
    assignin('base', 'tremolo_rate', 5);
    assignin('base', 'tremolo_depth', 0.5);
    assignin('base', 'tremolo_mode', 'SIN');
    
cla(handles.Waveform);
cla(handles.Spectrum);

guidata(hObject, handles);
% UIWAIT makes GuitarEffects wait for user response (see UIRESUME)
% uiwait(handles.window);


% --- Outputs from this function are returned to the command line.
function varargout = GuitarEffects_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadFileButton.
function loadFileButton_Callback(hObject, ~, handles)
% hObject    handle to loadFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

originalFile = uiimport('-file');

if(~isempty(originalFile))
    setFile(originalFile);
 
    axes(handles.Waveform);
    plot((0:length(originalFile.data(:,1))-1)/originalFile.fs,...
        originalFile.data(:,1)); grid;
    xlabel('Czas trwania [s]');
    ylabel('Amplituda');
    
    axes(handles.Spectrum);
    spect_win = chebwin(4096);
    spectrogram(originalFile.data(:,1), spect_win, length(spect_win)/2,... 
                length(spect_win), originalFile.fs, 'yaxis');
    xlabel('Czas trwania [s]');
    ylabel('Cz�stotliwo�� [kHz]');
    ylim([0,10]);
else
    showError('Nie wybrano �adnego pliku!');
end
   

% --- Executes on button press in playOriginalButton.
function playOriginalButton_Callback(hObject, eventdata, handles)
% hObject    handle to playOriginalButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
originalFile = getFile();

if(~isempty(originalFile))
sound(originalFile.data, originalFile.fs);
else
    showError('Nie wybrano �adnego pliku!');
end


% --- Executes on button press in WFOriginalButton.
function WFOriginalButton_Callback(hObject, eventdata, ~)
% hObject    handle to WFOriginalButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
originalFile = getFile();

if(~isempty(originalFile))
    figure();
    plot((0:length(originalFile.data(:,1))-1)/originalFile.fs,...
        originalFile.data(:,1)); grid;
    title('Przebieg sygna�u oryginalnego');
    xlabel('Czas trwania[s]');
    ylabel('Amplituda[dB]');
else
    showError('Nie wybrano �adnego pliku!');
end


% --- Executes on button press in SpectrumOriginalButton.
function SpectrumOriginalButton_Callback(hObject, eventdata, handles)
% hObject    handle to SpectrumOriginalButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
originalFile = getFile();

if(~isempty(originalFile))
    figure();
    spect_win =  chebwin(4096);
    spectrogram(originalFile.data(:,1), spect_win, length(spect_win)/2,... 
             length(spect_win), originalFile.fs, 'yaxis');
    title('Widmo sygna�u oryginalnego');
    xlabel('Czas trwania [s]');
    ylabel('Cz�stotliwo�� [kHz]');
    ylim([0,10]);
else
    showError('Nie wybrano �adnego pliku!');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in playProcessedButton.
function playProcessedButton_Callback(hObject, eventdata, handles)
% hObject    handle to playProcessedButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
processedFile = getProcessedFile();

if(~isempty(processedFile))
    sound(processedFile.data, processedFile.fs);
else
    showError('Nie przetworzono �adnego pliku!');
end

% --- Executes on button press in WFProcessedButton.
function WFProcessedButton_Callback(hObject, eventdata, handles)
% hObject    handle to WFProcessedButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
processedFile = getProcessedFile();

if(~isempty(processedFile))
    figure();
    plot((0:length(processedFile.data(:,1))-1)/processedFile.fs,...
        processedFile.data(:,1)); grid;
    title('Przebieg sygna�u przetworzonego efektami');
    xlabel('Czas trwania[s]');
    ylabel('Amplituda[dB]');
else
    showError('Nie przetworzono �adnego pliku!');
end

% --- Executes on button press in spectrumProcessedButton.
function spectrumProcessedButton_Callback(hObject, eventdata, handles)
% hObject    handle to spectrumProcessedButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
processedFile = getProcessedFile();

if(~isempty(processedFile))
    figure();
    spect_win = chebwin(4096);
    spectrogram(processedFile.data(:,1), spect_win, length(spect_win)/2,... 
                length(spect_win), processedFile.fs, 'yaxis');
    title('Widmo sygna�u przetworzonego efektami');
    xlabel('Czas trwania [s]');
    ylabel('Cz�stotliwo�� [kHz]');
    ylim([0,10]);
else
    showError('Nie przetworzono �adnego pliku!');
end


% --- Executes on button press in delayButton.
function delayButton_Callback(hObject, eventdata, handles)
% hObject    handle to delayButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

originalFile = getFile();

if(~isempty(originalFile))
delayGUI;
else
    showError('Nie wybrano �adnego pliku!');
end

% --- Executes on button press in reverbButton.
function reverbButton_Callback(hObject, eventdata, handles)
% hObject    handle to reverbButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
originalFile = getFile();

if(~isempty(originalFile))
reverbGUI;
else
    showError('Nie wybrano �adnego pliku!');
end


% --- Executes on button press in chorusButton.
function chorusButton_Callback(hObject, eventdata, handles)
% hObject    handle to chorusButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
originalFile = getFile();

if(~isempty(originalFile))
chorusGUI;
else
    showError('Nie wybrano �adnego pliku!');
end

% --- Executes on button press in flangerButton.
function flangerButton_Callback(hObject, eventdata, handles)
% hObject    handle to flangerButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
originalFile = getFile();

if(~isempty(originalFile))
flangerGUI;
else
    showError('Nie wybrano �adnego pliku!');
end


% --- Executes on button press in tremoloButton.
function tremoloButton_Callback(hObject, eventdata, handles)
% hObject    handle to tremoloButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
originalFile = getFile();

if(~isempty(originalFile))
tremoloGUI;
else
    showError('Nie wybrano �adnego pliku!');
end


% --- Executes on button press in overdriveButton.
function overdriveButton_Callback(hObject, eventdata, handles)
% hObject    handle to overdriveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
originalFile = getFile();

if(~isempty(originalFile))
overdriveGUI;
else
    showError('Nie wybrano �adnego pliku!');
end




% --- Executes on button press in myEffectsApplyButton.
function myEffectsApplyButton_Callback(~, eventdata, handles)
% hObject    handle to myEffectsApplyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
processedFile = getFile();

if(~isempty(processedFile))
    numbOfEffects = 0;
     if(evalin('base', 'overdrive_ON')==1)
         overdrive_clipVal = evalin('base', 'overdrive_clipValue');
         processedFile.data = overdrive(processedFile.data, overdrive_clipVal);
         numbOfEffects = numbOfEffects + 1;
     end
     if(evalin('base', 'chorus_ON')==1)
         chorus_delay = evalin('base', 'chorus_delay');
         chorus_rate1 = evalin('base', 'chorus_rate1');
         chorus_depth1 = evalin('base', 'chorus_depth1');
         chorus_rate2 = evalin('base', 'chorus_rate2');
         chorus_depth2 = evalin('base', 'chorus_depth2');
         chorus_version = evalin('base', 'chorus_version');
         processedFile.data = chorus(processedFile.data, processedFile.fs,...
             chorus_delay, chorus_rate1, chorus_depth1, chorus_rate2,...
             chorus_depth2, chorus_version);
         numbOfEffects = numbOfEffects + 1;
     end
     if(evalin('base', 'flanger_ON')==1)
         flanger_delay = evalin('base', 'flanger_delay');
         flanger_rate = evalin('base', 'flanger_rate');
         flanger_gain = evalin('base', 'flanger_gain');
         flanger_version = evalin('base', 'flanger_version');
         processedFile.data = flanger(processedFile.data, processedFile.fs,...
             flanger_delay, flanger_rate, flanger_gain, flanger_version);
         numbOfEffects = numbOfEffects + 1;
     end
     if(evalin('base', 'tremolo_ON')==1)
         tremolo_rate = evalin('base', 'tremolo_rate');
         tremolo_depth = evalin('base', 'tremolo_depth');
         tremolo_mode= evalin('base', 'tremolo_mode');
         processedFile.data = tremolo(processedFile.data, processedFile.fs,...
             tremolo_rate, tremolo_depth, tremolo_mode);
         numbOfEffects = numbOfEffects + 1;
     end
     if(evalin('base', 'delay_ON')==1)
         
         delay_delay = evalin('base', 'delay_delay')*1000;
         delay_gain = evalin('base', 'delay_gain');
         delay_version = evalin('base', 'delay_version');
         processedFile.data = delay(processedFile.data, processedFile.fs,...
              delay_delay, delay_gain, delay_version);
         numbOfEffects = numbOfEffects + 1;
     end
     if(evalin('base', 'reverb_ON')==1)
         reverb_roomSize = evalin('base', 'reverb_roomSize');
         reverb_depth1 = evalin('base', 'reverb_depth1');
         reverb_depth2 = evalin('base', 'reverb_depth2');
         reverb_preDelay1 = evalin('base', 'reverb_preDelay1');
         reverb_preDelay2 = evalin('base', ' reverb_preDelay2');
         processedFile.data = reverb(processedFile.data, processedFile.fs,...
              reverb_roomSize, reverb_depth1, reverb_depth2, ...
              reverb_preDelay1, reverb_preDelay2);
         numbOfEffects = numbOfEffects + 1;
     end
     
     if(numbOfEffects == 0)
         showError('Nie wybrano �adnego efektu!');
     else
         setProcessedFile(processedFile)
         
         axes(handles.Waveform);
         plot((0:length(processedFile.data(:,1))-1)/processedFile.fs,...
         processedFile.data(:,1)); grid;
         xlabel('czas trwania[s]');
         ylabel('Amplituda[dB]');
         axes(handles.Spectrum);
         
         spect_win = chebwin(4096);
         spectrogram(processedFile.data(:,1), spect_win, length(spect_win)/2,... 
                     length(spect_win), processedFile.fs, 'yaxis');
         xlabel('Czas trwania [s]');
         ylabel('Cz�stotliwo�� [kHz]');
         ylim([0,10]);  
     end
else
    showError('Nie wybrano �adnego pliku!');
end
