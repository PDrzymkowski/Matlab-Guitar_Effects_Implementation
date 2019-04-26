function varargout = overdriveGUI(varargin)
% OVERDRIVEGUI MATLAB code for overdriveGUI.fig
%      OVERDRIVEGUI, by itself, creates a new OVERDRIVEGUI or raises the existing
%      singleton*.
%
%      H = OVERDRIVEGUI returns the handle to a new OVERDRIVEGUI or the handle to
%      the existing singleton*.
%
%      OVERDRIVEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OVERDRIVEGUI.M with the given input arguments.
%
%      OVERDRIVEGUI('Property','Value',...) creates a new OVERDRIVEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before overdriveGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to overdriveGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help overdriveGUI

% Last Modified by GUIDE v2.5 23-Mar-2019 12:24:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @overdriveGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @overdriveGUI_OutputFcn, ...
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


% --- Executes just before overdriveGUI is made visible.
function overdriveGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to overdriveGUI (see VARARGIN)

% Choose default command line output for overdriveGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.overdrive_clipValSlider, 'Value', evalin('base', 'overdrive_clipValue'));
set(handles.overdrive_clipValEdit, 'String', num2str(evalin('base', 'overdrive_clipValue')));
set(handles.overdrive_checkbox, 'Value', evalin('base', 'overdrive_ON'));
% UIWAIT makes overdriveGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = overdriveGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function overdrive_clipValEdit_Callback(hObject, eventdata, handles)
% hObject    handle to overdrive_clipValEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of overdrive_clipValEdit as text
%        str2double(get(hObject,'String')) returns contents of overdrive_clipValEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.overdrive_clipValSlider, 'Min'))
    val = get(handles.overdrive_clipValSlider, 'Min');
    set(handles.overdrive_clipValSlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.overdrive_clipValSlider, 'Max'))
    val = get(handles.overdrive_clipValSlider, 'Max');
    set(handles.overdrive_clipValSlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.overdrive_clipValSlider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'overdrive_clipValue', get(handles.overdrive_clipValSlider, 'Value'));


% --- Executes during object creation, after setting all properties.
function overdrive_clipValEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to overdrive_clipValEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function overdrive_clipValSlider_Callback(hObject, eventdata, handles)
% hObject    handle to overdrive_clipValSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.overdrive_clipValEdit, 'String', get(hObject,'Value'));
assignin('base', 'overdrive_clipValue', get(hObject,'Value'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function overdrive_clipValSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to overdrive_clipValSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in overdrive_checkbox.
function overdrive_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to overdrive_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of overdrive_checkbox
assignin('base', 'overdrive_ON', get(hObject, 'Value'));
