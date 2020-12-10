using RFMicrowave, Unitful, UnitfulAstro

# Given
f0 = 3u"GHz"
N = 5
Z0 = 50u"Ω"
Zl = 15u"Ω"
Zh = 120u"Ω"

# Find g values
g = EqualRipple05dB[N]
L = g[2:2:end-1]
C = g[1:2:end-1]
RL = g[end]
Rs = 1.0

# perform stepped LPF transform
θL, θC = steppedLPF(L, C, Zl, Zh, Z0)
