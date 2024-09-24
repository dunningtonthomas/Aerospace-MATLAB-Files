function pulse_input = ControlSurfacePulse(t, t_pulse, pulse_vec)
% This function provides a pulse input for the desired time based on the
% pulse_vec input
np = length(t_pulse);

if np == 1
    if t < t_pulse
        pulse_input = pulse_vec;
    else
        pulse_input = zeros(4,1);
    end
elseif np == 2
    if t < t_pulse
        pulse_input = pulse_vec;
    elseif t < 2*t_pulse
        pulse_input = -pulse_vec;
    else
        pulse_input = zeros(4,1);
    end
end

end

