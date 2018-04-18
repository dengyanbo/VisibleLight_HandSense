function [ID, fftResolutionTable, start_time, end_time] = lightfft_multi(filename, searchTable, resolution, start_time, end_time)

[ ID, lightIntensity, start_time, end_time ] = ReadInLightData(filename, start_time, end_time);

fftWindow = resolution * 1000; %(timeStamp(21) - timestamp(1))

dataTraceLength = length(lightIntensity);
start = 1;
count = 1;

fftResolutionTable = [];
while start < dataTraceLength
    curLightIntensity = lightIntensity(start : start + fftWindow);

    %% fft configuration
    Fs = 970;                       % Sampling frequency
    T = 1 / Fs;                     % Sampling period
    L = fftWindow;                  % Length of signal
    t = ( 0 : fftWindow - 1 ) * T;  % Time vector

    Y = fft(curLightIntensity);

    P2 = abs(Y / fftWindow);
    P1 = P2(1 : floor(fftWindow / 2 + 1));
    P1(2 : end - 1) = 2 * P1(2 : end - 1);

    f = Fs * ( 0 : fftWindow / 2 ) / fftWindow;

    [val, pos] = sort(P1, 'descend');

    frequencyPower = zeros(1, length(searchTable)); % corresponding power
    flag = zeros(1, length(searchTable));

    for j = 1 : length(searchTable)
        if flag(j) == 0
            for i = 1 : length(val)
                if abs(f(pos(i)) - searchTable(j)) < 2
                    frequencyPower(j) = val(i);
                    fftResolutionTable(count, j) = val(i);
                    flag(j) = 1;
                    break;
                end
            end
        end
    end

%     [searchTable; frequencyPower]
    start = start + fftWindow;
    count = count + 1;
    if start + fftWindow >= dataTraceLength
        break;
    end
end


% num2str(ID)
% result = [searchTable; frequencyPower]'
% % frequencyPower
% subplot( 4, 4, ID );
% % figure;
% % plot(f, P1);
% plot(f, P1, 'r');
% % scatter(f, P1);
% title(['Lamp', num2str(ID)]);
% axis([0 250 0 100]);
% ylabel('Amplitude');
% xlabel('frequency');

end