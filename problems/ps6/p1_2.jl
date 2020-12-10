using RFMicrowave, Unitful

R = 2.5u"Ω"
L = 50u"nH"
C = 0.79u"pF"
RL = 2.5u"Ω"

ω = uconvert(u"rad/s", 1 / sqrt(L * C))
f = uconvert(u"MHz", ω / (2 * π))

Qunloaded = series_q_factor_CR(C, R, ω)
Qloaded = series_q_factor_CR(C, R + RL, ω)

Qunloaded_parallel = parallel_q_factor_CR(C, R, ω)
Qloaded_parallel = parallel_q_factor_CR(C, R * RL / (R + RL), ω)
