using Unitful, LinearAlgebra

S = [0.178*exp(im * deg2rad(90)) 0.6*exp(im*deg2rad(45)) 0.4*exp(im*deg2rad(45)) 0; 0.6*exp(im*deg2rad(45)) 0 0 0.3*exp(im*deg2rad(-45)); 0.4*exp(im*deg2rad(45)) 0 0 0.5*exp(im*deg2rad(-45)); 0 0.3*exp(im*deg2rad(-45)) 0.5*exp(im*deg2rad(-45)) 0]
round.(transpose(S) * conj.(S); digits=5)
transpose(S) == S

# Return Loss
20 * log10(abs(S[1,1]))

# Insertion Loss
20 * log10(abs(S[2,4]))
rad2deg(angle(S[2,4]))

Γin_13 = S[1,1] + S[1,3] * -1 * S[3,1] / (1 - S[3, 3] * -1)
printComplex(Γin_13)
