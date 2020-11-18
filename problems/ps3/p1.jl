function islossless(S)
	nrow, ncol = size(S)
	@assert nrow == ncol # make sure square
	return S * transpose(S') == I(nrow)
end

function isreciprocal(S)
	return issymmetric(S)
end

function returnloss(Γ)
	-20log10(Γ)
end

function insertionloss(S_mn)
	-20log10(S_mn)
end


S = [0.178exp(deg2rad(90)im) 0.6exp(deg2rad(45)im) 0.4exp(deg2rad(45)im) 0;
       0.6exp(deg2rad(45)im) 0 0 0.3exp(deg2rad(-45)im);
       0.4exp(deg2rad(45)im) 0 0 0.5exp(deg2rad(-45)im);
       0 0.3exp(deg2rad(-45)im) 0.5exp(deg2rad(-45)im) 0]
# (c.)
# Γ = S11
Γ = abs(S[1])
RL_1 = returnloss(Γ)

# (d.) Insertion loss and phase delay between ports 2-4 when everything is terminated with matched loads
nrow, ncol = size(S)
S42 = S[(2-1) * nrow + 4]
IR_34 = insertionloss(abs(S42))
phase_delay = -rad2deg(angle(S42))
@assert isapprox(S42, 0.3exp(deg2rad(-45)im); atol=1e-5)
