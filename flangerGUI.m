function varargout = flangerGUI(varargin)
% FLANGERGUI MATLAB code for flangerGUI.fig
%      FLANGERGUI, by itself, creates a new FLANGERGUI or raises the existing
%      singleton*.
%
%      H = FLANGERGUI returns the handle to a new FLANGERGUI or the handle to
%      the existing singleton*.
%
%      FLANGERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLANGERGUI.M with the given input arguments.
%
%      FLANGERGUI('Property','Value',...) creates a new FLANGERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before flangerGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to flangerGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help flangerGUI

% Last Modified by GUIDE v2.5 24-Mar-2019 16:55:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @flangerGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @flangerGUI_OutputFcn, ...
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


% --- Executes just before flangerGUI is made visible.
function flangerGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to flangerGUI (see VARARGIN)

% Choose default command line output for flangerGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes flangerGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.flanger_delaySlider, 'Value', evalin('base', 'flanger_delay'));
set(handles.flanger_delayEdit, 'String', num2str(evalin('base', 'flanger_delay')));
set(handles.flanger_rateSlider, 'Value', evalin('base', 'flanger_rate'));
set(handles.flanger_rateEdit, 'String', num2str(evalin('base', 'flanger_rate')));
set(handles.flanger_gainSlider, 'Value', evalin('base', 'flanger_gain'));
set(handles.flanger_gainEdit, 'String', num2str(evalin('base', 'flanger_gain')));

if(evalin('base', 'flanger_version') == 'FIR')
    set(handles.flanger_FIRRadio, 'Value', 1);
    set(handles.flanger_IIRRadio, 'Value', 0);
else
    set(handles.flanger_IIRRadio, 'Value', 1);
    set(handles.flanger_FIRRadio, 'Value', 0);
end

set(handles.flanger_checkbox, 'Value', evalin('base', 'flanger_ON'));

% --- Outputs from this function are returned to the command line.
function varargout = flangerGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function flanger_delaySlider_Callback(hObject, eventdata, handles)
% hObject    handle to flanger_delaySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.flanger_delayEdit,'String',get(hObject,'Value'));
assignin('base', 'flanger_delay', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function flanger_delaySlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flanger_delaySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function flanger_delayEdit_Callback(hObject, eventdata, handles)
% hObject    handle to flanger_delayEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of flanger_delayEdit as text
%        str2double(get(hObject,'String')) returns contents of flanger_delayEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.flanger_delaySlider, 'Min'))
    val = get(handles.flanger_delaySlider, 'Min');
    set(handles.flanger_delaySlider, 'Value', val);
    set(hObject, 'String', val); 
    guidata(hObject,handles)
elseif(val > get(handles.flanger_delaySlider, 'Max'))
    val = get(handles.flanger_delaySlider, 'Max');
    set(handles.flanger_delaySlider, 'Value', val);
    set(hObject, 'String', val); 
    guidata(hObject,handles)
else
    set(handles.flanger_delaySlider,'Value', val);
    guidata(hObject,handles)
end

assignin('base', 'flanger_delay', get(handles.flanger_delaySlider, 'Value'));


% --- Executes during object creation, after setting all properties.
function flanger_delayEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flanger_delayEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function flanger_gainEdit_Callback(hObject, eventdata, handles)
% hObject    handle to flanger_gainEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of flanger_gainEdit as text
%        str2double(get(hObject,'String')) returns contents of flanger_gainEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.flanger_gainSlider, 'Min'))
    val = get(handles.flanger_gainSlider, 'Min');
    set(handles.flanger_gainSlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.flanger_gainSlider, 'Max'))
    val = get(handles.flanger_gainSlider, 'Max');
    set(handles.flanger_gainSlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.flanger_gainSlider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'flanger_gain', get(handles.flanger_gainSlider, 'Value'));


% --- Executes during object creation, after setting all properties.
function flanger_gainEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flanger_gainEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function flanger_gainSlider_Callback(hObject, eventdata, handles)
% hObject    handle to flanger_gainSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.flanger_gainEdit, 'String', get(hObject,'Value'));
assignin('base', 'flanger_gain', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function flanger_gainSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flanger_gainSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in flanger_checkbox.
function flanger_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to flanger_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flanger_checkbox
assignin('base', 'flanger_ON', get(hObject, 'Value'));

% --- Executes on slider movement.
function flanger_rateSlider_Callback(hObject, eventdata, handles)
% hObject    handle to flanger_rateSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.flanger_rateEdit, 'String', get(hObject,'Value'));
assignin('base', 'flanger_rate', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function flanger_rateSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flanger_rateSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function flanger_rateEdit_Callback(hObject, eventdata, handles)
% hObject    handle to flanger_rateEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of flanger_rateEdit as text
%        str2double(get(hObject,'String')) returns contents of flanger_rateEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.flanger_rateSlider, 'Min'))
    val = get(handles.flanger_rateSlider, 'Min');
    set(handles.flanger_rateSlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.flanger_rateSlider, 'Max'))
    val = get(handles.flanger_rateSlider, 'Max');
    set(handles.flanger_rateSlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.flanger_rateSlider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'flanger_rate', get(handles.flanger_rateSlider, 'Value'));


% --- Executes during object creation, after setting all properties.
function flanger_rateEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flanger_rateEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in flanger_FIRRadio.
function flanger_FIRRadio_Callback(hObject, eventdata, handles)
% hObject    handle to flanger_FIRRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flanger_FIRRadio
assignin('base', 'flanger_version', 'FIR');
guidata(hObject,handles)

% --- Executes on button press in flanger_IIRRadio.
function flanger_IIRRadio_Callback(hObject, eventdata, handles)
% hObject    handle to flanger_IIRRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flanger_IIRRadio
assignin('base', 'flanger_version', 'IIR');
guidata(hObject,handles)
