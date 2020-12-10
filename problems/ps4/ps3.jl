using Unitful, RFMicrowave

# Given
a = 0.622u"inch"
b = 0.311u"inch"

fc = uconvert(u"MHz", c_0 / (2 * a))
f = [8.0 15.0]u"GHz"
ω = 2 * π * f

β = sqrt.(complex.(ω.^2 * μ_0 * ε_0 .- (π / a)^2))

up = uconvert(u"m/s", 2 * π * f[2] / β[2])

η = sqrt(μ_0 / ε_0)
k = 2 * π * f[2] * sqrt(ε_0 * μ_0)

Z0 = uconvert(u"Ω", k * η / β[2])
