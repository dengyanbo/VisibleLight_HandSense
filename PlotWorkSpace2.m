[ receiverID, transmitterID, rxCoord, txCoord ] = ReadInLayout( 'Workspace-information' );

scatter3( rxCoord(:, 1)*0.8*2.54, rxCoord(:, 2)*0.8*2.54, rxCoord(:, 3)*0.8*2.54, 50, 'b', 'filled');
hold on;
scatter3( txCoord(:, 1)*0.8*2.54, txCoord(:, 2)*0.8*2.54, txCoord(:, 3)*0.8*2.54, 50, 'r', 'filled');

xlabel('x');
ylabel('y');
zlabel('z');
az = 50;
el = 20;
view(az, el);