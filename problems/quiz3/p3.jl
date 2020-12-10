function circleCenter(Sx, Sy, Δ)
	conj(Sx - Δ * conj(Sy)) / (abs(Sx)^2 - abs(Δ)^2)
end

function circleRadius(Sx, S12, S21, Δ)
	abs((S12 * S21) / (abs(Sx)^2 - abs(Δ)^2))
end

S11 = 0.7 * exp(im * deg2rad(-110))
S12 = 0.02 * exp(im * deg2rad(60))
S21 = 3.5 * exp(im * deg2rad(60))
S22 = 0.8 * exp(im * deg2rad(-70))

Δ = S11 * S22 - S12 * S21
function ampΔ(S11, S12, S21, S22)
	S11 * S22 - S12 * S21
end

function ampK(S11, S12, S21, S22, Δ)
	(1 - abs(S11)^2 - abs(S22)^2 + abs(Δ)^2) / (2 * abs(S12 * S21))
end

Δ = ampΔ(S11, S12, S21, S22)
K = ampK(S11, S12, S21, S22, Δ)

U = abs(S12) * abs(S21) * abs(S11) * abs(S22) / ((1 - abs(S11)^2) * (1 - abs(S22)^2))
lowerBound = 1 / (1 + U)^2
upperBound = 1 / (1 - U)^2

lowerBound_dB = 10 * log10(lowerBound)
upperBound_dB = 10 * log10(upperBound)

Z0 = 50
GL = 1 / (1 - abs(S22)^2)
GL_dB = 10 * log10(GL)
Γopt = 0.73 * exp(im * deg2rad(-120))
Γs = Γopt
Gs = 1 / Z0 * (1 - abs(Γs)^2) / abs(1 + Γs)^2
Gs_dB = 10 * log10(Gs)
G0 = abs(S21)^2
G0_dB = 10 * log10(G0)

GTU_dB = Gs_dB + G0_dB + GL_dB

# SmithChart Time
rin = abs(Γs) * SmithChartR
x = rin * cos(atan(6.75/3.86))
y = rin * sin(atan(6.75/3.86))

ΓL = conj(S22)
rin = abs(ΓL) * SmithChartR
ΓLangle = rad2deg(angle(ΓL))
x = rin * cos(atan(7.61 / 2.74))
y = rin * sin(atan(7.61 / 2.74))
