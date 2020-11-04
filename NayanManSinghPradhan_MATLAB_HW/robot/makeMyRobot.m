% DONE BY NAYAN MAN SINGH PRADHAN

clear all
close all
clf
handle_axes= axes('XLim', [-0.4,0.4], 'YLim', [-0.2,0.4], 'ZLim', [0,0.4]);

xlabel('e_1'); 
ylabel('e_2');
zlabel('e_3');

view(-130, 26);
grid on;
axis equal
camlight
axis_length= 0.05;

%% Root frame E
trf_E_axes= hgtransform('Parent', handle_axes); 

%% Link-0: Base-link -> parent

trf_link0_E= make_transform([0, 0, 1], 0, 0, pi/2, trf_E_axes);
plot_axes(trf_link0_E, 'L_0', false, axis_length); 
 
trf_viz_link0= make_transform([0, 0, 0.5], 0, 0, 0, trf_link0_E);
length0= 0.2; radius0= 0.05;
h(1)= link_cylinder(radius0, length0, trf_viz_link0, [0.823529 0.411765 0.117647]); 
plot_axes(trf_viz_link0, ' ', true, axis_length); % V_0

%% Link-1 -> child 1 (main cylinder I want to rotate)
trf_viz_link1= make_transform([0, 0, 0.2], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
length1= 0.55; radius1= 0.04;
h(2)= link_cylinder(radius1, length1, trf_viz_link1, [0, 0, 1]); 

%% Link-2 -> child 2 box (small handle on top)
trf_viz_link2= make_transform([0, 0, 0.55], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(3)= link_box([0.2, 0.02, 0.04], trf_viz_link2, [0, 0, 1]); 
plot_axes(trf_viz_link2, ' ', true, axis_length); % V_{1-2}

%% Link-5 -> big box that I want to spin with child 1
trf_viz_link5= make_transform([0.0, 0, -0.05], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(6)= link_box([0.05, 0.05, 0.2], trf_viz_link5, [0, 0, 1]); 
plot_axes(trf_viz_link5, ' ', true, axis_length); % V_{1-2}

%% Link-6 -> smaller box that I want to spin with child 1
trf_viz_link6= make_transform([0.0, 0.0, -0.15], 0, 0, 0); % Do not specify parent yet: It will be done in the joint
h(7)= link_box([0.02, 0.02, 0.1], trf_viz_link6, [0, 0, 1]); 
plot_axes(trf_viz_link6, ' ', true, axis_length); % V_{1-2}

%% Joints 

%% Joint 1
trf_joint1_link0= make_transform([0, 0, 0], 0, 0, 0, trf_link0_E); 
make_child(trf_joint1_link0, trf_viz_link1);

%% Joint 2
trf_joint2_link0= make_transform([0, 0, 0], 0, 0, 0, trf_link0_E); 
make_child(trf_joint2_link0, trf_viz_link2);

%% Joint 3
j1_rot_axis_j1= [0,0,1]';
j1_rot_angle= 0; % [-pi/2, pi/2]

trf_joint1_link5= make_transform([0, 0, 0], 0, 0, pi/90, trf_link0_E); 
trf_link1_joint5= make_transform_revolute(j1_rot_axis_j1, j1_rot_angle, trf_joint1_link5); 
plot_axes(trf_link1_joint5, ' ', false, axis_length); 
make_child(trf_link1_joint5, trf_viz_link1);

%% Joint 4

j1_rot_axis_j2= [0,0,1]';
j1_rot_angle= 0; % [-pi/2, pi/2]

trf_joint1_link6= make_transform([0, 0, 0], 0, 0, pi/90, trf_link0_E); 
trf_link1_joint6= make_transform_revolute(j1_rot_axis_j2, j1_rot_angle, trf_joint1_link6); 
plot_axes(trf_link1_joint6, ' ', false, axis_length); 
make_child(trf_link1_joint6, trf_viz_link5);


%% Joint 5

j1_rot_axis_j3= [0,0,1]';
j1_rot_angle= 0; % [-pi/2, pi/2]
% 
trf_joint1_link3= make_transform([0, 0, 0], 0, 0, pi/90, trf_link0_E); 
trf_link1_joint3= make_transform_revolute(j1_rot_axis_j3, j1_rot_angle, trf_joint1_link3); 
plot_axes(trf_link1_joint3, ' ', false, axis_length); 
make_child(trf_link1_joint3, trf_viz_link6);


%% Animation: All joints together.
q_init= 0.5*ones(4,1); % This leads to all joints being at 0.
% 
for i= 1:20
    q_next= rand(4,1); 
    % rand() gives uniformly distributed random numbers in the interval [0,1]
    
    for t=0:0.02:1
        q= q_init + t*(q_next - q_init);
        q1= (pi/2)*(2*q(1) - 1);
        q2= (pi/2)*(2*q(2) - 1);
        q3= (pi/2)*(2*q(3) - 1);
         
        set(handle_axes, 'XLim', [-0.4,0.4], 'YLim', [-0.4,0.4], 'ZLim', [0.6,1.6]);
        trf_q1= makehgtform('axisrotate', j1_rot_axis_j1, q1);
        set(trf_joint1_link5, 'Matrix', trf_q1);
        
        set(handle_axes, 'XLim', [-0.4,0.4], 'YLim', [-0.4,0.4], 'ZLim', [0.6,1.6]);
        trf_q2= makehgtform('axisrotate', j1_rot_axis_j2, q1);
        set(trf_joint1_link6, 'Matrix', trf_q1);
        
        set(handle_axes, 'XLim', [-0.4,0.4], 'YLim', [-0.4,0.4], 'ZLim', [0.6,1.6]);
        trf_q3= makehgtform('axisrotate', j1_rot_axis_j2, q1);
        set(trf_link1_joint3, 'Matrix', trf_q1);

        drawnow;
        pause(0.005);
       
     end
    
    q_init= q_next;
    
end



