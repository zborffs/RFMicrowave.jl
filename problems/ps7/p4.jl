using RFMicrowave, Unitful

f0 = 3u"GHz"
N = 5
g = EqualRipple05dB[N]
C = g[1:2:end-1]
L = g[2:2:end-1]
RL = g[end]
Rs = 1.0u"Ω"
R0 = 50u"Ω"
Zl = 15u"Ω"
Zh = 120u"Ω"

C = uconvert.(u"pF", C)
L = uconvert.(u"nH", L)


function steppedLPF(L, C, ω0, Zl, Zh, Z0)
	elecLengthL = L * Z0 / Zh
	elecLengthC = C * Zl / Z0
	return (elecLengthL, elecLengthC)
end


elecLengthL, elecLengthC = steppedLPF(L, C, 2 * π * f0, Zl, Zh, R0)
