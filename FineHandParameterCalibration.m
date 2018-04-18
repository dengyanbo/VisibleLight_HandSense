%% FineHandParameterCalibration
%  Instructions
%  ------------
% 
%  Function in this file processes hand breadth and length, to get the size
%  of user's finger length (each segment).

function [ fingerLen, radius_of_finger ] = FineHandParameterCalibration( handBreadth, handLength )
radius_of_finger = 0.25;
% fingerLen = {{Thumb}, {Index}, {Middle}, {Ring}, {Small}}.
Thumb = zeros(1, 4); % 1, 2, 4, does not have bone segment 3
Index = zeros(1, 4);
Middle = zeros(1, 4);
Ring = zeros(1, 4);
Small = zeros(1, 4);

Thumb(1) = 0.251 * handLength;
Thumb(2) = 0.196 * handLength;
Thumb(3) = 0.158 * handLength;
Thumb(4) = inf; % Empty here

Index(1) = sqrt( (0.374 * handLength) ^ 2 + (0.126 * handBreadth) ^ 2);
Index(2) = 0.265 * handLength;
Index(3) = 0.143 * handLength;
Index(4) = 0.097 * handLength;

Middle(1) = 0.373 * handLength;
Middle(2) = 0.277 * handLength;
Middle(3) = 0.170 * handLength;
Middle(4) = 0.108 * handLength;

Ring(1) = sqrt( (0.336 * handLength) ^ 2 + (0.077 * handBreadth) ^ 2);
Ring(2) = 0.259 * handLength;
Ring(3) = 0.165 * handLength;
Ring(4) = 0.107 * handLength;

Small(1) = sqrt( (0.295 * handLength) ^ 2 + (0.179 * handBreadth) ^ 2);
Small(2) = 0.206 * handLength;
Small(3) = 0.117 * handLength;
Small(4) = 0.093 * handLength;

fingerLen = [Thumb; Index; Middle; Ring; Small];
% disp('Thumb: ');
% disp(Thumb(2)+Thumb(3));
% 
% disp('Index: ');
% disp(Index(2)+Index(3)+Index(4));
% 
% disp('Middle: ');
% disp(Middle(2)+Middle(3)+Middle(4));
% 
% disp('Ring: ');
% disp(Ring(2)+Ring(3)+Ring(4));
% 
% disp('Small: ');
% disp(Small(2)+Small(3)+Small(4));
end

