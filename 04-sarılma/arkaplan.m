function varargout = arkaplan(varargin)

    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @arkaplan_OpeningFcn, ...
                       'gui_OutputFcn',  @arkaplan_OutputFcn, ...
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


function arkaplan_OpeningFcn(hObject, eventdata, handles, varargin)

   handles.output = hObject;
    guidata(hObject, handles); 


function varargout = arkaplan_OutputFcn(hObject, eventdata, handles) 

    varargout{1} = handles.output;


function calistir_Callback(hObject, eventdata, handles)

    c = ' ';

    obje = mmreader(handles.filename);
    alarm = wavread('alarm.WAV');
    set( handles.static,'String', [handles.filename,c,'iþleniyor...']);
    [bw, index, hata] = arkaplan_cikarimi2(handles.filename,[str2num(handles.x) str2num(handles.y)]);

    if hata == 1
       set(handles.static,'String', 'Sarýlma Yok.');
       for i=1:3
            beep;
            pause(1);
       end
    else
        
        imshow(read(obje,index));
        saniye = int2str(index/25);

        set( handles.static,'String', [saniye, c, '. Saniyede sarýlma var.']);
        wavplay(alarm);
    end
    handles.output = hObject;
    guidata(hObject, handles); 

function dosya_Callback(hObject, eventdata, handles)
    
    handles.filename = uigetfile;
    imshow('siyah.jpg');
    set( handles.static,'String', [handles.filename]);
    
    handles.output = hObject;
    guidata(hObject, handles);


function baslangic_Callback(hObject, eventdata, handles)

    contents = get(hObject,'String'); 
    handles.x = contents{get(hObject,'Value')};
    handles.output = hObject;
    guidata(hObject, handles);


function baslangic_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    handles.output = hObject;
    guidata(hObject, handles);    

function bitis_Callback(hObject, eventdata, handles)

    contents = get(hObject,'String'); 
    handles.y = contents{get(hObject,'Value')}; 
    handles.output = hObject;
    guidata(hObject, handles);

    
function bitis_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    handles.output = hObject;
    guidata(hObject, handles);


