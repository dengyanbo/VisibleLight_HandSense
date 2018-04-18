clc;

tmn=zeros(2,16); % tmn(1,:) is entering time tm; tmn(2,:) is exiting time tn

for i = 1 : 20 % You can check the result of each PD.
    if ID(i) < 17
    curLamp = ffttable{i};
    figure;
    title(ID(i));
    hold on;
    plot(curLamp(:, ID(i)),'b');

    %find the entering/exiting time    
    IntTemp = curLamp(1,ID(i));
    deb=zeros(1,2);
    deb_enter=0;
    deb_exit=0;
    for count = 3:(length(curLamp(:,ID(i)))-1)
        if  curLamp(count, ID(i))/IntTemp < 0.6 && ...                      %60% decreased
            IntTemp - curLamp(count, ID(i)) > 30 && ...                     %decrease at least 30
            curLamp(count, ID(i)) < 30 && ...                               %gap should be lower than 30
            curLamp(count+1, ID(i)) < 30 && ...                             %next should be lower than 30 (not a peak)
            (curLamp(count-1, ID(i)) > 30 || curLamp(count-2, ID(i)) > 30)  %previous 2 should be higher than 30 (not a peak)
            if deb_enter == 0
                if curLamp(count-2, ID(i)) > 30 && ...                          %choose the middle point of the decreasing line
                        curLamp(count-2, ID(i)) - curLamp(count-1, ID(i)) > 20
                    tmn(1, ID(i)) = count-1;
                else
                    tmn(1,ID(i)) = count;
                end
                plot(count, curLamp(tmn(1,ID(i)), ID(i)), 'rx');
                IntTemp = curLamp(count, ID(i));
            else %if deb_enter == 1
                disp(ID(i));
                disp('mistake 1: ');
                disp(count);
            end
        deb_enter=1;
        end
        if curLamp(count, ID(i)) > 8 && ...
                curLamp(count, ID(i))/IntTemp > 1/0.6 && ...
            curLamp(count, ID(i)) - IntTemp > 30 && ...
            IntTemp < 30 && ...
            curLamp(count-2, ID(i)) <30 && ...
            (curLamp(count+1, ID(i)) > 30 || curLamp(count+2, ID(i)) > 30)
            
            if curLamp(count+2, ID(i)) > 30 && curLamp(count+2, ID(i)) - curLamp(count+1, ID(i)) > 20
                tmn(2, ID(i)) = count;
            else
                tmn(2,ID(i)) = count-1;
            end
            plot(count, curLamp(tmn(2,ID(i)), ID(i)), 'kx');
            IntTemp = curLamp(count, ID(i));
            if deb_exit == 1
                disp(ID(i));
                disp('mistake 2: ');
                disp(count-1);
            end
            deb_exit=1;
        end
    end
    end
    %end of time finding            
    
end

%% find the hand Beadth
delta_t=abs(tmn(1,10)-tmn(2,10));

S_all = 0;
t_all = 0;
for i = 1:12
    if tmn(1,i) ~= 0 && tmn(1,i+4) ~= 0 && tmn(1,i) > tmn(1,i+4)
        S_all = S_all + 2 * 0.8;
        t_all = t_all + tmn(1,i) - tmn(1,i+4);
    end
end
Breadth1 = S_all/t_all * delta_t 
for i = 5:16
    if tmn(2,i) ~= 0 && tmn(2,i-4) ~= 0 && tmn(2,i) < tmn(2,i-4)
        S_all = S_all + 2 * 0.8;
        t_all = t_all + tmn(2,i-4) - tmn(2,i);
    end
end
Breadth2 = S_all/t_all * delta_t
% close all;
% table of hand breadth
% Name = {'wood'};
% breadth_table = table(B_single, B_line, B_2lines, B_3lines, B_all, Breadth, 'RowNames', Name)
