using Unitful, LinearAlgebra

export ampΔ, ampK
function ampΔ(S11, S12, S21, S22)
	S11 * S22 - S12 * S21
end

function ampΔ(S)
	det(S)
end

function ampK(S11, S12, S21, S22, Δ)
	(1 - abs(S11)^2 - abs(S22)^2 + abs(Δ)^2) / (2 * abs(S12 * S21))
end

function ampK(S)
	Δ = det(S)
	(1 - abs(S[1,1])^2 - abs(S[2,2])^2 + abs(Δ)^2) / (2 * abs(S[1,2] * S[2,1]))
end

export ampU
function ampU(S)
	U = abs(S[1,2]) * abs(S[2,1]) * abs(S[1,1]) * abs(S[2,2]) / ((1 - abs(S[1,1])^2) * (1 - abs(S[2,2])^2))
end

export ampURange
function ampURange(U)
	[1 / (1 + U)^2, 1 / (1-U)^2]
end

export ampURange_dB
function ampURange_dB(U)
	URange = ampURange(U)
	10 * log10.(URange)
end

export ampCircleCenter
function ampCircleCenter(Sx, Sy, Δ)
	conj(Sx - Δ * conj(Sy)) / (abs(Sx)^2 - abs(Δ)^2)
end

export ampCircleRadius
function ampCircleRadius(Sx, S12, S21, Δ)
	abs((S12 * S21) / (abs(Sx)^2 - abs(Δ)^2))
end
