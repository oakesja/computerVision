function [ side ] = ASA( angle1, side,  angle2 )
angle3 = pi - angle1 - angle2;
side = (side * sin(angle2)) / angle3;
end

