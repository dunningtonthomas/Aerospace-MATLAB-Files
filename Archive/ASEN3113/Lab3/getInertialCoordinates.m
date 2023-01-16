function [Orbit_ECI,OE] = getInertialCoordinates(TLE,plot3d,plotGT)
% Copyright (c) 2020, Meg Noah
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% * Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
% 
% * Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution
% * Neither the name of  nor the names of its
%   contributors may be used to endorse or promote products derived from this
%   software without specific prior written permission.
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
% 
% Original Author: Meg Noah
% Modified By: Andrew Pearson
% Date: 01/9/2020
% Modified Date: 11/7/2021
% Code version: 1.0
%
% This function takes in a TLE and outputs the position state vector for a 
% full orbit. If plot3d and plotGT are enabled, the function will also
% plot the 3D orbit as well as the ground track of the orbit.

    mu = 3.98618e14;                                                    % [m3/s2]
    
    % Convert TLE to orbital elements
    [OE] = TLE2OrbitalElements(TLE);

    % Extract time for plotting
    [Year,Month,Day,Hour,Min,Sec] = datevec(OE.epoch);

    a_m = OE.a_km*1e3;                                                  % [m]
    e = OE.e;
    E = deg2rad(OE.M_deg);
    n = rad2deg(sqrt(mu/a_m^3));                                        % [rad/s]
    
    % Solve Newton's method solution for E
    dE = 99999;
    eps = 1e-9;
    while (abs(dE) > eps)
        dE = (E - e * sin(E) - E)/(1 - e * cos(E));
        E = E -  dE;
    end
    r_p = a_m*(cos(E) - e);                                             % [m]
    r_q = a_m*sqrt(1 - e^2)*sin(E);                                     % [m]
    
    % Setup DCM
    DCM_O = [cosd(OE.Omega_deg),sind(OE.Omega_deg),0;-sind(OE.Omega_deg),cosd(OE.Omega_deg),0;0,0,1];
    DCM_i = [1,0,0;0,cosd(OE.i_deg),sind(OE.i_deg);0,-sind(OE.i_deg),cosd(OE.i_deg)];
    DCM_o = [cosd(OE.omega_deg),sind(OE.omega_deg),0;-sind(OE.omega_deg),cosd(OE.omega_deg),0;0,0,1];
    
    % Position in parametric coords
    r_para = [r_p r_q 0]';
    
    % Convert to ECI
    r_ECI = inv(DCM_O)*inv(DCM_i)*inv(DCM_o)*r_para;
    r_LLA = eci2lla(r_ECI',datevec(datenum(Year, Month, Day, Hour, Min, Sec)),'IAU-2000/2006');
    
    Evals = 0:1:360.0;                                                  % [deg]  
    Orbit_p = a_m*(cosd(Evals)-e);                                      % [m] 
    Orbit_q = a_m*sqrt(1 - e^2)*sind(Evals);                            % [m]
    deltaT_s = ((Evals-rad2deg(E)) - e*sind(Evals-rad2deg(E)))/n;       % [s] 
    
    Orbit_ECI = zeros(numel(deltaT_s),3);
    Orbit_LLA = zeros(numel(deltaT_s),3);
    for ipt = 1:size(Orbit_ECI,1)
        r_para = [Orbit_p(ipt) Orbit_q(ipt) 0]';
        Orbit_ECI(ipt,:) = (inv(DCM_O)*inv(DCM_i)*inv(DCM_o)*r_para)'; 
        lla = eci2lla(Orbit_ECI(ipt,:),datevec(datenum(Year, Month, Day, Hour, Min, Sec+deltaT_s(ipt))),'IAU-2000/2006');
        Orbit_LLA(ipt,:) = lla;
    end

    % Plot 3D ECI Orbit
    if plot3d
        figure
        plot3(Orbit_ECI(:,1),Orbit_ECI(:,2),Orbit_ECI(:,3))
        xlabel('ECI x [m]');
        ylabel('ECI y [m]');
        zlabel('ECI z [m]');
        title('Satellite Orbit in ECI Coordinates');
        grid on
    end
    
    % Plot Ground Track
    if plotGT
        figure
        earth = imread('ear0xuu2.jpg');
        lv= size(earth,1);
        lh= size(earth,2);
        lats =  (1:lv)*180/lv - 90;
        lons =  (1:lh)*360/lh - 180;
        image(lons, -lats, earth)
        hold on;
        set(gca,'ydir','normal');
        grid on
        plot(Orbit_LLA(:,2),Orbit_LLA(:,1),'.r');
        plot(r_LLA(2),r_LLA(1),'p','MarkerFaceColor',[1 0 0.7],'MarkerEdgeColor','none','Markersize',14);
        set(gca,'XTick',-180:30:180);
        set(gca,'YTick',-90:30:90);
        set(gca,'Xcolor',0.3*ones(1,3));
        set(gca,'Ycolor',0.3*ones(1,3));
        title(['Ground Track for Epoch ' datestr(OE.epoch)])
        xlabel('Longitude (degrees)')
        ylabel('Latitude (degrees)')
        axis equal
        axis tight
        set(gca,'fontweight','bold');
    end

end