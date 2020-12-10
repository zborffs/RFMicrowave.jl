using Unitful, RFMicrowave

# Given
l = 3.0u"cm"
Z0 = 100u"Ω"
f0 = 6.0u"GHz"
ϵr = 1

# Find
Y0 = 1 / Z0
λ = c_0 / (f0 * sqrt(ϵr))
β = 2 * π / λ
ω = 2 * π * f0
C = uconvert(u"pF", Y0 / ω * cot(β * l))

R = 10000u"Ω"
Q = parallel_q_factor_CR(C, R, 2 * π * f0)
L = Z0 * tan(β * l) / ω
Q2 = parallel_q_factor_LR(L, R, ω)
