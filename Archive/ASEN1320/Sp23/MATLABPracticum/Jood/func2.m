function dydt = func2(t,y,a,b)
a=2;
b=0.001;
dydt = (a*y)-(b*y^2)-t 
end