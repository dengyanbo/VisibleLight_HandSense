%% ReadInLayout.m
%  Instructions
%  ------------
% 
%  Function in this file ReadInLayout.
function [ receiverID, transmitterID, rxCoord, txCoord, sxRange, syRange, szRange, losPath ] = ReadInLayout( workSpaceLayout )
%% Information
% Height 12 in = 30.48 cm
% Width 1 in = 2.54 cm
sxRange = 3;
syRange = 3;
szRange = 6;

if strcmp(workSpaceLayout, 'Workspace-information')
    % Read in shadow map without blocking
else
    fprintf('Read in layout folder Error! \n');
    return;
end
     
% Read in shadow map without blocking
fidTarget = fopen('coord-receiver.txt');

count = 1; % number of receiver
while ~feof(fidTarget)
   tline = fgetl(fidTarget);
   S = deblank(tline);
   S = regexp(tline, ' ', 'split'); 
   receiverID(count) = str2num(S{1}); % ID of the current PD

   curCoord = regexp(S{2}, ',', 'split'); 
   rxCoord(count, 1) = str2num(curCoord{1});
   rxCoord(count, 2) = str2num(curCoord{2});
   rxCoord(count, 3) = str2num(curCoord{3});
   count = count + 1;
end
fclose(fidTarget);

fidTarget = fopen('coord-transmitter.txt');
count = 1; % number of receiver
while ~feof(fidTarget)
   tline = fgetl(fidTarget);
   S = deblank(tline);
   S = regexp(tline, ' ', 'split'); 
   transmitterID(count) = str2num(S{1}); % ID of the current PD

   curCoord = regexp(S{2}, ',', 'split'); 
   txCoord(count, 1) = str2num(curCoord{1});
   txCoord(count, 2) = str2num(curCoord{2});
   txCoord(count, 3) = str2num(curCoord{3});
   count = count + 1;
end
fclose(fidTarget);   
   
%% Generated LoS paths
txSize = size(txCoord);
rxSize = size(rxCoord);

losPath = zeros(txSize(1) * rxSize(1), 3);
for i = 1 : txSize(1)
    for j = 1 : rxSize(1)
        losPath( ( i - 1 ) * rxSize(1) + j, :) = txCoord(i, :) - rxCoord(j, :);
    end
end

end


