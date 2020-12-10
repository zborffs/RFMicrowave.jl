using Unitful, RFMicrowave

# Given
R = 2.5u"Ω"
L = 50u"nH"
C = 0.79u"pF"
RL = 2.5u"Ω"

# Find
# Resonant Frequency (f0)
f0 = uconvert(u"GHz", 1/(2 * π * sqrt(L*C)))
Qunloaded = series_q_factor_CR(C, R, 2 * π * f0)
Qloaded = series_q_factor_CR(C, R + RL, 2 * π * f0)

Qunloaded_p = parallel_q_factor_CR(C, R, 2 * π * f0)
Qe_p = parallel_q_factor_CR(C, RL, 2 * π * f0)
Qloaded_p = (1 / Qunloaded_p + 1 / Qe_p)^-1
