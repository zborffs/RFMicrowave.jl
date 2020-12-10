using Unitful, RFMicrowave, Roots

# Given
f0 = 2u"GHz"
Z0 = 50u"Ω"
W = 1.2446u"mm"
H = 1.27u"mm"
ϵr = 9.8

# Find width so that Wilkinson Z0 is sqrt(2) * Z0
sqrt2Z0 = sqrt(2) * Z0
ϵeff, Z02, β, up = μstripValues(W, H, ϵr, f0)
findW(w) = sqrt2Z0 - μstripValues(W + w, H, ϵr, f0)[2]

Δw = find_zero(findW, 0.0u"mm")
w = W + Δw
ϵeff3, Z03, β3, up3 = μstripValues(w, H, ϵr, f0)
λ3 = 2 * π / β3
l = uconvert(u"mm",λ3 / 4)

P1 = (10^((36-30)/10))u"W"

RL = 24u"Ω"
Γ = (RL - Z02) / (RL + Z02)
(P1 / 2 * abs(Γ)^2 + P1 / 2 * abs(Γ)^2)

Pabs = (P1/2) * (1 - abs(Γ)^2)
