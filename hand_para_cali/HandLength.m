clc;

tmn=zeros(2,16);

for i = 1 : 20 % You can check the result of each PD.
    if ID(i) < 17 %&& ID(i) == 5 || ID(i) == 6 || ID(i) == 7 || ID(i) == 8% || ID(i) == 9 || ID(i) == 10 || ID(i) == 11 || ID(i) == 12 
        curLamp = ffttable{i};
        figure;
        hold on;
        title(ID(i));
        plot(curLamp(:, ID(i)),'b');

        %find the entering/exiting time
        IntTemp = curLamp(2,ID(i));
        deb_enter=0;
        deb_exit=0;
        for count = 3:(length(curLamp(:,ID(i)))-2)
            %enter
            if  curLamp(count, ID(i))/IntTemp < 0.6 && ...                      %60% decreased
                IntTemp - curLamp(count, ID(i)) > 30 && ...                     %decrease at least 30
                curLamp(count, ID(i)) < 30 && ...                               %gap should be lower than 30
                curLamp(count+1, ID(i)) < 30 && ...                             %next should be lower than 30 (not a peak)
                (curLamp(count-1, ID(i)) > 30 || curLamp(count-2, ID(i)) > 30)  %previous 2 should be higher than 30 (not a peak)
                if deb_enter == 0
                    if curLamp(count-2, ID(i)) > 30 && ...                          %choose the middle point of the decreasing line
                            curLamp(count-2, ID(i)) - curLamp(count-1, ID(i)) > 20
                        tmn(1, ID(i)) = count;
                    else
                        tmn(1,ID(i)) = count+1;
                    end
                    plot(count, curLamp(tmn(1,ID(i)), ID(i)), 'rx');               
                    deb_enter=1;
                end
                IntTemp = curLamp(count, ID(i));
            end
            
            %exit
            if curLamp(count, ID(i)) > 8 && ...
                curLamp(count, ID(i))/IntTemp > 1/0.6 && ...
                curLamp(count, ID(i)) - IntTemp > 30 && ...
                IntTemp < 30 && ...
                curLamp(count-2, ID(i)) <30 && ...
                (curLamp(count+1, ID(i)) > 30 || curLamp(count+2, ID(i)) > 30)

                if curLamp(count+2, ID(i)) > 30 && curLamp(count+2, ID(i)) - curLamp(count+1, ID(i)) > 20
                    tmn(2, ID(i)) = count-1;
                else
                    tmn(2,ID(i)) = count-2;
                end
                IntTemp = curLamp(count, ID(i));
                if deb_exit == 1
                else
                    deb_exit=1;
                end
            end
            %end of exiting
        end
        %end of one PD
        if tmn(2, ID(i)) ~= 0
            plot(tmn(2,ID(i)), curLamp(tmn(2,ID(i)), ID(i)), 'kx');
        end
    end
end

%% find the hand Length
delta_t = abs(tmn(1,5)-tmn(2,5))/2;
delta_t2 = abs(tmn(1,6)-tmn(2,6))/2;
delta_t3 = abs(tmn(1,7)-tmn(2,7))/2;
delta_t4 = abs(tmn(1,8)-tmn(2,8))/2;

S_all = 0;
t_all = 0;
for i = [1,2,3,5,6,7,9,10,11,13,14,15]
    if tmn(1,i) ~= 0 && tmn(1,i+1) ~= 0 && tmn(1,i) < tmn(1,i+1)
        S_all = S_all + 2 * 0.8;
        t_all = t_all + tmn(1,i+1) - tmn(1,i);
    end
end
length1 = S_all/t_all * delta_t
for i = [2,3,4,6,7,8,10,11,12,14,15,16]
    if tmn(2,i) ~= 0 && tmn(2,i-1) ~= 0 && tmn(2,i) < tmn(2,i-1)
        S_all = S_all + 2 * 0.8;
        t_all = t_all + tmn(2,i-1) - tmn(2,i);
    end
end
Length2 = S_all/t_all * delta_t
close all;
Length3 = S_all/t_all * delta_t2 + 2
Length4 = S_all/t_all * delta_t3 + 4
Length5 = S_all/t_all * delta_t4 + 6
% 
Length_ave = (Length2 + Length3 + Length4 + Length5)/4
