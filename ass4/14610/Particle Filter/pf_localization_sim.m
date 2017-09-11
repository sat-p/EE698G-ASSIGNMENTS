
function data= pf_localization_sim(lm, wp)
 
% INPUTS: 
%   lm - set of landmarks
%   wp - set of waypoints
%
% OUTPUTS:
%   data - a data structure containing:
%          data.true: the vehicle 'true'-path (ie, where the vehicle *actually* went)
%          data.path: the vehicle path estimate (ie, where SLAM estimates the vehicle went)
%          data.state(k).x: the SLAM state vector at time k
%          data.state(k).P: the diagonals of the SLAM covariance matrix at time k
 
format compact
configfile; % ** USE THIS FILE TO CONFIGURE THE EKF-LOCALIZATION **


% Some boring stuff to setup plots :(but helps in getting good visuualization)
figure;
plot(lm(1,:),lm(2,:),'b*')
hold on, axis([-150 120 -100 100])
plot(wp(1,:),wp(2,:), 'g', wp(1,:),wp(2,:),'g.')
xlabel('metres'), ylabel('metres')
title('Simulated Environment')

figure;
plot(lm(1,:),lm(2,:),'b*')
hold on,  axis([-150 120 -100 100])
xlabel('metres'), ylabel('metres')
title('PF-Localization')
% 
h= setup_animations;
veh= [0 -WHEELBASE -WHEELBASE; 0 -2 2]; % vehicle animation
plines=[]; % for laser line animation
pcount=0;

% initialise states

xtrue= zeros(3,1);
x= zeros(3,1);
P= [0.1 0 0;0 0.1 0;0 0 0.001];

% also intialise particles

Np = 20;
NEFFECTIVE = 0.5*Np; % used to condition on when to resample
[particles,p_w] = generate_particles(x,Np,P); % -------------------------------------------> TO DO
%p_w_new = p_w;
set(h.particles, 'xdata', particles(1,:), 'ydata', particles(2,:))
% Initialise other variables and constants

dt= DT_CONTROLS;    % Time interval between control signals in 'seconds'
dtsum= 0;           % change in time since last observation
ftag= 1:size(lm,2); % identifier for each landmark
 
iwp = 1; % index to first waypoint 
G = 0; % initial steer angle
%data = initialise_store(x,P,xtrue); % stored data for off-line
data = initialise_store(xtrue,x); % stored data for off-line

QE= Q; RE= R;  
 
% <------------------------- Main Loop ------------------------->   
 temp =0;
while iwp ~= 0
    
   
    
    % compute true data
    [G,iwp]= compute_steering(xtrue, wp, iwp, AT_WAYPOINT, G, RATEG, MAXG, dt);
   % if iwp==0 & NUMBER_LOOPS > 1, iwp=1; NUMBER_LOOPS= NUMBER_LOOPS-1; end % perform loops: if final waypoint reached, go back to first
    xtrue= vehicle_model(xtrue, V,G,dt);
    
    % Adding noise to controls.
    
    
    %  predict step ----------------------------> TO DO
    % Propogate particles via motion model
    [x,particles] = pf_predict(particles,V,G,Q,dt,p_w); %------------------------------------------> TO DO
    dtsum= dtsum + dt;
   
    if dtsum >= DT_OBSERVE
     
    dtsum = 0;
    % generating observations
    [z,ftag_visible]= get_observations(xtrue, lm, ftag, MAX_RANGE);
    z= add_observation_noise(z,R, SWITCH_SENSOR_NOISE);
    idf = ftag_visible; % known data association. i.e this idf has indices of the landmarks from which observations are generated.  
    
   % if ~isempty(z)
   % compute weights  
    p_w = compute_weights(particles,p_w,z,idf,R,lm); % --------------------------------------------> TO DO
    
    % resampling *before* computing proposal permits better particle diversity
            
     [x,particles,p_w] = resample_particles(particles,p_w,NEFFECTIVE); % -----------------------------> TO DO 
    
    end
    
    % offline data store
    data= store_data(data,xtrue,x);
    
%  <-----------------------------------------------VISULAIZATION--------------------------------------------->
% plots to get visualization
    xt= TransformToGlobal(veh,xtrue);
   % xv= TransformToGlobal(veh,x);
    set(h.xt, 'xdata', xt(1,:), 'ydata', xt(2,:))
    set(h.particles, 'xdata', particles(1,:), 'ydata', particles(2,:))
    %set(h.xv, 'xdata', xv(1,:), 'ydata', xv(2,:))
    
%     ptmp= make_covariance_ellipses(x,P);
%     pcov(:,1:size(ptmp,2))= ptmp;
        if dtsum==0
        
        %set(h.cov, 'xdata', pcov(1,:), 'ydata', pcov(2,:)) 
        pcount= pcount+1;
        if pcount == 5
            set(h.ptht, 'xdata', data.true(1,1:data.i), 'ydata', data.true(2,1:data.i))
            set(h.pth, 'xdata', data.path(1,1:data.i), 'ydata', data.path(2,1:data.i))
            pcount=0;
        end
        if ~isempty(z)
            plines= make_laser_lines(lm,xtrue,idf);
            set(h.obs, 'xdata', plines(1,:), 'ydata', plines(2,:))
        end
                
    end
    drawnow 
     
end

data= finalise_data(data);
set(h.ptht, 'xdata', data.true(1,:), 'ydata', data.true(2,:))   
set(h.pth, 'xdata', data.path(1,:), 'ydata', data.path(2,:))
%  

% 
%

%          <-----------------------------------------------HELPFUL FUNCTIONS ---------------------->

function h= setup_animations()
h.xt= patch(0,0,'b','erasemode','xor'); % true vehicle state 
h.ptht= plot(0,0,'g-','markersize',2); % true vehicle path 
h.particles = scatter(0,0,'r','.','erasemode','xor');
%h.xv= patch(0,0,'r','erasemode','xor'); % vehicle estimate
h.pth= plot(0,0,'k-','markersize',2); % vehicle path estimate

h.obs= plot(0,0,'r','erasemode','xor'); % observations
%h.cov= plot(0,0,'r','erasemode','xor'); % covariance ellipses

%
%

function p = make_laser_lines(lm,xv,idf)
% compute set of line segments for laser range-bearing measurements
if isempty(idf), p=[]; return, end
len= length(idf);
lnes(1,:)= zeros(1,len)+ xv(1);
lnes(2,:)= zeros(1,len)+ xv(2);
lnes(3:4,:)= lm(:,idf);
p= line_plot_conversion (lnes);

%
% 

function data= initialise_store(xtrue,x)
% offline storage initialisation
data.i=1;
data.path= x;
data.true= xtrue;
  
%function data= store_data(data, x, P, xtrue)
function data= store_data(data,xtrue,x)

% add current data to offline storage
CHUNK= 5000;
if data.i == size(data.true,2) % grow array in chunks to amortise reallocation
    data.path= [data.path zeros(3,CHUNK)];
    data.true= [data.true zeros(3,CHUNK)];
end
i= data.i + 1;
data.i= i;
if isempty(x)==1
data.path(:,i)=data.path(:,i-1)+eps*[1;1;1];
 else
data.path(:,i)= x;
end
data.true(:,i)= xtrue;
 
function data= finalise_data(data)
 data.true= data.true(:,1:data.i);