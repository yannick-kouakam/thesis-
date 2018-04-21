function tau = Id(q,qdot,qddot)
%FORWARDDYNAMIC Summary of this function goes here
%   Detailed explanation goes here
global lbr;
    if isempty(lbr)
        lbr = exampleHelperMwIiwa14();
    end

    tau =lbr.inverseDynamics(q,qdot,qddot);

end

