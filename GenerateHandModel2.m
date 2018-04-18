%% GenerateHandModel.m
%  Instructions
%  ------------
% 
%  Function in this file generate the hand model of a particular human.
function [forelimb, coordThumb, coordIndex, coordMiddle, coordRing, coordSmall ] = GenerateHandModel2( handBreadth, handLength, wristCoordinate )
%% Transformation matrix for each finger
[ fingerLen ] = FineHandParameterCalibration( handBreadth, handLength );

% wristCoordX = -3 + (3 - (-3)) * rand;
% wristCoordY = -3 + (3 - (-3)) * rand;
% wristCoordZ = 0 + (12 - 0) * rand;
% wristCoord = [ wristCoordX, wristCoordY, wristCoordZ, 1 ];
forelimb(1, :) = wristCoordinate + [0, -6, 0, 1];
forelimb(2, :) = wristCoordinate + [0, 0, 0, 1];

wristCoord = [0, 0, 0, 1];

%% Wrist limitation E/F = (70, -75), A/D = (20,-35)
% here assume wristEF, wristAD = 0

%% From wrist to each base coordinate of finger: l01, l02, l03, l04, l05 
l = [0.118 * handLength, fingerLen(2, 1), fingerLen(3, 1), 0, 0];
gamma = [40 / 180 * pi, 7 / 180 * pi, 13 / 180 * pi, 14 / 180 * pi, 25 / 180 * pi];

H01 = [cos(gamma(1)), -sin(gamma(1)), 0, -l(1) * sin(gamma(1));
    sin(gamma(1)), cos(gamma(1)), 0, l(1) * cos(gamma(1));
    0, 0, 1, 0;
    0, 0, 0, 1];

H02 = [cos(gamma(2)), sin(gamma(2)), 0, -l(2) * sin(gamma(2));
    sin(gamma(2)), cos(gamma(2)), 0, l(2) * cos(gamma(2));
    0, 0, 1, 0;
    0, 0, 0, 1];

H03 = [cos(gamma(3)), sin(gamma(3)), 0, 0;
    -sin(gamma(3)), cos(gamma(3)), 0, l(3);
    0, 0, 1, 0;
    0, 0, 0, 1];

H04 = [cos(gamma(4)), sin(gamma(4)), 0, l(4) * sin(gamma(4));
    -sin(gamma(4)), cos(gamma(4)), 0, l(4) * cos(gamma(4));
    0, 0, 1, 0;
    0, 0, 0, 1];

H05 = [cos(gamma(5)), sin(gamma(5)), 0, l(5) * sin(gamma(5));
    -sin(gamma(5)), cos(gamma(5)), 0, l(5) * cos(gamma(5));
    0, 0, 1, 0;
    0, 0, 0, 1];

%%
% Notice: should take into consideration: wristCoordinate -> finger start
% transmittion PP140 stima
% The L_{0i} should take into consideration, together with g_i.

% syms q1 q2 q3 q4 q5; % Thumb q1 A(0,-60), q2 E(25,-35), q3 A(0,-60), q4 e(10,-55), q5 E(15,-80)
% syms q6 q7 q8 q9; % Index q6 A(13,-42) q7 E(0,-80) q8 E(0,-100) q9 E(10,-90) 
% syms q10 q11 q12 q13; % Middle q10 A(8,-35) q11 E(0,-80) q12 E(0,-100) q13 E(10,-90) 
% syms q14 q15 q16 q17 q18 q19; % Ring q14, q15 unknown, q16 A(14,-20) q17 E(0,-80) q18 E(0,-100) q19 E(20,-90) 
% syms q20 q21 q22 q23 q24 q25; % Small q20, q21 unknown, q22 A(19,-33) q23 E(0,-80) q24 E(0,-100) q25 E(30,-90) 

% D-H parameters for fingers. 
% 1-5 Thumb 6-9 Index 10-13 Middle 14-19 Ring 20-25 Small
q = zeros(1,25);
theta = zeros(1, 25);
d = zeros(1, 25);
a = zeros(1, 25);
alpha = zeros(1, 25);

theta = [q(1) + pi / 2, q(2), q(3), q(4), q(5), ...
    q(6) + pi / 2, q(7), q(8), q(9), ...
    q(10) + pi / 2, q(11), q(12), q(13), ...
    q(14) + pi / 2, q(15), q(16), q(17), q(18), q(19), ...
    q(20) + pi / 2, q(21), q(22), q(23), q(24), q(25) ]; 

a = [0, fingerLen(1, 1), 0, fingerLen(1, 2), fingerLen(1, 3), ...
    0, fingerLen(2, 2), fingerLen(2, 3), fingerLen(2, 4), ...
    0, fingerLen(3, 2), fingerLen(3, 3), fingerLen(3, 4), ...
    0, fingerLen(4, 1), 0, fingerLen(4, 2), fingerLen(4, 3), fingerLen(4, 4), ...
    0, fingerLen(5, 1), 0, fingerLen(5, 2), fingerLen(5, 3), fingerLen(5, 4)];

alpha = [ - pi / 2, pi / 2, - pi / 2, pi / 2, - pi / 2, ...
    - pi / 2, 0, 0, 0, ...
    - pi / 2, 0, 0, 0, ...
    - pi / 2, pi / 2, - pi / 2, 0, 0, 0, ...
    - pi / 2, pi / 2, - pi / 2, 0, 0, 0];

%gesture 10: pair one 1
%gesture 11: pair one 2
%gesture 12: pair two 1
%gesture 13: pair two 2
gesture = 14;

theta = theta + get_Trotator(gesture);
alpha = alpha + get_Arotator(gesture);

%% Read in corresponding finger property
thumbOrigin = H01 * [0 0 0 1]';
thumbOrigin = thumbOrigin';
coordThumb = [wristCoord; thumbOrigin];

curTransMatrix = H01;
for i = 1 : 5
    curTransMatrix = curTransMatrix * TransMatrix(i, theta, d, a, alpha);
    newOrigin = curTransMatrix * [0 0 0 1]';
    newOrigin = newOrigin';
    coordThumb = [coordThumb; newOrigin];
end

indexOrigin = H02 * [0 0 0 1]';
indexOrigin = indexOrigin';
coordIndex = [wristCoord; indexOrigin];

curTransMatrix = H02;
for i = 6 : 9
    curTransMatrix = curTransMatrix * TransMatrix(i, theta, d, a, alpha);
    
    newOrigin = curTransMatrix * [0 0 0 1]';
    newOrigin = newOrigin';
    coordIndex = [coordIndex; newOrigin];
end

middleOrigin = H03 * [0 0 0 1]';
middleOrigin = middleOrigin';
coordMiddle = [wristCoord; middleOrigin];

curTransMatrix = H03;
for i = 10 : 13
    curTransMatrix = curTransMatrix * TransMatrix(i, theta, d, a, alpha);
    
    newOrigin = curTransMatrix * [0 0 0 1]';
    newOrigin = newOrigin';
    coordMiddle = [coordMiddle; newOrigin];
end

ringOrigin = H04 * [0 0 0 1]';
ringOrigin = ringOrigin';
coordRing = [wristCoord; ringOrigin];

curTransMatrix = H04;
for i = 14 : 19
    curTransMatrix = curTransMatrix * TransMatrix(i, theta, d, a, alpha);
    
    newOrigin = curTransMatrix * [0 0 0 1]';
    newOrigin = newOrigin';
    coordRing = [coordRing; newOrigin];
end

smallOrigin = H05 * [0 0 0 1]';
smallOrigin = smallOrigin';
coordSmall = [wristCoord; smallOrigin];

curTransMatrix = H05;
for i = 20 : 25
    curTransMatrix = curTransMatrix * TransMatrix(i, theta, d, a, alpha);
    
    newOrigin = curTransMatrix * [0 0 0 1]';
    newOrigin = newOrigin';
    coordSmall = [coordSmall; newOrigin];
end

%% Change current coordinate with wrist shifting
% Eliminate impossible candidates

for i = 1 : length(coordThumb)
    coordThumb(i, :) = coordThumb(i, :) + wristCoordinate;
end

for i = 1 : length(coordIndex)
    coordIndex(i, :) = coordIndex(i, :) + wristCoordinate;
end

for i = 1 : length(coordMiddle)
    coordMiddle(i, :) = coordMiddle(i, :) + wristCoordinate;
end

for i = 1 : length(coordRing)
    coordRing(i, :) = coordRing(i, :) + wristCoordinate;
end

for i = 1 : length(coordSmall)
    coordSmall(i, :) = coordSmall(i, :) + wristCoordinate;
end 

flag = zeros(1, length(coordThumb));
for i = 1 : length(coordThumb) - 1
    if issame(coordThumb(i, :), coordThumb(i + 1, :))
        flag(i) = 1;
    end
end
    
coordThumb = coordThumb(flag == 0, :);

flag = zeros(1, length(coordIndex));
for i = 1 : length(coordIndex) - 1
    if issame(coordIndex(i, :), coordIndex(i + 1, :))
        flag(i) = 1;
    end
end

coordIndex = coordIndex(flag == 0, :);

flag = zeros(1, length(coordMiddle));
for i = 1 : length(coordMiddle) - 1
    if issame(coordMiddle(i, :), coordMiddle(i + 1, :))
        flag(i) = 1;
    end
end

coordMiddle = coordMiddle(flag == 0, :);

flag = zeros(1, length(coordRing));
for i = 1 : length(coordRing) - 1
    if issame(coordRing(i, :), coordRing(i + 1, :))
        flag(i) = 1;
    end
end

coordRing = coordRing(flag == 0, :);

flag = zeros(1, length(coordSmall));
for i = 1 : length(coordSmall) - 1
    if issame(coordSmall(i, :), coordSmall(i + 1, :))
        flag(i) = 1;
    end
end

coordSmall = coordSmall(flag == 0, :);

% for i = 1 : length(coordThumb)
%     coordThumb(i, :) = coordThumb(i, :) + wristCoordinate;
% end
% 
% for i = 1 : length(coordIndex)
%     coordIndex(i, :) = coordIndex(i, :) + wristCoordinate;
% end
% 
% for i = 1 : length(coordMiddle)
%     coordMiddle(i, :) = coordMiddle(i, :) + wristCoordinate;
% end
% 
% for i = 1 : length(coordRing)
%     coordRing(i, :) = coordRing(i, :) + wristCoordinate;
% end
% 
% for i = 1 : length(coordSmall)
%     coordSmall(i, :) = coordSmall(i, :) + wristCoordinate;
% end    

PlotHand2
end

function transMatrix = TransMatrix(i, theta, d, a, alpha)
    transMatrix = [cos(theta(i)), - cos(alpha(i)) * sin(theta(i)), sin(alpha(i)) * sin(theta(i)), a(i) * cos(theta(i));
        sin(theta(i)), cos(alpha(i)) * cos(theta(i)), - sin(alpha(i)) * cos(theta(i)), a(i) * sin(theta(i));
        0, sin(alpha(i)), cos(alpha(i)), d(i);
        0, 0, 0, 1];
end

function theta_rotator = get_Trotator(i)
    switch(i)
        case 0
            theta_rotator = [ 0, pi/3, -pi/4, 0, -pi/3, ...
                  0, pi/2.2, pi/2, pi/4, ...
                  0, pi/2.3, pi/2, pi/4, ...
                  0, 0, 0, pi/2.3, pi/2, pi/4, ...
                  0, 0, 0, pi/2.2, pi/2, pi/4];
        case 1
            theta_rotator = [0, pi/3, -pi/4, 0, -pi/3, ...
                  0, 0, 0, 0, ...
                  0, pi/2.3, pi/2, pi/4, ...
                  0, 0, 0, pi/2.3, pi/2, pi/4, ...
                  0, 0, 0, pi/2.2, pi/2, pi/4];
        case 2
            theta_rotator = [0, pi/3, -pi/4, 0, -pi/3, ...
                  0, pi/12, 0, 0, ...
                  0, pi/16, 0, 0, ...
                  0, 0, 0, pi/2.3, pi/2, pi/4, ...
                  0, 0, 0, pi/2.2, pi/2, pi/4];
        case 3
            theta_rotator = [0, pi/2.5, -pi/4, 0, -pi/2, ...
                  0, pi/12, 0, 0, ...
                  0, pi/12, 0, 0, ...
                  0, 0, 0, pi/12, 0, 0, ...
                  0, 0, 0, pi/2.2, pi/2, pi/6];
        case 4
            theta_rotator = [0, pi/6, -pi/1.5, 0, -pi/6, ...
                  0, 0, 0, 0, ...
                  0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0];
        case 6
            theta_rotator = [ 0, 0, 0, 0, 0, ...
                  0, pi/2.2, pi/1.5, pi/16, ...
                  0, pi/2.3, pi/1.5, pi/16, ...
                  0, 0, 0, pi/2.3, pi/1.5, pi/16, ...
                  0, 0, 0, pi/6, 0, 0];
        case 8
            theta_rotator = [ 0, 0, 0, 0, 0, ...
                  0, pi/6, 0, 0, ...
                  0, pi/2.3, pi/2, pi/4, ...
                  0, 0, 0, pi/2.3, pi/2, pi/4, ...
                  0, 0, 0, pi/2.2, pi/2, pi/4];
        case 9
            theta_rotator = [ 0, pi/3, -pi/4, 0, -pi/3, ...
                0, pi/2.2, pi/2, pi/12, ...
                0, pi/6, 0, 0, ...
                0, 0, 0, pi/8, 0, 0, ...
                0, 0, 0, pi/12, 0, 0];
        case 10
            theta_rotator = [0, 0, 0, pi/4, 0, ...
                  0, 0, 0, 0, ...
                  0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0];
        case 11
            theta_rotator = [0, 0, 0, pi/3, 0, ...
                  0, pi/8, 0, 0, ...
                  0, pi/8, 0, 0, ...
                  0, 0, 0, pi/8, 0, 0, ...
                  0, 0, 0, pi/8, 0, 0];
        case 12
            theta_rotator = [ 0, pi/4, -pi/2, 0, 0, ...
                  0, 0, 0, 0, ...
                  0, pi/4, pi/1.2, pi/8, ...
                  0, 0, 0, pi/4, pi/1.2, pi/8, ...
                  0, 0, 0, 0, 0, 0];
        case 13
            theta_rotator = [ 0, pi/4, -pi/2, 0, 0, ...
                0, 0, 0, 0, ...
                0, 0, 0, 0, ...
                0, 0, 0, 0, 0, 0, ...
                0, 0, 0, 0, 0, 0];
        case 14
            theta_rotator = [ 0, 0, 0, pi/18, 0, ...
                0, 0, 0, 0, ...
                0, 0, 0, 0, ...
                0, 0, 0, 0, 0, 0, ...
                0, 0, 0, 0, 0, 0];
            
        otherwise
            theta_rotator = [0, 0, 0, 0, 0, ...
                  0, 0, 0, 0, ...
                  0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0];
    end
end

function alpha_rotator = get_Arotator(i)
    switch(i)
        case 2
            alpha_rotator = [0, 0, 0, 0, 0, ...
                  pi/2, 0, 0, 0, ...
                  pi/2, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0];
        case 10
            alpha_rotator = [0, 0, -pi/2, 0, 0, ...
                  0, 0, 0, 0, ...
                  0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0];
        case 11
            alpha_rotator = [0, 0, -pi/4, 0, 0, ...
                0, 0, 0, 0, ...
                0, 0, 0, 0, ...
                0, 0, 0, 0, 0, 0, ...
                0, 0, 0, 0, 0, 0];
        case 14
            alpha_rotator = [0, 0, -pi/2, 0, 0, ...
                  0, 0, 0, 0, ...
                  0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0];
        otherwise
            alpha_rotator = [0, 0, 0, 0, 0, ...
                  0, 0, 0, 0, ...
                  0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0, ...
                  0, 0, 0, 0, 0, 0];
    end
end