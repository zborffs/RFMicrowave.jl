using RFMicrowave, Unitful

a = 4.755u"cm"
b = 2.215u"cm"
ϵr = 2.25
tanδ = 0.0004
f0 = 5u"GHz"
l = [1, 2]
σ_Cu = 5.813e7u"S/m"

# Find d1, d2
k = uconvert(u"m^-1", waveguide_k(f0, ϵr))
d = waveguide_length10l(k, a, l)
η = waveguide_intrinsic_impedance(ϵr)
Rs = μstrip_Rs(f0, μ_0, σ_Cu)

Qc = waveguide_q_factor_c.(k, a, b, d, Rs, η, l)
Qd = waveguide_q_factor_d(tanδ)

Qtot = waveguide_q_factor_tot.(Qc, Qd)
