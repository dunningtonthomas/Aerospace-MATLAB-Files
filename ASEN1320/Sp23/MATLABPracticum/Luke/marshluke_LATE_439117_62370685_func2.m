function dydt = func2(t,y)
    a= 11.2;
    b=1.2;
    dydt= a*(exp(-t)*sin(t) - y) + b * cos(t);
end