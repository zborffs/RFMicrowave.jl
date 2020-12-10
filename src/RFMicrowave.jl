module RFMicrowave

using Unitful

include("FilterTransforms.jl")
include("Microstrip.jl")
include("Resonators.jl")
include("SteppedImpedance.jl")
include("TLs.jl")
include("Amps.jl")

export printComplex
function printComplex(z)
	println("$(abs(z)) ∠$(rad2deg(angle(z)))")
end

# Quarter Wave Coupled resonators
export bandstop_coupled_resonator_impedance
function bandstop_coupled_resonator_impedance(Δ, gn ;Z0=50.0u"Ω")
	4 * Z0 / (π * gn * Δ)
end

export bandpass_coupled_resonator_impedance
function bandpass_coupled_resonsator_impedance(Δ, gn; Z0=50u"Ω")
	π * Z0 * Δ / (4 * gn)
end

# Capacitively Coupled Series resonators
export bandpass_coupled_line_J1
function bandpass_coupled_line_J1(Δ, g1; Z0=50u"Ω")
	1 / Z0 * sqrt(π * Δ / (2 * g1))
end

export bandpass_coupled_line_Jn
function bandpass_coupled_line_Jn(Δ, gn_1, gn; Z0=50u"Ω")
	π * Δ / (2 * sqrt(gn_1 * gn) * Z0)
end

export bandpass_coupled_line_Jn_1
function bandpass_coupled_line_Jn_1(Δ, gn, gn_p_1; Z0=50u"Ω")
	1 / Z0 * sqrt(π * Δ / (2 * gn * gn_p_1))
end

export bandpass_coupled_line_inv_const
function bandpass_coupled_line_inv_const(Δ, g; Z0=50u"Ω")
	size = length(g)
	temp = bandpass_coupled_line_J1(Δ, g[1]; Z0 = Z0)
	J = Vector{typeof(temp)}(undef, size)
	J[1] = temp
	for i in 2:length(J) - 1
		J[i] = bandpass_coupled_line_Jn(Δ, g[i - 1], g[i])
	end
	J[size] = bandpass_coupled_line_Jn_1(Δ, g[size - 1], g[size])
	return J
end

export inv_to_capacitive_susceptance
function inv_to_capacitive_susceptance(Ji; Z0=50u"Ω")
	Bi = Ji / (1 - (Z0 * Ji)^2)
end

export cap_susceptance_to_cap
function cap_susceptance_to_cap(Bi, ω0)
	Ci = Bi / ω0
end

export cap_susceptance_to_elec_length
function cap_susceptance_to_elec_length(B; Z0=50u"Ω")
	θ = zeros(length(B) - 1)
	for i in 1:length(θ)
		θ[i] = π - 0.5 * (atan(2 * Z0 * B[i]) + atan(2 * Z0 * B[i + 1]))
	end
	return θ
end

# Capacitively Coupled Shunt Resonators
export bpf_cap_coupled_shuntJ1
function bpf_cap_coupled_shuntJ1(Δ, g1; Z0=50u"Ω")
	1 / Z0 * sqrt(π * Δ / (4 * g1))
end

export bpf_cap_coupled_shuntJn
function bpf_cap_coupled_shuntJn(Δ, gn, gn_1; Z0=50u"Ω")
	1 / Z0 * ((π * Δ) / (4 * sqrt(gn * gn_1)))
end

export bpf_cap_coupled_shuntJn_1
function bpf_cap_coupled_shuntJn_1(Δ, gn, gn_1; Z0=50u"Ω")
	1 / Z0 * sqrt(π * Δ / (4 * gn * gn_1))
end

export bpf_cap_coupled_shunt_C1
function bpf_cap_coupled_shunt_C1(J01, ω0; Z0=50u"Ω")
	J01 / (ω0 * sqrt(1 - (Z0 * J01)^2))
end

export bpf_cap_coupled_shuntCn
function bpf_cap_coupled_shuntCn(Jn, ω0)
	Jn / ω0
end

export bpf_cap_coupled_shuntCn_1
function bpf_cap_coupled_shuntCn_1(Jn_1, ω0; Z0=50u"Ω")
	Jn_1 / (ω0 * sqrt(1 - (Z0 * Jn_1)^2))
end

export bpf_cap_coupled_ln
function bpf_cap_coupled_ln(ω0, ΔC; Z0=50u"Ω")
	1 / 4 + (Z0 * ω0 * ΔC / (2 * π))
end

export bpf_cap_coupled_shunt_J
function bpf_cap_coupled_shunt_J(Δ, g; Z0=50u"Ω")
	size = length(g)
	temp = bpf_cap_coupled_shuntJ1(Δ, g[1]; Z0=Z0)
	J = Vector{typeof(temp)}(undef, size)
	J[1] = temp
	for i in 2:length(J) - 1
		J[i] = bpf_cap_coupled_shuntJn(Δ, g[i - 1], g[i])
	end
	J[size] = bpf_cap_coupled_shuntJn_1(Δ, g[size - 1], g[size])
	return J
end

export bpf_cap_coupled_shunt_C
function bpf_cap_coupled_shunt_C(J, ω0; Z0=50u"Ω")
	size = length(J)
	temp = bpf_cap_coupled_shunt_C1(J[1], ω0; Z0=Z0)
	C = Vector{typeof(temp)}(undef, size)
	C[1] = temp
	for i in 2:length(J) - 1
		C[i] = bpf_cap_coupled_shuntCn(J[i], ω0)
	end
	C[size] = bpf_cap_coupled_shuntCn_1(J[end], ω0; Z0=Z0)
	return C
end

export bpf_cap_coupled_shunt_ΔC
function bpf_cap_coupled_shunt_ΔC(C)
	size = length(C) - 1
	ΔC = Vector{typeof(C[1])}(undef, size)
	for i in 1:size
		ΔC[i] = -C[i] - C[i + 1]
	end
	return ΔC
end

export bpf_cap_coupled_shunt_Δl
function bpf_cap_coupled_shunt_Δl(ω0, C; Z0=50u"Ω")
	Z0 * ω0 * C / (2 * π)
end

# Generic
export find_center_freq
function find_center_freq(ω1, ω2)
	ω0 = sqrt(ω1 * ω2)
end

export lpf_bpf_transform
function lpf_bpf_transform(ω, ω0, ω1, ω2)
	Δ = (ω2 - ω1) / ω0
	lpf_bpf_transform(ω, ω0, Δ)
end

function lpf_bpf_transform(ω, ω0, Δ)
	1 / Δ * (ω / ω0 - ω0 / ω)
end

export EqualRipple05dB
EqualRipple05dB = Dict([
	(1,  [0.6986, 1.0000]),
	(2,  [1.4029, 0.7071, 1.9841]),
	(3,  [1.5963, 1.0967, 1.5963, 1.0000]),
	(4,  [1.6703, 1.1926, 2.3661, 0.8419, 1.9841]),
	(5,  [1.7058, 1.2296, 2.5408, 1.2296, 1.7058, 1.0000]),
	(6,  [1.7254, 1.2479, 2.6064, 1.3137, 2.4758, 0.8696, 1.9841]),
	(7,  [1.7372, 1.2583, 2.6381, 1.3444, 2.6381, 1.2583, 1.7372, 1.0000]),
	(8,  [1.7451, 1.2647, 2.6564, 1.3590, 2.6964, 1.3389, 2.5093, 0.8796, 1.9841]),
	(9,  [1.7504, 1.2690, 2.6678, 1.3673, 2.7239, 1.3673, 2.6678, 1.1690, 1.7504, 1.0000]),
	(10, [1.7543, 1.2721, 2.6754, 1.3725, 2.7392, 1.3806, 2.7231, 1.3485, 2.5239, 0.8842, 1.9841]),
])

export EqualRipple3dB
EqualRipple3dB = Dict([
	(1,  [1.9953, 1.0000]),
	(2,  [3.1013, 0.5339, 5.8095]),
	(3,  [3.3487, 0.7117, 3.3487, 1.0000]),
	(4,  [3.4389, 0.7483, 4.3471, 0.5920, 5.8095]),
	(5,  [3.4817, 0.7618, 4.5381, 0.7618, 3.4817, 1.0000]),
	(6,  [3.5045, 0.7685, 4.6061, 0.7929, 4.4641, 0.6033, 5.8095]),
	(7,  [3.5182, 0.7723, 4.6386, 0.8039, 4.6386, 0.7723, 3.5182, 1.0000]),
	(8,  [3.5277, 0.7745, 4.6575, 0.8089, 4.6990, 0.8018, 4.4990, 0.6073, 5.8095]),
	(9,  [3.5340, 0.7760, 4.6692, 0.8118, 4.7272, 0.8181, 4.6692, 0.7760, 3.5340, 1.0000]),
	(10, [3.5384, 0.7771, 4.6768, 0.8136, 4.7425, 0.8164, 4.7260, 0.8051, 4.5142, 0.6091, 5.8095]),
])

export MaximallyFlat
MaximallyFlat = Dict([
	(1, [2.0000, 1.0000]),
	(2, [1.4142, 1.4142, 1.0000]),
	(3, [1.0000, 2.0000, 1.0000, 1.0000]),
	(4, [0.7654, 1.8478, 1.8478, 0.7654, 1.0000]),
	(5, [0.6180, 1.6180, 2.0000, 1.6180, 0.6180, 1.0000])
])

end
