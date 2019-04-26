function varargout = tremoloGUI(varargin)
% TREMOLOGUI MATLAB code for tremoloGUI.fig
%      TREMOLOGUI, by itself, creates a new TREMOLOGUI or raises the existing
%      singleton*.
%
%      H = TREMOLOGUI returns the handle to a new TREMOLOGUI or the handle to
%      the existing singleton*.
%
%      TREMOLOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TREMOLOGUI.M with the given input arguments.
%
%      TREMOLOGUI('Property','Value',...) creates a new TREMOLOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tremoloGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tremoloGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tremoloGUI

% Last Modified by GUIDE v2.5 24-Mar-2019 16:14:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tremoloGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @tremoloGUI_OutputFcn, ...
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


% --- Executes just before tremoloGUI is made visible.
function tremoloGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tremoloGUI (see VARARGIN)

% Choose default command line output for tremoloGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tremoloGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.tremolo_rateSlider, 'Value', evalin('base', 'tremolo_rate'));
set(handles.tremolo_rateEdit, 'String', num2str(evalin('base', 'tremolo_rate')));
set(handles.tremolo_depthSlider, 'Value', evalin('base', 'tremolo_depth'));
set(handles.tremolo_depthEdit, 'String', num2str(evalin('base', 'tremolo_depth')));

if(evalin('base', 'tremolo_mode') == 'SIN')
    set(handles.tremolo_SINRadio, 'Value', 1);
    set(handles.tremolo_TRIRadio, 'Value', 0);
    set(handles.tremolo_SQURadio, 'Value', 0);    
elseif(evalin('base', 'tremolo_mode') == 'TRI')
    set(handles.tremolo_SINRadio, 'Value', 0);
    set(handles.tremolo_TRIRadio, 'Value', 1);
    set(handles.tremolo_SQURadio, 'Value', 0); 
else
    set(handles.tremolo_SINRadio, 'Value', 0);
    set(handles.tremolo_TRIRadio, 'Value', 0);
    set(handles.tremolo_SQURadio, 'Value', 1); 
end

set(handles.tremolo_checkbox, 'Value', evalin('base', 'tremolo_ON'));


% --- Outputs from this function are returned to the command line.
function varargout = tremoloGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function tremolo_rateSlider_Callback(hObject, eventdata, handles)
% hObject    handle to tremolo_rateSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.tremolo_rateEdit,'String',get(hObject,'Value'));
assignin('base', 'tremolo_rate', get(hObject,'Value'));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function tremolo_rateSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tremolo_rateSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function tremolo_rateEdit_Callback(hObject, eventdata, handles)
% hObject    handle to tremolo_rateEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tremolo_rateEdit as text
%        str2double(get(hObject,'String')) returns contents of tremolo_rateEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.tremolo_rateSlider, 'Min'))
    val = get(handles.tremolo_rateSlider, 'Min');
    set(handles.tremolo_rateSlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.tremolo_rateSlider, 'Max'))
    val = get(handles.tremolo_rateSlider, 'Max');
    set(handles.tremolo_rateSlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.tremolo_rateSlider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'tremolo_rate', get(handles.tremolo_rateSlider, 'Value'));


% --- Executes during object creation, after setting all properties.
function tremolo_rateEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tremolo_rateEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tremolo_depthEdit_Callback(hObject, eventdata, handles)
% hObject    handle to tremolo_depthEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tremolo_depthEdit as text
%        str2double(get(hObject,'String')) returns contents of tremolo_depthEdit as a double
val = str2double(get(hObject,'String'));

if(val < get(handles.tremolo_depthSlider, 'Min'))
    val = get(handles.tremolo_depthSlider, 'Min');
    set(handles.tremolo_depthSlider, 'Value', val);
    set(hObject, 'String', val); 
elseif(val > get(handles.tremolo_depthSlider, 'Max'))
    val = get(handles.tremolo_depthSlider, 'Max');
    set(handles.tremolo_depthSlider, 'Value', val);
    set(hObject, 'String', val); 
else
    set(handles.tremolo_depthSlider,'Value', val);
end

guidata(hObject,handles)
assignin('base', 'tremolo_depth', get(handles.tremolo_depthSlider, 'Value'));


% --- Executes during object creation, after setting all properties.
function tremolo_depthEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tremolo_depthEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function tremolo_depthSlider_Callback(hObject, eventdata, handles)
% hObject    handle to tremolo_depthSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.tremolo_depthEdit, 'String', get(hObject,'Value'));
assignin('base', 'tremolo_depth', get(hObject,'Value'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function tremolo_depthSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tremolo_depthSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in tremolo_checkbox.
function tremolo_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to tremolo_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tremolo_checkbox
assignin('base', 'tremolo_ON', get(hObject, 'Value'));


% --- Executes on button press in radiobutton1.
function tremolo_SINRadio_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
assignin('base', 'tremolo_mode', 'SIN');


% --- Executes on button press in radiobutton1.
function tremolo_TRIRadio_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
assignin('base', 'tremolo_mode', 'TRI');


% --- Executes on button press in radiobutton1.
function tremolo_SQURadio_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
assignin('base', 'tremolo_mode', 'SQU');
