%%% Configuration file
%%% Permits various adjustments to parameters of the filter.
 
% Control Parameters

V=5; % Velocity of the robot in 'meters/second'.
MAXG= 30*pi/180;  % Maximum steering angle (orientation) of robot in 'radians' (-MAXG < g < MAXG)
RATEG= 20*pi/180; % Maximum rate of change of steer angle in 'radians/second'
WHEELBASE=  4;     % Robot wheel-base in 'meters'
DT_CONTROLS=0.025;% Time interval between control signals in 'seconds'

% Noise in execution of control signals

sigmaV=  1;         % standard deviation of velocity in 'meters/second'
sigmaG= (0.1*pi/180); % standard deviation of orientation in 'radians'
 
Q = [sigmaV^2 0; 0 sigmaG^2]; % Covariance matrix
 
 
% Observation Parameters

MAX_RANGE= 30.0;           % Maximum range of the laser range finder in 'metres'
DT_OBSERVE=8*DT_CONTROLS; % Time interval between observations in 'seconds'

% NOise in range finder measurements / observations.

sigmaR= 0.1;          % standard deviation of range measuments in 'metres'
sigmaB= (0.1*pi/180); % standard deviation of laser ray angle measuments in 'radians'
R= [sigmaR^2 0; 0 sigmaB^2];

% waypoint proximity
AT_WAYPOINT= 1.0; % Minimum distance treshold to switch to next waypoint.
NUMBER_LOOPS= 2; % number of loops through the waypoint list

% switches
SWITCH_CONTROL_NOISE= 1; % if 0, velocity and orientation are perfect
SWITCH_SENSOR_NOISE = 1; % if 0, measurements are perfect
SWITCH_SEED_RANDOM= 0; % if not 0, seed the randn() with its value at beginning of simulation (for repeatability)