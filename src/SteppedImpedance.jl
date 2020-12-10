using RFMicrowave, Unitful, UnitfulAstro

export steppedLPF
function steppedLPF(L, C, Zl, Zh, Z0)
	elecLengthL = L * Z0 / Zh
	elecLengthC = C * Zl / Z0
	return (rad2deg.(elecLengthL), rad2deg.(elecLengthC))
end
