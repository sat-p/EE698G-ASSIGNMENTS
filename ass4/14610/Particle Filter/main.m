% Credits : Tim Bailey and Juan Nieto 2004. 

% In this programming assignment you have to perform Particle Filter (Monte Carlo) Localization of a
% mobile robot traversing in a static environment with landmarks.
% You are given snippets of MATLAB files that help you in getting the task done.

% Note :(1) The configuration of the PF-simulator is managed by the script file
    %   'configfile.m'. You have the flexibility to alter the parameters of
    %   the vehicle, sensors, etc.
    %   (2) There are also several switches that control certain filter
    %   options. You are free to choose them.
    %   (3) If you don't disturb this file the filter runs with the
    %   default parameters.

clc
clear all;
close all;

% lm - set of landmarks (i.e the ground truth locations of landmarks)
% wp - way points (these points help in generating controls to robot, you need not to worry about these wp's)

lm = load('lm.mat');
lm=lm.lm;
wp = load('wp.mat');
wp=wp.wp;

 % <--------------------------PF Localization --------------------------->

% Before running 'pf_localization_sim', all you have to do is to code the mentioned files in wrieup.  

 pf_localization_sim(lm,wp); 