function [ v ] = PMeq_findv( M )

g=1.4;
v=sqrt((g+1)/(g-1))*atan(sqrt((g-1)/(g+1)*(M^2-1)))-...
    atan(sqrt(M^2-1));

end

