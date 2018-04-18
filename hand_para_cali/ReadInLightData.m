%% Visible-light sensing
%  Instructions
%  ------------
% 
%  Function in this file processes inputted light intensity data, processes
%  then aggregates them to form a set of shadow map

% function [ flag, receiverID, packNumber, timeStamp, lightIntensity ] = IntensityMapProcessing(datSource)
function [ ID, lightIntensity, start_time, end_time] = ReadInLightData(datLabel, start_time, end_time)
% 00 00 00 00 00 1A 00 07 00 01 00 01 39 AE 61 63 62 60 5E 5E 5F 61 62 63 64 61 60 60 5D 61 61 62 64 62 
%                         ID      timestamp lightIntensity 
fidTarget = fopen(datLabel);

 ID = [];
 timeStamp = [];
 lightIntensity = [];

 count = 1;
 while ~feof(fidTarget)
   tline = fgetl(fidTarget);
   if count == 1
       initLen = length(tline);
   else
       if length(tline) ~= initLen
           break;
       end
   end
   
   S = deblank(tline);
   S = regexp(tline, ' ', 'split');
   
   ID = hex2dec([S{9}, S{10}]);
   curTimeStamp = hex2dec([S{11}, S{12}, S{13}, S{14}]);
   
   for count = 1 : 20   %20 intensity each line
       fir = 15 + (count - 1) * 2;
       
       curLightIntensity = hex2dec([S{fir + 1}, S{fir}]);
       timeStamp = [timeStamp, curTimeStamp];
       lightIntensity = [lightIntensity, curLightIntensity];
   end    
 end
 
 % calculate the starting time and finishing time
 curStart_time = timeStamp(1);
 curEnd_time = timeStamp(1) + length(lightIntensity) - 1;
 if start_time < curStart_time
     start_time = curStart_time;
 end
 if end_time > curEnd_time || end_time == 0
     end_time = curEnd_time;
 end


% figure;
% scatter(1:length(lightIntensity), lightIntensity);
% plot(lightIntensity);
% hold on;

% lightIntensity = filter(G, 1, lightIntensity);
% scatter(1:length(lightIntensity), lightIntensity,'r');
% plot(lightIntensity + abs(min(lightIntensity)),'r');
fclose(fidTarget);

