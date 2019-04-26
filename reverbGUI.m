function varargout = reverbGUI(varargin)
% REVERBGUI MATLAB code for reverbGUI.fig
%      REVERBGUI, by itself, creates a new REVERBGUI or raises the existing
%      singleton*.
%
%      H = REVERBGUI returns the handle to a new REVERBGUI or the handle to
%      the existing singleton*.
%
%      REVERBGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REVERBGUI.M with the given input arguments.
%
%      REVERBGUI('Property','Value',...) creates a new REVERBGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before reverbGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to reverbGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help reverbGUI

% Last Modified by GUIDE v2.5 25-Mar-2019 17:13:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @reverbGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @reverbGUI_OutputFcn, ...
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


% --- Executes just before reverbGUI is made visible.
function reverbGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to reverbGUI (see VARARGIN)

% Choose default command line output for reverbGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes reverbGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.reverb_roomSizeSlider, 'Value', evalin('base', 'reverb_roomSize'));
set(handles.reverb_roomSizeEdit, 'String', num2str(evalin('base', 'reverb_roomSize')));
set(handles.reverb_depthSlider, 'Value', evalin('base', 'reverb_depth'));
set(handles.reverb_depthEdit, 'String', num2str(evalin('base', 'reverb_depth')));
set(handles.reverb_preDelay1Slider, 'Value', evalin('base', 'reverb_preDelay1'));
set(handles.reverb_preDelay1Edit, 'String', num2str(evalin('base', 'reverb_preDelay1')));
set(handles.reverb_preDelay2Slider, 'Value', evalin('base', 'reverb_preDelay2'));
set(handles.reverb_preDelay2Edit, 'String', num2str(evalin('base', 'reverb_preDelay2')));

set(handles.reverb_checkbox, 'Value', evalin('base', 'reverb_ON'));


% --- Outputs from this function are returned to the command line.
function varargout = reverbGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function reverb_roomSizeSlider_Callback(hObject, eventdata, handles)
% hObject    handle to reverb_roomSizeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.reverb_roomSizeEdit, 'String', get(hObject,'Value'));
assignin('base', 'reverb_roomSize', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function reverb_roomSizeSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reverb_roomSizeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function reverb_roomSizeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to reverb_roomSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reverb_roomSizeEdit as text
%        str2double(get(hObject,'String')) returns contents of reverb_roomSizeEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.reverb_roomSizeSlider, 'Min'))
    val = get(handles.reverb_roomSizeSlider, 'Min');
    set(handles.reverb_roomSizeSlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.reverb_roomSizeSlider, 'Max'))
    val = get(handles.reverb_roomSizeSlider, 'Max');
    set(handles.reverb_roomSizeSlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.reverb_roomSizeSlider, 'Value', val);
end

guidata(hObject,handles)
assignin('base', 'reverb_roomSize', get(handles.reverb_roomSizeSlider, 'Value'));


% --- Executes during object creation, after setting all properties.
function reverb_roomSizeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reverb_roomSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reverb_checkbox.
function reverb_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to reverb_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of reverb_checkbox
assignin('base', 'reverb_ON', get(hObject, 'Value'));

% --- Executes on slider movement.
function reverb_depthSlider_Callback(hObject, eventdata, handles)
% hObject    handle to reverb_depthSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.reverb_depthEdit, 'String', get(hObject,'Value'));
assignin('base', 'reverb_depth', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function reverb_depthSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reverb_depthSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function reverb_depthEdit_Callback(hObject, eventdata, handles)
% hObject    handle to reverb_depthEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reverb_depthEdit as text
%        str2double(get(hObject,'String')) returns contents of reverb_depthEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.reverb_depthSlider, 'Min'))
    val = get(handles.reverb_depthSlider, 'Min');
    set(handles.reverb_depthSlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.reverb_depthSlider, 'Max'))
    val = get(handles.reverb_depthSlider, 'Max');
    set(handles.reverb_depthSlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.reverb_depthSlider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'reverb_depth', get(handles.reverb_depthSlider, 'Value'));


% --- Executes during object creation, after setting all properties.
function reverb_depthEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reverb_depthEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function reverb_preDelay2Slider_Callback(hObject, eventdata, handles)
% hObject    handle to reverb_preDelay2Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.reverb_preDelay2Edit, 'String', get(hObject,'Value'));
assignin('base', 'reverb_preDelay2', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function reverb_preDelay2Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reverb_preDelay2Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function reverb_preDelay2Edit_Callback(hObject, eventdata, handles)
% hObject    handle to reverb_preDelay2Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reverb_preDelay2Edit as text
%        str2double(get(hObject,'String')) returns contents of reverb_preDelay2Edit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.reverb_preDelay2Slider, 'Min'))
    val = get(handles.reverb_preDelay2Slider, 'Min');
    set(handles.reverb_preDelay2Slider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.reverb_preDelay2Slider, 'Max'))
    val = get(handles.reverb_preDelay2Slider, 'Max');
    set(handles.reverb_preDelay2Slider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.reverb_preDelay2Slider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'reverb_preDelay2', get(handles.reverb_preDelay2Slider, 'Value'));


% --- Executes during object creation, after setting all properties.
function reverb_preDelay2Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reverb_preDelay2Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function reverb_preDelay1Slider_Callback(hObject, eventdata, handles)
% hObject    handle to reverb_preDelay1Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.reverb_preDelay1Edit, 'String', get(hObject,'Value'));
assignin('base', 'reverb_preDelay1', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function reverb_preDelay1Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reverb_preDelay1Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function reverb_preDelay1Edit_Callback(hObject, eventdata, handles)
% hObject    handle to reverb_preDelay1Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reverb_preDelay1Edit as text
%        str2double(get(hObject,'String')) returns contents of reverb_preDelay1Edit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.reverb_preDelay1Slider, 'Min'))
    val = get(handles.reverb_preDelay1Slider, 'Min');
    set(handles.reverb_preDelay1Slider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.reverb_preDelay1Slider, 'Max'))
    val = get(handles.reverb_preDelay1Slider, 'Max');
    set(handles.reverb_preDelay1Slider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.reverb_preDelay1Slider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'reverb_preDelay1', get(handles.reverb_preDelay1Slider, 'Value'));


% --- Executes during object creation, after setting all properties.
function reverb_preDelay1Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reverb_preDelay1Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
