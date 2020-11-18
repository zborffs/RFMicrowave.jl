using Unitful, UnitfulAstro, RFMicrowave
μc = μ_0
μ = μ_0
ϵ = ε_0




f0 = 5u"GHz"
σCu = 5.813e7u"S/m"
ϵr = 2.08
a = 1u"mm"
b = 4u"mm"
ω0 = uconvert(u"rad/s", 2π * f0)

Rs = surface_resistance(f0, μc, σCu)
Rprime = coaxial_Rprime(Rs, a, b)
Lprime = coaxial_Lprime(μ, a, b)
Gprime = coaxial_Gprime(σCu, a, b)
Cprime = coaxial_Cprime(ϵ, a, b)
γ = propagation_const(Rprime, Lprime, Gprime, Cprime, ω0)
Z0 = char_imp(Rprime, Lprime, Gprime, Cprime, ω0)

@assert isapprox(uconvert(u"Ω", Rs), 1.84e-2u"Ω"; atol=0.01u"Ω")
α = real(γ)
β = imag(γ)

Qair = β / (2 * α)
