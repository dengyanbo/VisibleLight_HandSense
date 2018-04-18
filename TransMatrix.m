function transMatrix = TransMatrix(i, theta, d, a, alpha)
    transMatrix = [cos(theta(i)), - cos(alpha(i)) * sin(theta(i)), sin(alpha(i)) * sin(theta(i)), a(i) * cos(theta(i));
        sin(theta(i)), cos(alpha(i)) * cos(theta(i)), - sin(alpha(i)) * cos(theta(i)), a(i) * sin(theta(i));
        0, sin(alpha(i)), cos(alpha(i)), d(i);
        0, 0, 0, 1];
end