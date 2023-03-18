function [ m ] = nozzle_area( area_ratio )
% define contstants and equations
g=1.4;

area_eq=@(m) area_ratio.^2-(1./m.^2).*(2./(g+1).*...
    (1+(g-1)./2*m.^2)).^((g+1)./(g-1));

m=fzero(area_eq,[0.1 10]);

end

