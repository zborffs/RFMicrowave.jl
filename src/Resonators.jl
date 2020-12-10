using Unitful
import PhysicalConstants.CODATA2014: μ_0, ε_0, c_0


export μ_0, ε_0, c_0

export resonant_frequency
function resonant_frequency(L, C)
	return uconvert(u"rad/s", 1 / sqrt(L * C))
end

export series_q_factor_LR
function series_q_factor_LR(L, R, ω0)
	uconvert(u"NoUnits", ω0 * L / R)
end

export series_q_factor_CR
function series_q_factor_CR(C, R, ω0)
	uconvert(u"NoUnits", 1 / (ω0 * R * C))
end

export parallel_q_factor_LR
function parallel_q_factor_LR(L, R, ω0)
	uconvert(u"NoUnits", R / (ω0 * L))
end

export parallel_q_factor_CR
function parallel_q_factor_CR(C, R, ω0)
	uconvert(u"NoUnits", ω0 * R * C)
end

# S.C. \lambda/2 and \lambda/4 line + O.C. \lambda/2
export tem_q_factor
function tem_q_factor(β, α)
	β / (2 * α)
end

# Waveguides
export waveguide_k
function waveguide_k(f, ϵr)
	uconvert(u"m^-1", 2 * π * f * sqrt(ϵr) / c_0)
end

export waveguide_length10l
function waveguide_length10l(k, a, l=1)
	uconvert(u"m", l * π / sqrt(k^2 - (π / a)^2))
end

export waveguide_intrinsic_impedance
function waveguide_intrinsic_impedance(ϵr)
	377u"Ω" / sqrt(ϵr)
end

export waveguide_q_factor_c
function waveguide_q_factor_c(k, a, b, d, Rs, η, l = 1)
	(k * a * d)^3 * b * η / (2 * π^2 * Rs * (2l^2 * a^3 * b + 2 * b * d^3 + l^2 * a^3 * d + a * d^3))
end

export waveguide_q_factor_d
function waveguide_q_factor_d(tanδ)
	1 / tanδ
end

export waveguide_q_factor_tot
function waveguide_q_factor_tot(Qc, Qd)
	1 / (1 / Qc + 1 / Qd)
end

# Coaxial
export coaxial_resonator_length
function coaxial_resonator_length(λ, n = 1)
	n * λ / 2
end

export coaxial_resonator_wavelength
function coaxial_resonator_wavelength(f0, ϵr)
	c_0 / (f0 * sqrt(ϵr))
end

export coaxial_resonator_frequency
function coaxial_resonator_frequency(length, ϵr, n = 1)
	n * c_0 / (2 * length * sqrt(ϵr))
end

# microstrip resonators
export μstrip_resonator_length
function μstrip_resonator_length(λ, n = 1)
	n * λ / 2
end

export μstrip_resonator_wavelength
function μstrip_resonator_wavelength(f0, ϵe)
	c_0 / (f * sqrt(ϵe))
end

export μstrip_resonator_frequency
function μstrip_resonator_frequency(length, ϵe, n = 1)
	n * c_0 / (2 * length * sqrt(ϵe))
end
