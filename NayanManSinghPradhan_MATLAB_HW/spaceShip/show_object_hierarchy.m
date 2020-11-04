% DONE BY NAYAN MAN SINGH PRADHAN

clear all
clf
handle_axes= axes('XLim', [-4,4], 'YLim', [-4,4], 'ZLim', [-4,4]);
xlabel('e_1');
ylabel('e_2');
zlabel('e_3');

view(3);
grid on;
axis equal
camlight

% Create ship-1
trf_ship1_root= hgtransform('Parent', handle_axes);
%Parent, specified as an Axes, Group, or Transform object.
h_original_ship= make_spaceship(trf_ship1_root, 0.8);

% Create ship-2 translated and rotated w.r.t. ship-1
trf_ship2_ship1= hgtransform('Parent',trf_ship1_root);
h_ship2= make_spaceship(trf_ship2_ship1, 0.8);

roll= -pi/10;
pitch= pi/8;
yaw= pi;

trf_roll= makehgtform('xrotate', roll);
trf_pitch= makehgtform('yrotate', pitch);
trf_yaw= makehgtform('zrotate', yaw);

trf_rpy= trf_yaw*trf_pitch*trf_roll;

translation= [3,2,3]; % 4,2,2
trf_translate= makehgtform('translate', translation);
trf_final= trf_translate*trf_rpy;

set(trf_ship2_ship1, 'Matrix', trf_final);

% TO MAKE THE SPACESHIP MOVE IN A NICE TRAJECTORY

for t = linspace(0,30,30)
    t1 = [t, 1+t, t-1];
    t2 = [t, t-1, 1-t];
    x = makehgtform('translate', t1);
    y = makehgtform('translate', t2);
    ref1 = x * trf_roll;
    ref2 = y * trf_pitch;
    set(trf_ship1_root, 'Matrix', ref1);
    set(trf_ship2_ship1, 'Matrix', ref2);
    pause(0.075)
end

drawnow;