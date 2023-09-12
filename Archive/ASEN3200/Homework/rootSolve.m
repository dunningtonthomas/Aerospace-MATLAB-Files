function xZero = rootSolve(func, xLow, xUpp, tol)
% XZERO = ROOTSOLVE(FUNC, XLOW, XUPP, TOL)
%
% FUNCTION: This function uses Ridder's Method to return a root, xZero,
%     of func on the interval [xLow,xUpp]
%
% INPUTS:
%   func = a function for a SISO function: y = f(x)
%   xLow = the lower search bound
%   xUpp = the upper search bound
%   tol = return xZero if abs(func(xZero)) < tol
%
% OUTPUTS:
%   xZero = the root of the function on the domain [xLow, xUpp]
%
% NOTES:
%   1) The function must be smooth
%   2) sign(f(xLow)) ~= sign(f(xUpp))
%   3) This function will return a root if one exists, and the function is
%   not crazy. If there are multiple roots, it will return the first one
%   that it finds.

if nargin == 0
    rootSolve_test();
    return;
end

maxIter = 50;
if nargin < 4
    tol = 100*eps;
end

fLow = feval(func,xLow);
fUpp = feval(func,xUpp);
xZero = [];

if (fLow > 0.0 && fUpp < 0.0) || (fLow < 0.0 && fUpp > 0.0)
    for i=1:maxIter
        xMid = 0.5*(xLow+xUpp);
        fMid = feval(func,xMid);
        s = sqrt(fMid*fMid - fLow*fUpp);
        if s==0.0, break; end
        xTmp = (xMid-xLow)*fMid/s;
        if fLow >= fUpp
            xNew = xMid + xTmp;
        else
            xNew = xMid - xTmp;
        end
        xZero = xNew;
        fNew = feval(func,xZero);
        if abs(fNew)<tol, break; end
        
        %Update
        if sign(fMid) ~= sign(fNew)
            xLow = xMid;
            fLow = fMid;
            xUpp = xZero;
            fUpp = fNew;
        elseif sign(fLow) ~= sign(fNew)
            xUpp = xZero;
            fUpp = fNew;
        elseif sign(fUpp) ~= sign(fNew)
            xLow = xZero;
            fLow = fNew;
        else
            error('Something bad happened in riddersMethod!');
        end
        
    end
else
    if abs(fLow) < tol
        xZero = xLow;
    elseif abs(fUpp) < tol
        xZero = xUpp;
    else
        error('Root must be bracketed in Ridder''s Method!');
    end
end

end

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

function rootSolve_test()

nRoot = 5;
rootVec = zeros(1,nRoot);
rootVec(1) = rand(1);
for i=2:nRoot
    rootVec(i) = rootVec(i-1) + 0.5 + rand(1);
end

P = poly(rootVec);
userFun = @(t)( polyval(P,t) );

tLow = rootVec(2) + 0.001;
tSoln = rootVec(3);
tUpp = rootVec(4) - 0.001;
tRoot = rootSolve(userFun, tLow, tUpp);

tSoln     %#ok<NOPRT>
tRoot    %#ok<NOPRT>
tErr = tSoln - tRoot    %#ok<NASGU,NOPRT>

end

