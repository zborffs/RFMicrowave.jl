using Unitful

# Given
Z0 = 50u"Ω"
up = 3e8u"m/s"
ZL = (50 + 100im)u"Ω"
f = 5u"GHz"

# Find
# (a.) λ = ?, β = ?
ω = uconvert(u"rad/s", 2 * π * f)
β = uconvert(u"m^-1", ω / up)
λ = uconvert(u"m", 2 * π / β)

# (b.) VSWR = ?
Γ = (ZL - Z0) / (ZL + Z0)
Γ_abs = abs(Γ)
VSWR = (1 + Γ_abs) / (1 - Γ_abs)

# (c.) 0.5λ = ?, 0.75λ = ?
zL = ZL / Z0
l = λ / 2
Zin = Z0 * (zL + tan(β * l)im) / (1 + zL * tan(β * l)im)
Γ = (Zin - Z0) / (Zin + Z0)
Γ_abs = abs(Γ)
Γ_phase = uconvert(u"°", angle(Γ))
l = 3 * λ / 4
Zin = Z0 * (zL + tan(β * l)im) / (1 + zL * tan(β * l)im)
Γ = (Zin - Z0) / (Zin + Z0)
Γ_abs = abs(Γ)
Γ_phase = uconvert(u"°", angle(Γ))

# (d.) Γ = ? @ 0.5λ, Γ = ? @ 0.75λ
Zin = Z0 * (zL + tan(β * l)im) / (1 + zL * tan(β * l)im)
Γ = (Zin - Z0) / (Zin + Z0)
Γ_abs = abs(Γ)
Γ_phase = uconvert(u"°", angle(Γ))

# (e.) V+=4 [V], Pi = ? and Pd = ?
V = 4u"V"
Piav = uconvert(u"W", V^2 / (2 * Z0))
Prav = uconvert(u"W", -Γ_abs^2 * V^2 / 2 / Z0)
Pdelivered = Piav + Prav
