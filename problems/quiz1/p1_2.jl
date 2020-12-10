using Unitful, RFMicrowave

# Given
Z0 = 50u"Ω"
up = (3e8)u"m/s"
Zl = (50 + im * 100)u"Ω"
f0 = 5u"GHz"

# Find
λ = uconvert(u"m", up / f0)
β = uconvert(u"rad/m", 2 * π / λ)
ΓL = (Zl - Z0) / (Zl + Z0)
printComplex(ΓL)
VSWR = (1 + abs(ΓL)) / (1 - abs(ΓL))
θ = [π π/2]
Γin = ΓL * exp.(-2 * im * θ)

V1p = 4u"V"
Piav = uconvert(u"W", V1p^2 / (2 * Z0))
Prav = uconvert(u"W", -abs(ΓL)^2 * Piav)
