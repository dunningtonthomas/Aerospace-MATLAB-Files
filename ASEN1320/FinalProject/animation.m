syms t x
fanimator(@fplot,cos(x)+t,sin(x)+1,[-pi pi])
axis equal

writeAnimation('wheel.avi')