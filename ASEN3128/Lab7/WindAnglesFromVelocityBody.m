function [wind_angles] = WindAnglesFromVelocityBody(velocity_body)

V = norm(velocity_body);

if (V==0)
    alpha = 0;
    beta = 0;
    V = 21;
else
    alpha = atan2(velocity_body(3,1),velocity_body(1,1));
    beta = asin(velocity_body(2,1)/V);
end

wind_angles = [V; beta; alpha];