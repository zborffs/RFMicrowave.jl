# Consider a microstrip resonator constructed from λ / 2 length of 50 Ohm
# open-circuited microstrip line. The substrate is Teflon (ϵr=2.08, tanδ=0.0004)
# with thickness of 0.159 cm and conductors are copper. Compute the required
# length of the line for resonance at 5 GHz and unloaded Q of the resonator.
# Ignore fringing fields at the end of the line
using Unitful, RFMicrowave
import PhysicalConstants.CODATA2014: μ_0, ε_0, c_0




f0 = 5u"GHz"
σ_Cu = 5.813e7u"S/m"
d = 0.159u"cm"
Z0 = 50u"Ω"
ϵr = 2.08
tanδ = 0.0004

A = ustrip(Z0) / 60 * sqrt((ϵr + 1) / 2) + (ϵr - 1) / (ϵr + 1) * (0.23 + 0.11 / ϵr)
B = 377* π / (2 * ustrip(Z0) * sqrt(ϵr))

# Assume W / d < 2
W_d = 8 * exp(A) / (exp(2 * A) - 2) # Not less than 2
W_d = 2 / π * (B - 1 - log(2 * B - 1) + (ϵr - 1) / (2 * ϵr) * (log(B - 1) + 0.39 - 0.61 / ϵr))
ϵe = (ϵr + 1) / 2 + (ϵr - 1) / (2 * sqrt(1 + 12 / W_d))

# Considering a microstrip a quasi-TEM line, we can determine the attenuation
# due to dielectric loss as
# k0 = ω * sqrt(μ * ϵ)
k0 = uconvert(u"rad/m", 2 * π * f0 * sqrt(μ_0 * ε_0))
αd = k0 * ϵr * (ϵe - 1) * tanδ / (2 * sqrt(ϵe) * (ϵr - 1))
Rs = uconvert(u"Ω", sqrt(π * f0 * μ_0 / σ_Cu))
W = W_d * d
αc = uconvert(u"m^-1",  Rs / (Z0 * W))

λ0 = uconvert(u"m", c_0 / (f0 * sqrt(ϵe)))
l = λ0 / 2
β = uconvert(u"rad/m", 2 * π * f0 * sqrt(ϵe) / c_0)

Q = β / (2 * (αc + ustrip(αd)u"m^-1"))
