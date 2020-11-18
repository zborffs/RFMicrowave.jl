using RFMicrowave, Unitful

d = 2u"cm"
ϵr = 1
σ_Al = 	3.5e7u"S/m"
a = 22.86u"mm"
b = 10.16u"mm"
l = [1, 2]

f0 = c_0 / (2 * π * sqrt(ϵr)) * sqrt.((l.^2 * π^2 / d^2) .+ (π / a)^2)
f0 = uconvert.(u"GHz", f0)

η = waveguide_intrinsic_impedance(ϵr)
k = waveguide_k.(f0, ϵr)
Rs = μstrip_Rs.(f0, μ_0, σ_Al)
Q = waveguide_q_factor_c.(k, a, b, d, Rs, η, l)
Q = uconvert.(u"NoUnits", Q)
