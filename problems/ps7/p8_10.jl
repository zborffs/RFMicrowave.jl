using RFMicrowave, Unitful
# Bandstop filter

N = 3
Δ = 0.1
f0 = 3u"GHz"
R0 = 75u"Ω"

# Equal Ripple 05 dB
g = EqualRipple05dB[N]

# Figure out parameters
C = g[2:2:end-1]
L = g[1:2:end-1]
Rs = 1.0
RL = g[end]

# Do impedance scaling
(L, C, Rs, RL) = lpf_proto_impedance_scale(L, C, Rs, RL, R0)
(LC_parallel, LC_series) = lpf_proto_to_pbf(L, C, Δ, 2 * π * f0)
LC_parallel = (uconvert.(u"nH", LC_parallel[1]), uconvert.(u"pF", LC_parallel[2]))
LC_series = (uconvert.(u"nH", LC_series[1]), uconvert.(u"pF", LC_series[2]))
