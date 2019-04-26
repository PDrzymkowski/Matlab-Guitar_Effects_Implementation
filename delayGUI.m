function varargout = delayGUI(varargin)
% DELAYGUI MATLAB code for delayGUI.fig
%      DELAYGUI, by itself, creates a new DELAYGUI or raises the existing
%      singleton*.
%
%      H = DELAYGUI returns the handle to a new DELAYGUI or the handle to
%      the existing singleton*.
%
%      DELAYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DELAYGUI.M with the given input arguments.
%
%      DELAYGUI('Property','Value',...) creates a new DELAYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before delayGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to delayGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help delayGUI

% Last Modified by GUIDE v2.5 22-Mar-2019 19:16:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @delayGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @delayGUI_OutputFcn, ...
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


% --- Executes just before delayGUI is made visible.
function delayGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to delayGUI (see VARARGIN)
clc;
% Choose default command line output for delayGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%set(handles.delay_delaySlider, 'Value', str2double(get(handles.delay_delayEdit, 'Value'))); 
% UIWAIT makes delayGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.delay_delaySlider, 'Value', evalin('base', 'delay_delay'));
set(handles.delay_delayEdit, 'String', num2str(evalin('base', 'delay_delay')));
set(handles.delay_gainSlider, 'Value', evalin('base', 'delay_gain'));
set(handles.delay_gainEdit, 'String', num2str(evalin('base', 'delay_gain')));

if(evalin('base', 'delay_version') == 'FIR')
    set(handles.delay_FIRRadio, 'Value', 1);
    set(handles.delay_IIRRadio, 'Value', 0);
else
    set(handles.delay_IIRRadio, 'Value', 1);
    set(handles.delay_FIRRadio, 'Value', 0);
end

set(handles.delay_checkbox, 'Value', evalin('base', 'delay_ON'));

% --- Outputs from this function are returned to the command line.
function varargout = delayGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function delay_delaySlider_Callback(hObject, eventdata, handles)
% hObject    handle to delay_delaySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.delay_delayEdit,'String',get(hObject,'Value'));
assignin('base', 'delay_delay', get(hObject,'Value'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function delay_delaySlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delay_delaySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




function delay_delayEdit_Callback(hObject, eventdata, handles)
% hObject    handle to delay_delayEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delay_delayEdit as text
%        str2double(get(hObject,'String')) returns contents of delay_delayEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.delay_delaySlider, 'Min'))
    val = get(handles.delay_delaySlider, 'Min');
    set(handles.delay_delaySlider, 'Value', val);
    set(hObject, 'String', val); 
    guidata(hObject,handles)
elseif(val > get(handles.delay_delaySlider, 'Max'))
    val = get(handles.delay_delaySlider, 'Max');
    set(handles.delay_delaySlider, 'Value', val);
    set(hObject, 'String', val); 
    guidata(hObject,handles)
else
    set(handles.delay_delaySlider,'Value', val);
    guidata(hObject,handles)
end

assignin('base', 'delay_delay', get(handles.delay_delaySlider, 'Value'));

% --- Executes during object creation, after setting all properties.
function delay_delayEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delay_delayEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function delay_gainEdit_Callback(hObject, eventdata, handles)
% hObject    handle to delay_gainEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delay_gainEdit as text
%        str2double(get(hObject,'String')) returns contents of delay_gainEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.delay_gainSlider, 'Min'))
    val = get(handles.delay_gainSlider, 'Min');
    set(handles.delay_gainSlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.delay_gainSlider, 'Max'))
    val = get(handles.delay_gainSlider, 'Max');
    set(handles.delay_gainSlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.delay_gainSlider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'delay_gain', get(handles.delay_gainSlider, 'Value'));

% --- Executes during object creation, after setting all properties.
function delay_gainEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delay_gainEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in delay_FIRRadio.
function delay_FIRRadio_Callback(hObject, eventdata, handles)
% hObject    handle to delay_FIRRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of delay_FIRRadio
assignin('base', 'delay_version', 'FIR');
guidata(hObject,handles)

% --- Executes on button press in delay_IIRRadio.
function delay_IIRRadio_Callback(hObject, eventdata, handles)
% hObject    handle to delay_IIRRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of delay_IIRRadio
assignin('base', 'delay_version', 'IIR');
guidata(hObject,handles)

% --- Executes on slider movement.
function delay_gainSlider_Callback(hObject, eventdata, handles)
% hObject    handle to delay_gainSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.delay_gainEdit, 'String', get(hObject,'Value'));
assignin('base', 'delay_gain', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function delay_gainSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delay_gainSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in delay_checkbox.
function delay_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to delay_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of delay_checkbox
assignin('base', 'delay_ON', get(hObject, 'Value'));
