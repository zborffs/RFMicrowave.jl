using RFMicrowave, Unitful

# Chebyshev (0.5 dB), BPF
N = 3
f0 = 4u"GHz"
Δ = 0.05
g = EqualRipple05dB[N]
C = g[2:2:end-1]
L = g[1:2:end-1]
Rs = 1.0
RL = g[end]
R0 = 50u"Ω"

(L, C, Rs, RL) = lpf_proto_impedance_scale(L, C, Rs, RL, R0)
(LC_series, LC_shunt) = lpf_proto_to_bpf(L, C, Δ, 2 * π * f0)
LC_series = (uconvert.(u"nH", LC_series[1]), uconvert.(u"pF", LC_series[2]))
LC_shunt = (uconvert.(u"nH", LC_shunt[1]), uconvert.(u"pF", LC_shunt[2]))
