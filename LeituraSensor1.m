function varargout = LeituraSensor1(varargin)
% LEITURASENSOR1 MATLAB code for LeituraSensor1.fig
%      LEITURASENSOR1, by itself, creates a new LEITURASENSOR1 or raises the existing
%      singleton*.
%
%      H = LEITURASENSOR1 returns the handle to a new LEITURASENSOR1 or the handle to
%      the existing singleton*.
%
%      LEITURASENSOR1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEITURASENSOR1.M with the given input arguments.
%
%      LEITURASENSOR1('Property','Value',...) creates a new LEITURASENSOR1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LeituraSensor1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LeituraSensor1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LeituraSensor1

% Last Modified by GUIDE v2.5 19-Oct-2016 22:53:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LeituraSensor1_OpeningFcn, ...
                   'gui_OutputFcn',  @LeituraSensor1_OutputFcn, ...
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


% --- Executes just before LeituraSensor1 is made visible.
function LeituraSensor1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LeituraSensor1 (see VARARGIN)

% Choose default command line output for LeituraSensor1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LeituraSensor1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

delete(instrfind({'Port'},{'COM3'}))
clear a;
global a;
a = arduino('COM3');


% --- Outputs from this function are returned to the command line.
function varargout = LeituraSensor1_OutputFcn(hObject, eventdata, handles) 
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
global a;
x=0; y=0; z=0;
for k=1:1:100
    b=readVoltage(a, 'A3');
    
    x=[x,b]; 
    subplot(311);
    plot(x,'LineWidth',1.5); grid on;
    axis([0 100 0 5.5]);
     
    y=[y,b];
    subplot(312);
    stem(y,'LineWidth',2); grid on;
    axis([0 100 0 6]);    

    z=[z,b];
    subplot(313);
    stairs(z,'LineWidth',2); grid on;
    axis([0 100 0 6]); 
    
    pause(0.01);    
end
