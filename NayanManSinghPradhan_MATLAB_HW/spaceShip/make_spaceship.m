% DONE BY NAYAN MAN SINGH PRADHAN

function [ myhandles ] = make_spaceship(trf_root, transparency)
% Makes a space-ship with the root transform as the given transform.
% The surfaces are drawn with the given transparency in [0,1]
% A vector of handles to all the surfaces is returned.

ship_dish_profile= 2*sin(linspace(0, pi, 15));
[Xc, Yc, Zc]= cylinder(ship_dish_profile);


%ADDING A NEW STRUCTURE -> SPHERE
[Xs, Ys, Zs] = sphere;
r = 1;
xx = Xs * r;
yy = Ys * r;
zz = Zs * r;

% Sphere
trf_sphere= hgtransform('Parent', trf_root);
set(trf_sphere, 'Matrix', makehgtform('translate', [0, 0, 1]));
color_sphere= [0.9, 0.1, 0.6];
myhandles(7)= surface(xx, yy, zz, 'Parent', trf_sphere, 'FaceColor', color_sphere, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_sphere, 'EdgeAlpha', transparency);

% Top dish
trf_top_root= hgtransform('Parent', trf_root);
set(trf_top_root, 'Matrix', makehgtform('translate', [0, 0, -0.175]));
color_top= [0.3, 0.6, 0.5];
myhandles(1)= surface(Xc, Yc, Zc, 'Parent', trf_top_root, 'FaceColor', color_top, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_top, 'EdgeAlpha', transparency);

% Bottom dish
trf_bottom_root= hgtransform('Parent', trf_root);
set(trf_bottom_root, 'Matrix', makehgtform('translate', [0, 0, 0.175]));
color_bottom= [0.2, 0.7, 0.9];
myhandles(2)= surface(Xc, Yc, Zc, 'Parent', trf_bottom_root, 'FaceColor', color_bottom, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_bottom, 'EdgeAlpha', transparency);

% creates x, y, z coordinates of unit cylinder to draw left tail
[Xt, Yt, Zt]= cylinder([0.1, 0.3, 0.5]);
% Left tail
trf_tailleft_root= hgtransform('Parent', trf_root);
trf_scale= makehgtform('scale', [1,1,1.5]);
trf_Ry= makehgtform('yrotate', -pi/2);
trf_T= makehgtform('translate', [-3, 0.75, 2]);
% Interpret the order as BFT (left to right)
set(trf_tailleft_root, 'Matrix', trf_T*trf_Ry*trf_scale);
color_tail_left= [0.9 0.2 0.5]; 
myhandles(3)= surface(Xt, Yt, Zt, 'Parent', trf_tailleft_root, 'FaceColor', color_tail_left, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_tail_left, 'EdgeAlpha', transparency);

% creates x, y, z coordinates of unit cyclinder to draw right tail
[Xr, Yr, Zr]= cylinder([0.1, 0.3, 0.5]);
% right tail
trf_tailright_root= hgtransform('Parent', trf_root);
trf_scale= makehgtform('scale', [1,1,1.5]);
trf_Ry= makehgtform('yrotate', -pi/2);
trf_T=makehgtform('translate', [-3, -0.75, 2]);
% Interpret the order as BFT (left to right)
set(trf_tailright_root, 'Matrix', trf_T*trf_Ry*trf_scale);
color_tail_right= [0.9 0.2 0.5]; 
myhandles(4)= surface(Xr, Yr, Zr, 'Parent', trf_tailright_root, 'FaceColor', color_tail_right, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_tail_right, 'EdgeAlpha', transparency);

% Creates x, y, z coordinates of unit cylinder to draw the left tail connector
[XcL1, YcL1, ZcL1] = cylinder([0.1, 0.2, 0.125]);
% Connectors to connect left tail to main body
trf_connectorLeft1_root= hgtransform('Parent', trf_root);
trf_scale= makehgtform('scale', [1,1,1.8]);
trf_Ry= makehgtform('yrotate', -pi/5.5);
trf_T=makehgtform('translate', [-2.1, 0.75, 0.5]);
% Interpret the order as BFT (left to right)
set(trf_connectorLeft1_root, 'Matrix', trf_T*trf_Ry*trf_scale);
color_connectorLeft1= [0.3 0.1 0.3]; 
myhandles(5)= surface(XcL1, YcL1, ZcL1, 'Parent', trf_connectorLeft1_root, 'FaceColor', color_connectorLeft1, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_connectorLeft1, 'EdgeAlpha', transparency);

%creates x, y, z coordingaes of unit cylinder to draw the right tail connector
[XcL1, YcL1, ZcL1] = cylinder([0.1, 0.2, 0.125]);
%connectors to connect right tail to main body
trf_connectorRight1_root= hgtransform('Parent', trf_root);
trf_scale= makehgtform('scale', [1,1,1.8]);
trf_Ry= makehgtform('yrotate', -pi/5.5);
trf_T=makehgtform('translate', [-2.1, -0.75, 0.5]);
% Interpret the order as BFT (left to right)
set(trf_connectorRight1_root, 'Matrix', trf_T*trf_Ry*trf_scale);
color_connectorRight1= [0.3 0.1 0.3]; 
myhandles(5)= surface(XcL1, YcL1, ZcL1, 'Parent', trf_connectorRight1_root, 'FaceColor', color_connectorRight1, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_connectorRight1, 'EdgeAlpha', transparency);

% creates x, y, z coordinates of unit cyclinder to draw right joining
[Xrj, Yrj, Zrj]= cylinder([0.1, 0.3, 0.0]);
trf_rightJoin_root= hgtransform('Parent', trf_root);
trf_scale= makehgtform('scale', [1,1,1.5]);
trf_Ry= makehgtform('yrotate', -pi/2);
trf_T=makehgtform('translate', [-3.2, -0.75, 2]);
set(trf_rightJoin_root, 'Matrix', trf_T*trf_Ry*trf_scale);
color_right_join= [0.9 0.2 0.5]; 
myhandles(6)= surface(Xrj, Yrj, Zrj, 'Parent', trf_rightJoin_root, 'FaceColor', color_right_join, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_right_join, 'EdgeAlpha', transparency);

% creates x, y, z coordinates of unit cyclinder to draw left joining
[Xrj, Yrj, Zrj]= cylinder([0.1, 0.3, 0.0]);
trf_leftJoin_root= hgtransform('Parent', trf_root);
trf_scale= makehgtform('scale', [1,1,1.5]);
trf_Ry= makehgtform('yrotate', -pi/2);
trf_T=makehgtform('translate', [-3.2, 0.75, 2]);
set(trf_leftJoin_root, 'Matrix', trf_T*trf_Ry*trf_scale);
color_left_join= [0.9 0.2 0.5]; 
myhandles(6)= surface(Xrj, Yrj, Zrj, 'Parent', trf_leftJoin_root, 'FaceColor', color_left_join, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_left_join, 'EdgeAlpha', transparency);

% Everything below this is just to customize the space ship to my liking :)

% Creates x, y, z coordinates of unit cylinder to design the space ship (right side)
[Xr, Yr, Zr]= cylinder([0.175, 0.2, 0.4]);
trf_tailright_root= hgtransform('Parent', trf_root);
trf_scale= makehgtform('scale', [1,1,2.75]);
trf_Ry= makehgtform('yrotate', -pi/2);
trf_T=makehgtform('translate', [-1.5, -0.75, 0.5]);
set(trf_tailright_root, 'Matrix', trf_T*trf_Ry*trf_scale);
color_tail_right= [0.9 0.2 0.5]; 
myhandles(4)= surface(Xr, Yr, Zr, 'Parent', trf_tailright_root, 'FaceColor', color_tail_right, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_tail_right, 'EdgeAlpha', transparency);

% Creates x, y, z coordinates of unit cylinder to design the space ship on (left side)
[Xr, Yr, Zr]= cylinder([0.175, 0.2, 0.4]);
trf_tailright_root= hgtransform('Parent', trf_root);
trf_scale= makehgtform('scale', [1,1,2.75]);
trf_Ry= makehgtform('yrotate', -pi/2);
trf_T=makehgtform('translate', [-1.5, 0.75, 0.5]);
set(trf_tailright_root, 'Matrix', trf_T*trf_Ry*trf_scale);
color_tail_right= [0.9 0.2 0.5]; 
myhandles(4)= surface(Xr, Yr, Zr, 'Parent', trf_tailright_root, 'FaceColor', color_tail_right, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_tail_right, 'EdgeAlpha', transparency);

% Creates x, y, z coordinates of unit cylinder to design the space ship (right side)
[Xrj, Yrj, Zrj]= cylinder([0.1, 0.3, 0.0]);
trf_leftJoin_root= hgtransform('Parent', trf_root);
trf_scale= makehgtform('scale', [1,1,2.75]);
trf_Ry= makehgtform('yrotate', -pi/2);
trf_T=makehgtform('translate', [-2, -0.75, 0.5]);
set(trf_leftJoin_root, 'Matrix', trf_T*trf_Ry*trf_scale);
color_left_join= [0.9 0.2 0.5]; 
myhandles(6)= surface(Xrj, Yrj, Zrj, 'Parent', trf_leftJoin_root, 'FaceColor', color_left_join, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_left_join, 'EdgeAlpha', transparency);

% Creates x, y, z coordinates of unit cylinder to design the space ship on (left side)
[Xrj, Yrj, Zrj]= cylinder([0.1, 0.3, 0.0]);
trf_leftJoin_root= hgtransform('Parent', trf_root);
trf_scale= makehgtform('scale', [1,1,2.75]);
trf_Ry= makehgtform('yrotate', -pi/2);
trf_T=makehgtform('translate', [-2, 0.75, 0.5]);
set(trf_leftJoin_root, 'Matrix', trf_T*trf_Ry*trf_scale);
color_left_join= [0.9 0.2 0.5]; 
myhandles(6)= surface(Xrj, Yrj, Zrj, 'Parent', trf_leftJoin_root, 'FaceColor', color_left_join, 'FaceAlpha', transparency, 'EdgeColor', 0.5*color_left_join, 'EdgeAlpha', transparency);

end

