function varargout = ATReverbatorGUI(varargin)
% ATREVERBATORGUI MATLAB code for ATReverbatorGUI.fig
%      ATREVERBATORGUI, by itself, creates a new ATREVERBATORGUI or raises the existing
%      singleton*.
%
%      H = ATREVERBATORGUI returns the handle to a new ATREVERBATORGUI or the handle to
%      the existing singleton*.
%
%      ATREVERBATORGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ATREVERBATORGUI.M with the given input arguments.
%
%      ATREVERBATORGUI('Property','Value',...) creates a new ATREVERBATORGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ATReverbatorGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ATReverbatorGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ATReverbatorGUI

% Last Modified by GUIDE v2.5 12-May-2019 16:06:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ATReverbatorGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ATReverbatorGUI_OutputFcn, ...
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


% --- Executes just before ATReverbatorGUI is made visible.
function ATReverbatorGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ATReverbatorGUI (see VARARGIN)

handles.PreDelay = 0.5;
handles.Diffusion = 0.5;
handles.DecayFactor = 0.5;
handles.WetDryMix = 0.5;

handles.audioData = varargin;
assignin('base', 'dada', handles.audioData);
% Choose default command line output for ATReverbatorGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ATReverbatorGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ATReverbatorGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function PreDelaySlider_Callback(hObject, eventdata, handles)
% hObject    handle to PreDelaySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.PreDelayEdit,'String',get(hObject,'Value'));
handles.PreDelay = get(hObject, 'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function PreDelaySlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PreDelaySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function PreDelayEdit_Callback(hObject, eventdata, handles)
% hObject    handle to PreDelayEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PreDelayEdit as text
%        str2double(get(hObject,'String')) returns contents of PreDelayEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.PreDelaySlider, 'Min'))
    val = get(handles.PreDelaySlider, 'Min');
    set(handles.PreDelaySlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.PreDelaySlider, 'Max'))
    val = get(handles.PreDelaySlider, 'Max');
    set(handles.PreDelaySlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.PreDelaySlider,'Value', val);   
end

handles.PreDelay = val;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function PreDelayEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PreDelayEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function DiffusionSlider_Callback(hObject, eventdata, handles)
% hObject    handle to DiffusionSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.DiffusionEdit,'String',get(hObject,'Value'));
handles.Diffusion = get(hObject, 'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function DiffusionSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DiffusionSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function DiffusionEdit_Callback(hObject, eventdata, handles)
% hObject    handle to DiffusionEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DiffusionEdit as text
%        str2double(get(hObject,'String')) returns contents of DiffusionEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.DiffusionSlider, 'Min'))
    val = get(handles.DiffusionSlider, 'Min');
    set(handles.DiffusionSlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.DiffusionSlider, 'Max'))
    val = get(handles.DiffusionSlider, 'Max');
    set(handles.DiffusionSlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.DiffusionSlider,'Value', val);   
end

handles.Diffusion = val;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function DiffusionEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DiffusionEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function WetDryMixSlider_Callback(hObject, eventdata, handles)
% hObject    handle to WetDryMixSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.WetDryMixEdit,'String',get(hObject,'Value'));
handles.WetDryMix = get(hObject, 'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function WetDryMixSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WetDryMixSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function WetDryMixEdit_Callback(hObject, eventdata, handles)
% hObject    handle to WetDryMixEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WetDryMixEdit as text
%        str2double(get(hObject,'String')) returns contents of WetDryMixEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.WetDryMixSlider, 'Min'))
    val = get(handles.WetDryMixSlider, 'Min');
    set(handles.WetDryMixSlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.WetDryMixSlider, 'Max'))
    val = get(handles.WetDryMixSlider, 'Max');
    set(handles.WetDryMixSlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.WetDryMixSlider,'Value', val);   
end

handles.WetDryMix = val;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function WetDryMixEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WetDryMixEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function DecayFactorSlider_Callback(hObject, eventdata, handles)
% hObject    handle to DecayFactorSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.DecayFactorEdit,'String',get(hObject,'Value'));
handles.DecayFactor = get(hObject, 'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function DecayFactorSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DecayFactorSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function DecayFactorEdit_Callback(hObject, eventdata, handles)
% hObject    handle to DecayFactorEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DecayFactorEdit as text
%        str2double(get(hObject,'String')) returns contents of DecayFactorEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.DecayFactorSlider, 'Min'))
    val = get(handles.DecayFactorSlider, 'Min');
    set(handles.DecayFactorSlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.DecayFactorSlider, 'Max'))
    val = get(handles.DecayFactorSlider, 'Max');
    set(handles.DecayFactorSlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.DecayFactorSlider,'Value', val);   
end

handles.DecayFactor = val;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function DecayFactorEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DecayFactorEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ApplyButton.
function ApplyButton_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Reverberator = reverberator(...
                            'PreDelay', handles.PreDelay,...
                            'Diffusion', handles.Diffusion,...
                            'DecayFactor', handles.DecayFactor,...
                            'WetDryMix', handles.WetDryMix,...
                            'SampleRate', handles.audioData{1}.fs);
ProcessedReverbedFile = Reverberator(handles.audioData{1}.data);
audiowrite('output.wav', ProcessedReverbedFile, handles.audioData{1}.fs);
