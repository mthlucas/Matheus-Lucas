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

delete(instrfind({'Port'},{'COM3'})) % Limpar porta de comunica��o serial
clear a;  % Limpar porta de comunica��o serial
global a; 
a = arduino('COM3'); %Inicia uma nova comunica��o Serial com o Arduino


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
global a; %Para usar os comandos do arduino dentro da fun��o
x=0; y=0; z=0;
for k=1:1:100 %Faz a leitura do sensor de 0 at� 100
    b=readVoltage(a, 'A3'); %Leitura do sensor na porta A3
        if b>2                           %Se a leitura passar de 2V, o buzzer apita
            playTone(a,'D6',1000,0.1);
        end
    x=[x,b]; %Guarda o valor da leitura do sensor no vetor x
    subplot(311);% Plota no gr�fico 1
    plot(x,'LineWidth',1.5); grid on; %Plota a leitura do sensor
    axis([0 100 0 6]);
     
    y=[y,b];
    subplot(312);% Plota no gr�fico 2
    stem(y,'LineWidth',2); grid on;%Plota o sinal amostrado
    axis([0 100 0 6]);    

    z=[z,b];
    subplot(313);% Plota no gr�fico 3
    stairs(z,'LineWidth',2); grid on; %Plota o sinal reconstruido;
    axis([0 100 0 6]); 
    
    pause(0.01);    
end
