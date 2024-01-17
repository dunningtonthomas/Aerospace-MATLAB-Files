function[ beta ] = BTMeq( theta,M1 )

% define contstants and equations
g=1.4;
btmequ=@(b) tan(theta)-(2*cot(b).*(M1^2.*(sin(b)).^2-1)./...
    (M1.^2.*(g+cos(2.*b))+2));

% create a range of theta values between the wedge angle and 90, use this
% to find the first point where btmequ is less than zero
t = theta:.1:pi/2;
I = find(btmequ(t) < 0,1);
theta_end = t(I);

% use the window created by theta end to solve for zero location
beta=fzero(btmequ,[theta theta_end]);

end
