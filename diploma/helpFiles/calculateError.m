function [E,Edot,Eddot] = calculateError(Ep,Ec)
%CALCULATEERROR Summary of this function goes here
%   Detailed explanation goes here
Dt=0.003;
Edot = (Ec - Ep)/Dt;
Eddot = Ec;
end

