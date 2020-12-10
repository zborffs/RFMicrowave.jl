using Unitful, LinearAlgebra
S = [0.2*exp(im * deg2rad(50)) 0 0 0.4*exp(im*deg2rad(-45));
	0 0.6*exp(im*deg2rad(45)) 0.7*exp(im*deg2rad(-45)) 0;
	0 0.7*exp(im*deg2rad(-45)) 0.6*exp(im*deg2rad(45)) 0;
	0.4*exp(im*deg2rad(-45)) 0 0 0.5*exp(im*deg2rad(45))]

round.(transpose(S) * conj.(S); digits=5)

S == transpose(S)

Spp = [S[1,1] S[1,2]; S[2,1] S[2,2]]
Scc = [S[3,3] S[3,4]; S[4,3] S[4,4]]
Spc = [S[1,3] S[1,4]; S[2,3] S[2,4]]
Scp = [S[3,1] S[3,2]; S[4,1] S[4,2]]

Γ = [0 exp(im*deg2rad(45)); exp(im*deg2rad(45)) 0]

Stot = Spp + Spc * inv(Γ - Scc) * Scp
