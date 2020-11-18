using Unitful, RFMicrowave

N = 5
g = MaximallyFlat[N]
C = g[1:2:end-1]
L = g[2:2:end-1]
Rs = 1.0
RL = g[end]
R0 = 50u"Ω"
f0 = 2u"GHz"

(L, C, Rs, RL) = lpf_proto_impedance_scale(L, C, Rs, RL, R0)
@assert Rs == R0
(L, C) = lpf_proto_freq_scale_lpf(L, C, 2 * π * f0)

Rs
C = uconvert.(u"pF", C)
L = uconvert.(u"nH", L)
