using Unitful, LinearAlgebra, RFMicrowave

# Given
# - Coaxial
a = 3u"mm"
b = 7u"mm"
ϵr = 4
f0 = 3u"GHz"

# Find β (propogation constant)
Lprime = uconvert(u"H/m", μ_0 / (2 * π) * log(b / a))
Cprime = uconvert(u"F/m", 2 * π * ϵr * ε_0 / log(b / a))
Rprime = 0u"Ω/m"
Gprime = 0u"1/(Ω*m)"

γ = sqrt((Rprime + im * 2 * π * f0 * Lprime) * (Gprime + im * 2 * π * f0 * Cprime))
β = imag(γ)
𝑣 = uconvert(u"m/s", 2 * π * f0 / β)
