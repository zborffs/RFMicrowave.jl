using RFMicrowave, Unitful

# Given
# - BPF
# - Lumped Element
# - EqualRipple 0.5dB
f0 = 4u"GHz"
N = 3
Δ = 0.05
Z0 = 50u"Ω"

# Step 1: Find g values
g = EqualRipple05dB[N]
Rs = 1.0
RL = g[end]
L = g[1:2:end-1]
C = g[2:2:end-1]

# Step 2: Impedance Scaling
L, C, Rs, RL = lpf_proto_impedance_scale(L, C, Rs, RL, Z0)

# Step 3: BPF transform
LC_series, LC_parallel = lpf_proto_to_bpf(L, C, Δ, 2 * π * f0)

LC_series = (uconvert.(u"nH", LC_series[1]), uconvert.(u"pF", LC_series[2]))
LC_parallel = (uconvert.(u"nH", LC_parallel[1]), uconvert.(u"pF", LC_parallel[2]))
