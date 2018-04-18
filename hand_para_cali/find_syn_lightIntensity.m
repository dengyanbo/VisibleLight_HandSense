
function syn_lightIntensity = find_syn_lightIntensity(datLabel, start_time, end_time)
fidTarget = fopen(datLabel);

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
    
    S = regexp(tline, ' ', 'split');
    if count == 1
        timeStamp = hex2dec([S{11}, S{12}, S{13}, S{14}]);
    end
    
    for count = 1 : 20   %20 intensities each line
        fir = 15 + (count - 1) * 2;
        
        curLightIntensity = hex2dec([S{fir + 1}, S{fir}]);
        lightIntensity = [lightIntensity, curLightIntensity];
    end
end
curStart_time = timeStamp(1);
start_ID = start_time - curStart_time + 1;
end_ID = end_time - curStart_time + 1;
syn_lightIntensity = lightIntensity(start_ID:end_ID);

end