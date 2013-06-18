function varargout = el_sikisma(varargin)
% EL_SIKISMA M-file for el_sikisma.fig
%      EL_SIKISMA, by itself, creates a new EL_SIKISMA or raises the existing
%      singleton*.
%
%      H = EL_SIKISMA returns the handle to a new EL_SIKISMA or the handle to
%      the existing singleton*.
%
%      EL_SIKISMA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EL_SIKISMA.M with the given input arguments.
%
%      EL_SIKISMA('Property','Value',...) creates a new EL_SIKISMA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before el_sikisma_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to el_sikisma_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help el_sikisma

% Last Modified by GUIDE v2.5 06-Apr-2012 06:37:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @el_sikisma_OpeningFcn, ...
                   'gui_OutputFcn',  @el_sikisma_OutputFcn, ...
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


% --- Executes just before el_sikisma is made visible.
function el_sikisma_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to el_sikisma (see VARARGIN)

    % Choose default command line output for el_sikisma
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes el_sikisma wait for user response (see UIRESUME)
    % uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = el_sikisma_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
    
% --- Executes on button press in dosya_ac.
function dosya_ac_Callback(hObject, eventdata, handles)
    % hObject    handle to dosya_ac (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    set(handles.text, 'String', ['']);
    handles.filename = uigetfile;  % dosya acmak icin
    if handles.filename
        set(handles.text, 'String', [handles.filename]);
    end
    handles.output = hObject;
    guidata(hObject, handles);
% --- Executes on button press in calistir.
function bas_frame_Callback(hObject, eventdata, handles)
    % hObject    handle to bas_frame (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    contents = get(hObject,'String');
    bas_frame = contents{get(hObject,'Value')};
    handles.bas_f = str2num(bas_frame);
    
    handles.output = hObject;
    guidata(hObject, handles);
    % --- Executes during object creation, after setting all properties.
function bas_frame_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to bas_frame (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on selection change in son_frame.
function son_frame_Callback(hObject, eventdata, handles)
    % hObject    handle to son_frame (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    contents = get(hObject,'String');
    son_frame = contents{get(hObject,'Value')};
    handles.son_f = str2num(son_frame);
    
    handles.output = hObject;
    guidata(hObject, handles);
    % --- Executes during object creation, after setting all properties.
function son_frame_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to son_frame (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function calistir_Callback(hObject, eventdata, handles)
    % hObject    handle to calistir (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    obj = mmreader(handles.filename);
    set(handles.text, 'String', [handles.filename,'  videosu iþleniyor...']);
    bg_video_yolu = handles.filename;
    fg_video_yolu = handles.filename;
    
    sonuc = main(bg_video_yolu, fg_video_yolu, [handles.bas_f, handles.son_f]);
    if sonuc
        imshow(read(obj, sonuc));
        set(handles.text, 'String', [int2str(sonuc/25), '.  saniyede el sýkýþma var.']);
    else
        set(handles.text, 'String', ['El sýkýþma bulunamadý...' ]);
    end
% --- Executes on selection change in bas_frame.
function text_Callback(hObject, eventdata, handles)
function text_CreateFcn(hObject, eventdata, handles)