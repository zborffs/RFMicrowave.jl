using Unitful, LinearAlgebra, Roots
using Plots

# Given
W = 1.2446u"mm"
H = 1.27u"mm"
ϵr = 9.8
f = 2u"GHz"
Z0 = 50u"Ω"

# Design a Microstrip Wilkinson Power divider at 2 GHz with equal power split for
# a 50Ohm system. (W = 1.2446mm, H=1.27mm )
x = 0.56 * ((ϵr - 0.9) / (ϵr + 3))^(0.05)
y_eq(s) = 1 + 0.002 * log((s^4 + 3.7e-4 * s^2) / (s^4 + 0.43)) + 0.05 * log(1 + 1.7e-4 * s^3)
ϵ_eff_eq(s) = (ϵr + 1) / 2 + (ϵr - 1) / 2 * (1 + 10 / s)^(-x * y_eq(s))
t_eq(s) = (30.67 / s)^(0.75)
Z0_eq(s) = 60 / sqrt(ϵ_eff_eq(s)) * log((6 + (2 * π - 6) * exp(-t_eq(s) ) ) / s + sqrt(1 + 4/s^2))
f_eq(x) = Z0_eq(x) - sqrt(2) * ustrip(Z0)
s = find_zero(f_eq, 1)
w = s * H
s1 = find_zero(f_eq, 0.25)
Z0_eq(s)
ω = 2 * π * f
λ0 = c / f
λ = λ0 / sqrt(ϵr)
β = 2 * π / λ

# Figure out the power reflected and the power delivered
Pi = uconvert(u"W", 36u"dBm")
plot(Z0_eq)
