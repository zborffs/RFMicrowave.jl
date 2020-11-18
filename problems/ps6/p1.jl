using RFMicrowave, Unitful

R = 2.5u"Ω"
RL = 2.5u"Ω"
C = 0.79u"pF"
L = 50u"nH"

ω0 = resonant_frequency(L, C)
f0 = uconvert(u"MHz", ω0/(2π))
@assert unit(ω0) == u"rad/s"
Q0 = uconvert(u"NoUnits", series_q_factor_CR(C, R, ω0))
Qloaded = uconvert(u"NoUnits", series_q_factor_CR(C, R + RL, ω0))

Q0_p = uconvert(u"NoUnits", parallel_q_factor_CR(C, R, ω0))
QLoaded_p = uconvert(u"NoUnits", parallel_q_factor_CR(C, R * RL / (R + RL), ω0))
