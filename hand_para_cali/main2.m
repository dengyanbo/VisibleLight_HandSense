%% this module contains:
% main.m
% lightfft_multi.m ------------- fft on collected data
% ReadInLightData.m ------------- Read in data from the txt.file

% close all;
clear;
clc;
fclose all;

for i = 1 : 20
    filename{i} = ['testsUSB', num2str(i - 1)];
end

% searchTable = [3 11 16 27 48 60 68 79 120 96 235 158 34 7 18 40];
% searchTable = [2.86 10.4 15.98 26.65 47.80 59.95 67.47 78.70 119.90 95.27 235.8 157.3 33.75 6.65 17.75 39.95];

searchTable = [40 7 158 96 18 34 235 120 79 60 27 11 68 48 16 3]; % flash frequency of different LEDs
% starting and finishing time of all data 
start_time = 0;
end_time = 0;

resolution = 0.25; % fft-window: 500ms

for i = 1 : length(filename)
    i
    [ID(i), ffttable{i}, start_time, end_time] = lightfft_multi(filename{i}, searchTable, resolution, start_time, end_time); % return ID of the PD and the fft result
end

% syn all data
% for i = ID
%     syn_lightIntensity{i} = find_syn_lightIntensity(filename{i}, start_time, end_time);
% end
% tmn=zeros(2,20);
% for i = 1 : 20 % You can check the result of each PD.
%     curLamp = ffttable{i};
%     if ID(i) == 10 % PD 10
% %         curLamp = ffttable{i};
%         figure;
%         hold on;
%         for j = 1 : 16
% %             j=ID(i);
%             plot(curLamp(:, j), 'Color', [j * 8 / 255, 0, 1 - j * 8 / 255]);
% %             break;
%         end
%         
%     end        
%     
% end