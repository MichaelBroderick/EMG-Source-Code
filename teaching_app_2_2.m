function varargout = teaching_app_2_2(varargin)
% TEACHING_APP_2_2 MATLAB code for teaching_app_2_2.fig
%      TEACHING_APP_2_2, by itself, creates a new TEACHING_APP_2_2 or raises the existing
%      singleton*.
%
%      H = TEACHING_APP_2_2 returns the handle to a new TEACHING_APP_2_2 or the handle to
%      the existing singleton*.
%
%      TEACHING_APP_2_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEACHING_APP_2_2.M with the given input arguments.
%
%      TEACHING_APP_2_2('Property','Value',...) creates a new TEACHING_APP_2_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before teaching_app_2_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to teaching_app_2_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help teaching_app_2_2

% Last Modified by GUIDE v2.5 07-Dec-2015 15:19:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @teaching_app_2_2_OpeningFcn, ...
                   'gui_OutputFcn',  @teaching_app_2_2_OutputFcn, ...
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


% --- Executes just before teaching_app_2_2 is made visible.
function teaching_app_2_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to teaching_app_2_2 (see VARARGIN)

% Choose default command line output for teaching_app_2_2
handles.output = hObject;
clc;

ss=get(0,'screensize');         
w=ss(3);                %Screen width and height
h=ss(4);

p=get(handles.figure1,'Position');
width=p(3);
height=p(4);

set(handles.figure1,'Position',[w*1/8,h*2/16,width,height]);

handles.current=5;
load('contraction.mat');        %Load contraction state EMG data
handles.contraction_data=contraction_data;
handles.contraction_recruitment=contraction_recruitment;
handles.stim_charge2=stim_charge2;

load('rest.mat');               %Load rest state data
handles.rest_data=rest_data;
handles.stim_charge=stim_charge;
handles.rest_recruitment=rest_recruitment;

handles.current_data=rest_data;
handles.current_stim_charge=stim_charge;
handles.current_recruitment=rest_recruitment;

handles.old_data=0;
handles.h_arrow=[];
handles.m_arrow=[];

set(handles.elec_stim,'String',[num2str(handles.current) 'mA']);
handles.leg=imread('Spine Leg.png');    %Read in the full view for axis1
handles.leg=flipud(handles.leg);

handles.motopath=imread('Motor Paths2.png');    %Read in the close up view for axis2
handles.motopath=flipud(handles.motopath);

axes(handles.full_view);        %plot axis 1
hold on;
image(handles.leg);
plot([110 457],[350 129],'-b','linewidth',2);
plot([110 428],[380 171],'-r','linewidth',2);
plot([322 410],[108 184],'-r','linewidth',2);
plot([294 368],[123 185],'-b','linewidth',2);
set(gca,'XTick',[],'YTick',[]);
xlim([0 731]); ylim([0 723]);

 x1=[451;150;150;167;182;189]; y1=[77;77;422;422;422;429];   %plot axis 2
x2=[182;189];y2=[422;415];
x3=[167;167;179;188]; y3=[422;467;467;476];
x4=[179,188];y4=[467,458];
x5=[167;167;187;194];y5=[422;385;385;392];
x6=[187;194];y6=[385;378];
x7=[231;440;440];y7=[467;467;129];
x8=[227;420;420];y8=[421;421;129];
x9=[223;400;400];y9=[386;386;129];
x10=[261;180];y10=[224;77];
x11=[261;400;420;440];y11=[224;386;421;467];

axes(handles.fibre_view);
hold on;
image(handles.motopath);
plot(x1,y1,'k-','LineWidth',2);
plot(x2,y2,'k-','LineWidth',2);
plot(x3,y3,'k-','LineWidth',2);
plot(x4,y4,'k-','LineWidth',2);
plot(x5,y5,'k-','LineWidth',2);
plot(x6,y6,'k-','LineWidth',2);
plot(x7,y7,'r-','LineWidth',2);
plot(x8,y8,'r-','LineWidth',2);
plot(x9,y9,'r-','LineWidth',2);
plot(x10,y10,'k-','LineWidth',2);
plot(x11,y11,'r-','LineWidth',2);

set(gca,'XTick',[],'YTick',[]);
xlim([0 690]); ylim([-20 640]);

uistack(handles.full_view,'top');

axes(handles.time_axis)
xlim([0 85]); ylim([-3 4.5]); 
set(gca,'XTick',[0 20 40 60 80],'YTick',[-2 -1 0 1 2 3 4]);
set(gca,'XTickLabel',[0 15 30 40 60]);
xlabel('Time (ms)','FontSize',9,'FontUnits','normalized'); ylabel('Voltage (mV)','FontSize',9,'FontUnits','normalized');
title('EMG Temporal Response','FontSize',11,'FontWeight','bold','FontUnits','normalized');
axis on; hold on;

handles.max_m_ani=animatedline('Color','r','Linewidth',2);
handles.min_m_ani=animatedline('Color','r','Linewidth',2);
handles.max_h_ani=animatedline('Color','b','Linewidth',2);
handles.min_h_ani=animatedline('Color','b','Linewidth',2);

axes(handles.ip_op)
xlim([0 32]); ylim([0 8000]);
set(gca,'XTick',[0 5 10 15 20 25 30],'YTick',[0 1000 2000 3000 4000 5000 6000 7000 8000]);
set(gca,'YTickLabel',[0 1 2 3 4 5 6 7 8]);
xlabel('Stimulus Intensity (mA)','FontSize',9,'FontUnits','normalized'); ylabel('EMG Response (mV)','FontSize',9,'FontUnits','normalized');
title('H-Reflex and M-wave Recruitment Curves','FontSize',11,'FontWeight','bold','FontUnits','normalized');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes teaching_app_2_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = teaching_app_2_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in elec_stim.
function elec_stim_Callback(hObject, eventdata, handles)
% hObject    handle to elec_stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.elec_stim,'Enable','off');
set(handles.tendon_tap,'Enable','off');

axes(handles.time_axis)             %Clear previous EMG temporal plot
plot(handles.old_data,'Color',[0.8 0.8 0.8],'LineWidth',2);
clearpoints(handles.max_m_ani);
clearpoints(handles.min_m_ani);
clearpoints(handles.max_h_ani);
clearpoints(handles.min_h_ani);
delete(handles.m_arrow);
delete(handles.h_arrow);

threshold=0.3;

handles.max_m_ani=animatedline('Color','r','Linewidth',2);
handles.min_m_ani=animatedline('Color','r','Linewidth',2);
handles.max_h_ani=animatedline('Color','b','Linewidth',2);
handles.min_h_ani=animatedline('Color','b','Linewidth',2);

[~,I] = min(abs(handles.current_stim_charge-handles.current));      %Find the nearest value in the EMG data to the value given on the electrical stimulus slider


plot_response(handles.current,get(handles.select_view,'Value'),handles.current_data(I,:),get(handles.State,'Value'), hObject,handles);      %Animate the neural firings
handles.old_data=handles.current_data(I,:);
guidata(hObject,handles);

pause(1);
[max_m,max_m_I]=max(handles.current_data(I,1:length(handles.current_data(I,:))/2));         %The peaks in EMG data on the temporal plot, corresponding to H-reflex and M-wave values
[min_m,min_m_I]=min(handles.current_data(I,1:length(handles.current_data(I,:))/2));
[max_h,max_h_I]=max(handles.current_data(I,length(handles.current_data(I,:))/2+1:end));
[min_h,min_h_I]=min(handles.current_data(I,length(handles.current_data(I,:))/2+1:end));

max_h_I=max_h_I+length(handles.current_data(I,:))/2;
min_h_I=min_h_I+length(handles.current_data(I,:))/2;

max_mline=[(max_m_I-5:max_m_I+3);ones(1,9)*max_m]';
min_mline=[(min_m_I-3:min_m_I+5);ones(1,9)*min_m]';

max_hline=[(max_h_I-4:max_h_I+4);ones(1,9)*max_h]';
min_hline=[(min_h_I-4:min_h_I+4);ones(1,9)*min_h]';



axes(handles.time_axis)     %Animate EMG data on the temporal plot
hold on;
for i=1:length(max_mline)
   
    addpoints(handles.max_m_ani,max_mline(i,1),max_mline(i,2));
    addpoints(handles.min_m_ani,min_mline(i,1),min_mline(i,2));
    drawnow;
    
end

if abs(max_m-min_m)<threshold
   
    clearpoints(handles.max_m_ani);
clearpoints(handles.min_m_ani);
    delete(handles.m_arrow);

end


axes(handles.time_axis);
p=(max_m_I+min_m_I)/2;
handles.m_arrow=plot([p p],[max_m min_m],'r','LineWidth',1);

axes(handles.ip_op)     %Plot the recruitment curve
hold on;
stem(handles.current,handles.current_recruitment(I,1),'filled','Color','r','LineWidth',2);

pause(1);

axes(handles.time_axis)
hold on;
for i=1:length(max_mline)
   
    addpoints(handles.max_h_ani,max_hline(i,1),max_hline(i,2));
    addpoints(handles.min_h_ani,min_hline(i,1),min_hline(i,2));
    drawnow;
    
end

if abs(max_h-min_h)<threshold
   
    clearpoints(handles.max_h_ani);
clearpoints(handles.min_h_ani);
    delete(handles.h_arrow);


end

p=(max_h_I+min_h_I)/2;
handles.h_arrow=plot([p p],[max_h min_h],'b','LineWidth',1);

axes(handles.ip_op)
stem(handles.current,handles.current_recruitment(I,2),'filled','Color','b','LineWidth',2);

uistack(handles.max_m_ani,'top')
uistack(handles.min_m_ani,'top')
uistack(handles.max_h_ani,'top')
uistack(handles.min_h_ani,'top')

set(handles.elec_stim,'Enable','on');
set(handles.tendon_tap,'Enable','on');

guidata(hObject,handles);







% --- Executes on button press in tendon_tap.
function tendon_tap_Callback(hObject, eventdata, handles)
% hObject    handle to tendon_tap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
            
set(handles.elec_stim,'Enable','off');
set(handles.tendon_tap,'Enable','off');

axes(handles.time_axis)
cla;
ani_data=animatedline('Color','k','Linewidth',2);

        axes(handles.full_view);
        h_flex(:,1)=[linspace(457,110,35) linspace(110,428,35) NaN(1,15)];
        h_flex(:,2)=[linspace(129,350,35) linspace(380,171,35) NaN(1,15)];
        blu=[115 200 255]/255;

        a_h1 = animatedline('Color',blu,'Marker','o','MarkerSize',8,'MarkerFaceColor',blu,'MaximumNumPoints',1 );

       
        for i=1:length(h_flex)

            addpoints(a_h1,h_flex(i,1),h_flex(i,2))
             axes(handles.time_axis)
             addpoints(ani_data,i,handles.current_data(12,i))
            drawnow expose %% nocallbacks

        end
        clearpoints(a_h1)
        
        set(handles.elec_stim,'Enable','on');
set(handles.tendon_tap,'Enable','on');

handles.old_data=handles.current_data(12,:);
guidata(hObject,handles);



% --- Executes on selection change in select_view.
function select_view_Callback(hObject, eventdata, handles)
% hObject    handle to select_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns select_view contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_view
if get(handles.select_view,'Value')==1

    uistack(handles.full_view,'top');
    set(handles.elec_stim,'Position',handles.full_pos);
        set(handles.tendon_tap,'Visible','on');
else

    uistack(handles.fibre_view,'top');
    set(handles.elec_stim,'Position',[0.61,0.425,0.0636,0.0549]);
    set(handles.tendon_tap,'Visible','off');
end
    



% --- Executes during object creation, after setting all properties.
function select_view_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function select_current_Callback(hObject, eventdata, handles)
% hObject    handle to select_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.current=get(handles.select_current,'Value')*25+5;
set(handles.elec_stim,'String',[sprintf('%.1f',handles.current) 'mA']);
guidata(hObject,handles);
axes(handles.time_axis);
%plot(handles.temporal_data(round(handles.current),:));


% --- Executes during object creation, after setting all properties.
function select_current_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in State.
function State_Callback(hObject, eventdata, handles)
% hObject    handle to State (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns State contents as cell array
%        contents{get(hObject,'Value')} returns selected item from State
axes(handles.time_axis)
cla
axes(handles.ip_op)
cla
hold on;
plot(handles.current_stim_charge,handles.current_recruitment(:,1),'Color',[1 0.75 0.75],'LineWidth',2);
plot(handles.current_stim_charge,handles.current_recruitment(:,2),'Color',[0.75 0.75 1],'LineWidth',2);

if get(handles.State,'Value')==1
    handles.current_data=handles.rest_data;
handles.current_stim_charge=handles.stim_charge;
handles.current_recruitment=handles.rest_recruitment;
    legend('M-wave: Contraction','H-reflex: Contraction');

else
        handles.current_data=handles.contraction_data;
handles.current_stim_charge=handles.stim_charge2;
handles.current_recruitment=handles.contraction_recruitment;

legend('M-wave: Resting','H-reflex: Resting');
end
handles.old_data=0;


guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function State_CreateFcn(hObject, eventdata, handles)
% hObject    handle to State (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clear1.
function clear1_Callback(hObject, eventdata, handles)
% hObject    handle to clear1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.time_axis)
cla;

handles.old_data=0;
guidata(hObject,handles);
