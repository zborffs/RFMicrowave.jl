using RFMicrowave, Unitful

# Design a Lumped Element High-Pass Filter
f0 = 3u"GHz"
R0 = 75u"Ω"
N = 5

# Step 1: Determine the g vales
g = EqualRipple3dB[N]
C = g[1:2:end-1] # don't change indicies
L = g[2:2:end-1] # don't change indices
Rs = 1.0
RL = g[end]

# Step 2: Perform Impedance Transformation and HPF transformation
(L, C, Rs, RL) = lpf_proto_impedance_scale(L, C, Rs, RL, R0)
L, C = lpf_proto_to_hpf(L, C, 2 * π * f0)
@assert length(L) == 3
@assert length(C) == 2


L = uconvert.(u"nH", L)
C = uconvert.(u"pF", C)
