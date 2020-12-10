using RFMicrowave, Unitful

R = 2.5u"Ω"
L = 50u"nH"
C = 0.79u"pF"
RL = 2.5u"Ω"

# Resonant Frequency
ω0 = resonant_frequency(L, C)
f0 = uconvert(u"MHz", ω0 / (2 * π))

# Unloaded Q-Factor for Series
Qunloaded = uconvert(u"NoUnits", series_q_factor_LR(L, R, ω0))

# Q-Loaded
Qloaded = uconvert(u"NoUnits", series_q_factor_LR(L, R + RL, ω0))
