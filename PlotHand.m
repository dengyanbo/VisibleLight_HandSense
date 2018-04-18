figure;

x1 = coordThumb(:,1);
y1 = coordThumb(:,2);
z1 = coordThumb(:,3);
% scatter3(x1,y1,z1,5,'filled');
% line(x1,y1,z1);
plot3(x1, y1, z1, '-ro');
hold on;
grid on;
x2 = coordIndex(:,1);
y2 = coordIndex(:,2);
z2 = coordIndex(:,3);
% line(x2,y2,z2);
plot3(x2, y2, z2, '-bo');

x3 = coordMiddle(:,1);
y3 = coordMiddle(:,2);
z3 = coordMiddle(:,3);
% line(x3,y3,z3);
plot3(x3, y3, z3, '-go');

x4 = coordRing(:,1);
y4 = coordRing(:,2);
z4 = coordRing(:,3);
% line(x4,y4,z4);
plot3(x4, y4, z4, '-yo');

x5 = coordSmall(:,1);
y5 = coordSmall(:,2);
z5 = coordSmall(:,3);
% line(x5,y5,z5);
plot3(x5, y5, z5, '-co');

% form the palm face.
xP = [x1(4), x2(3), x3(3), x4(4), x5(4)];
yP = [y1(4), y2(3), y3(3), y4(4), y5(4)];
zP = [z1(4), z2(3), z3(3), z4(4), z5(4)];

plot3(xP, yP, zP, '-k');

xlabel('x');
ylabel('y');
zlabel('z');
az = 50;
el = 20;
view(az, el);
