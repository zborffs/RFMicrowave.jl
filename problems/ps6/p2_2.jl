using RFMicrowave, Unitful

# Given
# - Resonator - Coaxial TL terminated by s.c. and cap
l = 3u"cm"
ϵr = 1
Z0 = 100u"Ω"
f0 = 6u"GHz"

# Find C
Y0 = 1 / Z0
λ = uconvert(u"m", c_0 / f0)
β = 2 * π / λ
C = uconvert(u"pF", Y0 * cot(β * l) / (2 * π * f0))

# Find Q
R = 10000u"Ω"

ωL = uconvert(u"Ω", Z0 * tan(β * l))
Qunloaded = parallel_q_factor_CR(C, R, 2 * π * f0)
