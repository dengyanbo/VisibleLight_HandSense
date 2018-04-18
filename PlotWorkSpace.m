[ receiverID, transmitterID, rxCoord, txCoord ] = ReadInLayout( 'Workspace-information' );

scatter3( rxCoord(:, 1), rxCoord(:, 2), rxCoord(:, 3), 50, 'b', 'filled');
hold on;
scatter3( txCoord(:, 1), txCoord(:, 2), txCoord(:, 3), 50, 'r', 'filled');

xlabel('x');
ylabel('y');
zlabel('z');
az = 50;
el = 20;
view(az, el);