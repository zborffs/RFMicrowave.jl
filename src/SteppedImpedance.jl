using RFMicrowave, Unitful

function steppedLPF(L, C, ω0, Zl, Zh, Z0)
	elecLengthL = L * Z0 / Zh
	elecLengthC = C * Zl / Z0
	return (elecLengthL, elecLengthC)
end
