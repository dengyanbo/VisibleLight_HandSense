x0 = forelimb(:,1);
y0 = forelimb(:,2);
z0 = forelimb(:,3);

% plot3(x0, y0, z0, '-ko');
% hold on;
% grid on;

x1 = coordThumb(:,1);
y1 = coordThumb(:,2);
z1 = coordThumb(:,3);
% scatter3(x1,y1,z1,5,'filled');
% line(x1,y1,z1);
% plot3(x1, y1, z1, '-ro');
x2 = coordIndex(:,1);
y2 = coordIndex(:,2);
z2 = coordIndex(:,3);
% line(x2,y2,z2);
% plot3(x2, y2, z2, '-bo');

x3 = coordMiddle(:,1);
y3 = coordMiddle(:,2);
z3 = coordMiddle(:,3);
% line(x3,y3,z3);
% plot3(x3, y3, z3, '-go');

x4 = coordRing(:,1);
y4 = coordRing(:,2);
z4 = coordRing(:,3);
% line(x4,y4,z4);
% plot3(x4, y4, z4, '-yo');

x5 = coordSmall(:,1);
y5 = coordSmall(:,2);
z5 = coordSmall(:,3);
% line(x5,y5,z5);
% plot3(x5, y5, z5, '-co');

% form the palm face.
% xP = [x1(4), x2(3), x3(3), x4(4), x5(4)];
% yP = [y1(4), y2(3), y3(3), y4(4), y5(4)];
% zP = [z1(4), z2(3), z3(3), z4(4), z5(4)];

xP = [x1(3), x2(2), x3(2), x4(2), x5(2)];
yP = [y1(3), y2(2), y3(2), y4(2), y5(2)];
zP = [z1(3), z2(2), z3(2), z4(2), z5(2)];

% plot3(xP, yP, zP, '-k');
% axis([-5 5 -5 5 0 15]*2.5);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% az = 50;
% el = 20;
% view(az, el);

%% Rotated hand
% figure,
min = 0;
max = pi/9;
step = (max - min)/(strength - 1);
angle = step * (s-1);

origin = wristCoordinate(1:3);
dirct = [0, 0, 1];
theta = angle;

limb = [x0, y0, z0];
Thumb = [x1, y1, z1];
Index = [x2, y2, z2];
Middle = [x3, y3, z3];
Ring = [x4, y4, z4];
Small = [x5, y5, z5];

Thumbr = rot3d(Thumb, origin, dirct, theta);
Indexr = rot3d(Index, origin, dirct, theta);
Middler = rot3d(Middle, origin, dirct, theta);
Ringr = rot3d(Ring, origin, dirct, theta);
Smallr = rot3d(Small, origin, dirct, theta);

hold on
grid on
PlotWorkSpace2;

plot3(limb(:,1),limb(:,2),limb(:,3), '-.ko','MarkerSize', 3);
plot3(Thumbr(:,1),Thumbr(:,2),Thumbr(:,3), '-ro','MarkerSize', 3);
plot3(Indexr(:,1),Indexr(:,2),Indexr(:,3), '-bo','MarkerSize', 3);
plot3(Middler(:,1),Middler(:,2),Middler(:,3), '-go','MarkerSize', 3);
plot3(Ringr(:,1),Ringr(:,2),Ringr(:,3), '-yo','MarkerSize', 3);
plot3(Smallr(:,1),Smallr(:,2),Smallr(:,3), '-co','MarkerSize', 3);

s_string = num2str(s);
handName=strcat('hand',s_string,'.mat');
save(handName,'limb','Thumbr','Indexr','Middler','Ringr','Smallr');

P = [xP; yP; zP];

Pr = rot3d(P',origin,dirct,theta);
Pr = Pr';
plot3(Pr(1,:), Pr(2,:), Pr(3,:), '-k');
axis([-5 5 -5 5 0 6]*2.5);
xlabel('x');
ylabel('y');
zlabel('z');
az = 0;%50;
el = 90;%20;
view(az, el);
% hold off