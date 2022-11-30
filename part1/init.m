clear all
close all
clc
vrclear
vrclose

load('kinematic_traj.mat');
clik_inverse;
sim('clik_inverse.mdl', t);
%plot_outputs_inverse;
visualize_results(q,pos,pd,theta_d,t)
SCARA_VR_VISUALIZE(squeeze(q(:,1,:)), false);