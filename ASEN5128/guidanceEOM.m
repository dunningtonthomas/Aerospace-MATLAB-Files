% Full guidance model EOM
function dxdt = guidanceEOM(t, x, xc, wind_inertial, params)
% Calculates the rate of change of the kinematic model 1a variables to be
% used in ode45
% Inputs:
%   t = time
%   x = state [Pn; Pe; h; hdot; chi; chi_dot; Va]
%   xc = control objectives [h_c; h_c_dot; chi_c; chi_c_dot; Va_c]
%   wind_inertial = inertial wind vector in inertial coordinates
%   params = struct with tuning constants for the model
% Outputs:
%   dxdt = rate of change of the variables of the state

% Get the full state
Pn = x(1);
Pe = x(2);
h = x(3);
h_dot = x(4);
chi = x(5);
chi_dot = x(6);
Va = x(7);

% Desired states
h_c = xc(1);
h_c_dot = xc(2);
chi_c = xc(3);
chi_c_dot = xc(4);
Va_c = xc(5);

% Calculate psi
psi = chi - asin(1/Va * wind_inertial(1:2)' * [-sin(chi); cos(chi)]);

% ROC
dpndt = Va*cos(psi) + wind_inertial(1);
dpedt = Va*sin(psi) + wind_inertial(2);
dhdt = [h_dot; -params.ah_dot * h_c_dot - params.bh_dot * h_dot + params.bh*(h_c - h)];
dchidt = [chi_dot; params.bx_dot*(chi_c_dot - chi_dot) + params.bx*(chi_c - chi)];  
dvdt = params.bva * (Va_c - Va);

% ROC of the state
dxdt = [dpndt; dpedt; dhdt; dchidt; dvdt];

end
