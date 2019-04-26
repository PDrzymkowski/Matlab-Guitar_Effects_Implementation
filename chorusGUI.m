function varargout = chorusGUI(varargin)
%CHORUSGUI MATLAB code file for chorusGUI.fig
%      CHORUSGUI, by itself, creates a new CHORUSGUI or raises the existing
%      singleton*.
%
%      H = CHORUSGUI returns the handle to a new CHORUSGUI or the handle to
%      the existing singleton*.
%
%      CHORUSGUI('Property','Value',...) creates a new CHORUSGUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to chorusGUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      CHORUSGUI('CALLBACK') and CHORUSGUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CHORUSGUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help chorusGUI

% Last Modified by GUIDE v2.5 25-Mar-2019 16:44:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @chorusGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @chorusGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before chorusGUI is made visible.
function chorusGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for chorusGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes chorusGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.chorus_delaySlider, 'Value', evalin('base', 'chorus_delay'));
set(handles.chorus_delayEdit, 'String', num2str(evalin('base', 'chorus_delay')));
set(handles.chorus_rate1Slider, 'Value', evalin('base', 'chorus_rate1'));
set(handles.chorus_rate1Edit, 'String', num2str(evalin('base', 'chorus_rate1')));
set(handles.chorus_depth1Slider, 'Value', evalin('base', 'chorus_depth1'));
set(handles.chorus_depth1Edit, 'String', num2str(evalin('base', 'chorus_depth1')));
set(handles.chorus_rate2Slider, 'Value', evalin('base', 'chorus_rate2'));
set(handles.chorus_rate2Edit, 'String', num2str(evalin('base', 'chorus_rate2')));
set(handles.chorus_depth2Slider, 'Value', evalin('base', 'chorus_depth2'));
set(handles.chorus_depth2Edit, 'String', num2str(evalin('base', 'chorus_depth2')));

if(evalin('base', 'chorus_version') == 'FIR')
    set(handles.chorus_FIRRadio, 'Value', 1);
    set(handles.chorus_IIRRadio, 'Value', 0);
else
    set(handles.chorus_IIRRadio, 'Value', 1);
    set(handles.chorus_FIRRadio, 'Value', 0);
end

set(handles.chorus_checkbox, 'Value', evalin('base', 'chorus_ON'));


% --- Outputs from this function are returned to the command line.
function varargout = chorusGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on slider movement.
function chorus_delaySlider_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_delaySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.chorus_delayEdit, 'String', get(hObject,'Value'));
assignin('base', 'chorus_delay', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function chorus_delaySlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chorus_delaySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function chorus_delayEdit_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_delayEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chorus_delayEdit as text
%        str2double(get(hObject,'String')) returns contents of chorus_delayEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.chorus_delaySlider, 'Min'))
    val = get(handles.chorus_delaySlider, 'Min');
    set(handles.chorus_delaySlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.chorus_delaySlider, 'Max'))
    val = get(handles.chorus_delaySlider, 'Max');
    set(handles.chorus_delaySlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.chorus_delaySlider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'chorus_delay', get(handles.chorus_delaySlider, 'Value'));


% --- Executes during object creation, after setting all properties.
function chorus_delayEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chorus_delayEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function chorus_depth2Edit_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_depth2Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chorus_depth2Edit as text
%        str2double(get(hObject,'String')) returns contents of chorus_depth2Edit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.chorus_depth2Slider, 'Min'))
    val = get(handles.chorus_depth2Slider, 'Min');
    set(handles.chorus_depth2Slider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.chorus_depth2Slider, 'Max'))
    val = get(handles.chorus_depth2Slider, 'Max');
    set(handles.chorus_depth2Slider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.chorus_depth2Slider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'chorus_depth1', get(handles.chorus_depth1Slider, 'Value'));


% --- Executes during object creation, after setting all properties.
function chorus_depth2Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chorus_depth2Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function chorus_depth2Slider_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_depth2Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.chorus_depth2Edit, 'String', get(hObject,'Value'));
assignin('base', 'chorus_depth2', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function chorus_depth2Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chorus_depth2Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in chorus_checkbox.
function chorus_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chorus_checkbox
assignin('base', 'chorus_ON', get(hObject, 'Value'));

% --- Executes on slider movement.
function chorus_rate1Slider_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_rate1Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.chorus_rate1Edit, 'String', get(hObject,'Value'));
assignin('base', 'chorus_rate1', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function chorus_rate1Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chorus_rate1Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function chorus_rate1Edit_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_rate1Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chorus_rate1Edit as text
%        str2double(get(hObject,'String')) returns contents of chorus_rate1Edit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.chorus_rate1Slider, 'Min'))
    val = get(handles.chorus_rate1Slider, 'Min');
    set(handles.chorus_rate1Slider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.chorus_rate1Slider, 'Max'))
    val = get(handles.chorus_rate1Slider, 'Max');
    set(handles.chorus_rate1Slider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.chorus_rate1Slider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'chorus_rate1', get(handles.chorus_rate1Slider, 'Value'));



% --- Executes during object creation, after setting all properties.
function chorus_rate1Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chorus_rate1Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function chorus_rate2Slider_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_rate2Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.chorus_rate2Edit, 'String', get(hObject,'Value'));
assignin('base', 'chorus_rate2', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function chorus_rate2Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chorus_rate2Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function chorus_rate2Edit_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_rate2Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chorus_rate2Edit as text
%        str2double(get(hObject,'String')) returns contents of chorus_rate2Edit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.chorus_rate2Slider, 'Min'))
    val = get(handles.chorus_rate2Slider, 'Min');
    set(handles.chorus_rate2Slider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.chorus_rate2Slider, 'Max'))
    val = get(handles.chorus_rate2Slider, 'Max');
    set(handles.chorus_rate2Slider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.chorus_rate2Slider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'chorus_rate2', get(handles.chorus_rate2Slider, 'Value'));


% --- Executes during object creation, after setting all properties.
function chorus_rate2Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chorus_rate2Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function chorus_depth1Slider_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_depth1Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.chorus_depth1Edit, 'String', get(hObject,'Value'));
assignin('base', 'chorus_depth1', get(hObject,'Value'));
guidata(hObject,handles)



% --- Executes during object creation, after setting all properties.
function chorus_depth1Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chorus_depth1Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function chorus_depth1Edit_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_depth1Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chorus_depth1Edit as text
%        str2double(get(hObject,'String')) returns contents of chorus_depth1Edit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.chorus_depth1Slider, 'Min'))
    val = get(handles.chorus_depth1Slider, 'Min');
    set(handles.chorus_depth1Slider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.chorus_depth1Slider, 'Max'))
    val = get(handles.chorus_depth1Slider, 'Max');
    set(handles.chorus_depth1Slider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.chorus_depth1Slider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'chorus_depth1', get(handles.chorus_depth1Slider, 'Value'));


% --- Executes during object creation, after setting all properties.
function chorus_depth1Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chorus_depth1Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chorus_FIRRadio.
function chorus_FIRRadio_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_FIRRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chorus_FIRRadio
assignin('base', 'chorus_version', 'FIR');

% --- Executes on button press in chorus_IIRRadio.
function chorus_IIRRadio_Callback(hObject, eventdata, handles)
% hObject    handle to chorus_IIRRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chorus_IIRRadio
assignin('base', 'chorus_version', 'IIR');
