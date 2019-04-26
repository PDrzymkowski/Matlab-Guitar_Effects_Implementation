function varargout = pitchShifterGUI(varargin)
% PITCHSHIFTERGUI MATLAB code for pitchShifterGUI.fig
%      PITCHSHIFTERGUI, by itself, creates a new PITCHSHIFTERGUI or raises the existing
%      singleton*.
%
%      H = PITCHSHIFTERGUI returns the handle to a new PITCHSHIFTERGUI or the handle to
%      the existing singleton*.
%
%      PITCHSHIFTERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PITCHSHIFTERGUI.M with the given input arguments.
%
%      PITCHSHIFTERGUI('Property','Value',...) creates a new PITCHSHIFTERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pitchShifterGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pitchShifterGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pitchShifterGUI

% Last Modified by GUIDE v2.5 24-Mar-2019 17:49:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pitchShifterGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @pitchShifterGUI_OutputFcn, ...
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


% --- Executes just before pitchShifterGUI is made visible.
function pitchShifterGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pitchShifterGUI (see VARARGIN)

% Choose default command line output for pitchShifterGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pitchShifterGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.pitchShifter_pitchText, 'String', evalin('base', 'pitchShifter_pitch'));

if(evalin('base', 'pitchShifter_mode') == 'ADD')
    set(handles.pitchShifter_ADDRadio, 'Value', 1);
    set(handles.pitchShifter_REPLACERadio, 'Value', 0);
    set(handles.pitchShifter_gainPanel, 'Visible', 1);
else
    set(handles.pitchShifter_ADDRadio, 'Value', 0);
    set(handles.pitchShifter_ADDRadio, 'Value', 1);
    set(handles.pitchShifter_gainPanel, 'Visible', 0);
end

set(handles.pitchShifter_gainSlider, 'Value', evalin('base', 'pitchShifter_gain'));
set(handles.pitchShifter_gainEdit, 'String', num2str(evalin('base', 'pitchShifter_gain')));
set(handles.pitchShifter_checkbox, 'Value', evalin('base', 'pitchShifter_ON'));


% --- Outputs from this function are returned to the command line.
function varargout = pitchShifterGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pitchShifter_checkbox.
function pitchShifter_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to pitchShifter_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pitchShifter_checkbox
assignin('base', 'pitchShifter_ON', get(hObject, 'Value'));

% --- Executes on button press in pitchShifter_plusButton.
function pitchShifter_plusButton_Callback(hObject, eventdata, handles)
% hObject    handle to pitchShifter_plusButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2num(get(handles.pitchShifter_pitchText, 'String'));

if(val < 12)
    val = val + 1;
    set(handles.pitchShifter_pitchText, 'String', num2str(val));
    assignin('base', 'pitchShifter_pitch', val);
end

% --- Executes on button press in pitchShifter_minusButton.
function pitchShifter_minusButton_Callback(hObject, eventdata, handles)
% hObject    handle to pitchShifter_minusButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2num(get(handles.pitchShifter_pitchText, 'String'));

if(val > -12)
    val = val - 1;
    set(handles.pitchShifter_pitchText, 'String', num2str(val));
    assignin('base', 'pitchShifter_pitch', val);
end


% --- Executes on button press in pitchShifter_ADDRadio.
function pitchShifter_ADDRadio_Callback(hObject, eventdata, handles)
% hObject    handle to pitchShifter_ADDRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pitchShifter_ADDRadio
assignin('base', 'pitchShifter_mode', 'ADD');
set(handles.pitchShifter_gainPanel, 'Visible', 1);

% --- Executes on button press in pitchShifter_REPLACERadio.
function pitchShifter_REPLACERadio_Callback(hObject, eventdata, handles)
% hObject    handle to pitchShifter_REPLACERadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pitchShifter_REPLACERadio
assignin('base', 'pitchShifter_mode', 'REPLACE');
set(handles.pitchShifter_gainPanel, 'Visible', 0);

% --- Executes on slider movement.
function pitchShifter_gainSlider_Callback(hObject, eventdata, handles)
% hObject    handle to pitchShifter_gainSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.pitchShifter_gainEdit, 'String', get(hObject,'Value'));
assignin('base', 'pitchShifter_gain', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function pitchShifter_gainSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitchShifter_gainSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function pitchShifter_gainEdit_Callback(hObject, eventdata, handles)
% hObject    handle to pitchShifter_gainEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pitchShifter_gainEdit as text
%        str2double(get(hObject,'String')) returns contents of pitchShifter_gainEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.pitchShifter_gainSlider, 'Min'))
    val = get(handles.pitchShifter_gainSlider, 'Min');
    set(handles.pitchShifter_gainSlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.pitchShifter_gainSlider, 'Max'))
    val = get(handles.pitchShifter_gainSlider, 'Max');
    set(handles.pitchShifter_gainSlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.pitchShifter_gainSlider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'pitchShifter_gain', get(handles.pitchShifter_gainSlider, 'Value'));


% --- Executes during object creation, after setting all properties.
function pitchShifter_gainEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitchShifter_gainEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
