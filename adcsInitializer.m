%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NIMISH DHAWAN
% adcsInitializer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc
close all force
warning('off', 'all')

app = ADCSgui_v2_dark;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial Date and Constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
YYYY    = 2024;
DD      = 21;
MM      = 06;
HH      = 00;
MIN     = 00;
SEC     = 000;
dYear   = decyear(YYYY,MM,DD);
JD0     = juliandate(YYYY,MM,DD,HH,MIN,SEC);

rE          = 6378.14;                         % Earth radius, km
wE          = [0 0 15.04*(pi/180)*(1/3600)];   % Earth rotation speed, rad/s
mu          = 398600.4418;                     % Gravitational parameter, km^3/s^2
p           = 0.00000451;                      % Solar pressure constant, N/m^2
CD          = 2.3;                             % Drag Coefficent
eta         = 0.3;                             % Absorption Coefficient
mag_moment  = [0.005; 0.005; 0.005];           % Magnetic Dipole

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spacecraft and Wheels Initial Scenarios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% =======================================================================
% INITIAL CONDITIONS

% q1_ini = 0.386286;
% q2_ini = -0.591720;
% q3_ini = 0.309974;
% q4_ini = 0.636056;
m = 4;                              % Spacecraft mass in kg

% =======================================================================
% WHEELS SETUP

A_w     = eye(3);                   % Each wheel aligned with an axis of the s/c     
wW_1    = 0;
wW_2    = 0;
wW_3    = 0;                        % Wheels initial spin rates in rad/s for wheel 1, 2 and 3 respectively

% =======================================================================
% MAGNETORQUER SETUP

A_m = eye(3);                       % Each magnetorquer aligned with an axis of the s/c

% =======================================================================
% SPACECRAFT BUS SETUP
xAxis = 10e-2;     % in m
yAxis = 10e-2;     % in m
zAxis = 30e-2;     % in m

I_xx = (1/12) * m * (yAxis^2 + zAxis^2);
I_yy = (1/12) * m * (xAxis^2 + zAxis^2);
I_zz = (1/12) * m * (xAxis^2 + yAxis^2);
I_xy = 0;
I_xz = 0;
I_yz = 0;

J_body = [ I_xx  I_xy  I_xz;                                        % Spacecraft inertia matrix in kg m2
           I_xy  I_yy  I_yz;
           I_xz  I_yz  I_zz ];
n_list  = [1 0 0; 0 1 0; 0 0 1; -1 0 0; 0 -1 0; 0 0 -1];            % Surface normal vectors
A_list  = [10*30; 10*30; 10*10; 10*30; 10*30; 10*10] * 1e-04;       % Defining panel areas in m2
COP = [xAxis/2   0          0;         % +X face
        0        yAxis/2    0;         % +Y face
        0        0          zAxis/2;   % +Z face
       -xAxis/2  0          0;         % -X face
        0       -yAxis/2    0;         % -Y face
        0        0         -zAxis/2];  % -Z face                    % Assuming COP is at the center of each panel in m. 

% =======================================================================
% KALMAN FILTER INITIALIZATION
P_0 = 0.000000001 * eye(7); % Originally 0.0000001

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sensor Modelling
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sun Sensor
sigma_S = deg2rad(0.01);

% Magnetometer
sigma_B = 0.001;

% Gyro
sigma_g = deg2rad(0.1)/sqrt(3600);
sigma_b = deg2rad(0.04)/3600;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Custom Parameters (Override the GUI)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
app.K_wEditField.Value = 10000;
% app.J_wheels.Value = 3.81e-05;
app.J_wheels.Value = 18389 * 1e-09;           % J_zz Cubespace Bigger Wheels [CW0057]

alpha = 0.005*2;
T = 5e-3;

%%
disp('Parameters set')
