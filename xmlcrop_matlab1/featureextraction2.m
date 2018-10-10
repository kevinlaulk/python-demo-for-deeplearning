function varargout = featureextraction2(varargin)
% FEATUREEXTRACTION2 MATLAB code for featureextraction2.fig
%      FEATUREEXTRACTION2, by itself, creates a new FEATUREEXTRACTION2 or raises the existing
%      singleton*.
%
%      H = FEATUREEXTRACTION2 returns the handle to a new FEATUREEXTRACTION2 or the handle to
%      the existing singleton*.
%
%      FEATUREEXTRACTION2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FEATUREEXTRACTION2.M with the given input arguments.
%
%      FEATUREEXTRACTION2('Property','Value',...) creates a new FEATUREEXTRACTION2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before featureextraction2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to featureextraction2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help featureextraction2

% Last Modified by GUIDE v2.5 01-Feb-2017 23:18:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @featureextraction2_OpeningFcn, ...
                   'gui_OutputFcn',  @featureextraction2_OutputFcn, ...
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


% --- Executes just before featureextraction2 is made visible.
function featureextraction2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to featureextraction2 (see VARARGIN)

% Choose default command line output for featureextraction2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes featureextraction2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = featureextraction2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%读取图片
global im
global recode
global state
global filename
load recode
[filename,pathname]=uigetfile({'*.jpg';'*.bmp';'*.gif'},'选择图片');
postion=strfind(filename,'-');%改变位置，自动下一个照片
postion1=strfind(filename,'.');
camera=filename(postion:postion1-1);
mkdir('./',strcat('./component',camera));
% while(1)
    str=[pathname filename];
    im=imread(str);
    axes(handles.axes4);
    imshow(im);
    cropimg = imcrop(im);
    axes(handles.axes5);
    imshow(cropimg)
    file_name=strcat('.\component',camera,'\',filename);%存储标准子图位置
    imwrite(cropimg,file_name,'jpg') %存储标准子图
    recode={recode,{filename,state}};%记录
    set(handles.edit1,'String',stract('component',filename(end)));
    set(handles.edit2,'String',file_name);
    
    
    postion=strfind(filename,'-');%改变位置，自动下一个照片
    filename_end=filename(postion:end);
    filename_pr= str2num(filename(1:postion-1));
    filename_pr=filename_pr+1;
    filename=strcat(num2str(filename_pr),filename_end);
% end



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global recode
save recode
clc,clear
close


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global state
str=get(hObject,'string');
switch str
    case '正常'
        state=0;
    case '故障'
        state=1;
end
state


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global name
name=get(handles.edit1,'String')



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




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


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes5
