using Unitful
import PhysicalConstants.CODATA2014: μ_0, ε_0, c_0

export μstripValues
function μstripValues(W, h, ϵr, f0)
	s = W / h
	if s < 1
		ϵeff = (ϵr + 1) / 2 + (ϵr - 1) / 2 * ((1 + 12 / s)^(-1/2) + 0.04 * (1 - s)^2)
		Z0 = 60 / sqrt(ϵeff) * log(8 / s + s / 4)
	else
		ϵeff = (ϵr + 1) / 2 + (ϵr - 1) / 2 * (1 + 12 / s)^(-1/2)
		Z0 = π / sqrt(ϵeff) * 120 / (s + 1.393 + 0.667 * log(s + 1.444))
	end

	β = uconvert(u"m^-1", 2 * π * f0 * sqrt(μ_0 * ε_0 * ϵeff))
	up = uconvert(u"m/s", 1 / sqrt(μ_0 * ε_0 * ϵeff))

	return (ϵeff, (ustrip(Z0))u"Ω", β, up)
end

function μstripCoc(W, H, ϵeff, Z0)
	s = W / H
	Δl = H * 0.412 * (ϵeff + 0.3) / (ϵeff - 0.258) * ((s + 0.264) / (s + 0.8))
	Coc = Δl * sqrt(ϵeff) / (c_0 * Z0)
end
