function S = sirenFunc(A, O, F)
%Outputs the boolean operations to activate the siren S
%F is fire, O is oxygen, A is if astronauts are present

S = F || (A && O);

end

