function spacecraft = initSatellite(X0, A, m, FOV, Nsc, t0, tf, stepSize, facets, vertices, name)
%This function is used to initialize multiple satellites
    %Calling Ode45 for 1 minute timesteps
        [Xout, spacecraft.OEout, t] = propagate_spacecraft(X0, t0, tf, A, m, stepSize);

        dist = vecnorm(Xout(1:3,:), 2, 1);
        spacecraft.rp = min(dist);
        spacecraft.ra = max(dist);

    %[Xout, OEout, t] = prop_test(X0, t0, tf, A, m);
        Xout_fixed = zeros(size(Xout));
        Xsun = zeros(3, size(Xout,2));
        
    %Bennu's state in time
        const = getConst();
        bennu_angle(1,1,:) = const.bennu_ang_rot.*t;
        rotMat = [cosd(bennu_angle), sind(bennu_angle), 0*ones(1,1,length(t)); -sind(bennu_angle), cosd(bennu_angle), 0*ones(1,1,length(t)); 0*ones(1,1,length(t)), 0*ones(1,1,length(t)), 1*ones(1,1,length(t))];
        
    %Accounting for Bennu's Rotation
        for ti = 1:length(t)
            Xout_fixed(1:3,ti) = rotMat(:,:,ti)*Xout(1:3,ti);
            Xout_fixed(4:6,ti) = rotMat(:,:,ti)*Xout(4:6,ti);
            Xsun(:,ti) = rotMat(:,:,ti)*[-1;0;0];
        end
    
    %Determining viewable facets
        R = Xout_fixed(1:3, :);
        [spacecraft.observed, spacecraft.elevation_angles, spacecraft.camera_angles, spacecraft.rel_dist, spacecraft.phaseAngleMap] = check_view(R, facets, vertices, FOV, Xsun);
        
        spacecraft.Nvij = sum(spacecraft.observed, 2);
        spacecraft.Xout = Xout;
        spacecraft.Xout_fixed = Xout_fixed;
        spacecraft.t = t;
        spacecraft.name = name;
        spacecraft.GR = (FOV/(2048 - (1408/9)*(Nsc-1)))*(spacecraft.rel_dist);
end