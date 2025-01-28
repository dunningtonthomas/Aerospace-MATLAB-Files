function dydt = func2(t, y, a, b )


yt = y*t;
by = b*y;

dydt = a*sin(yt)+by;



end

