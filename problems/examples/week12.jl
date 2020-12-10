function circleCenter(Sx, Sy, Δ)
	conj(Sx - Δ * conj(Sy)) / (abs(Sx)^2 - abs(Δ)^2)
end

function circleRadius(Sx, S12, S21, Δ)
	abs((S12 * S21) / (abs(Sx)^2 - abs(Δ)^2))
end

S11 = 0.869 * exp(im * deg2rad(-159))
S12 = 0.031 * exp(im * deg2rad(-9))
S21 = 4.250 * exp(im * deg2rad(61))
S22 = 0.507 * exp(im * deg2rad(-117))

Δ = S11 * S22 - S12 * S21

CL = conj(S22 - Δ * conj(S11)) / (abs(S22)^2 - abs(Δ)^2)
CL = circleCenter(S22, S11, Δ)
RL = abs((S12 * S21) / (abs(S22)^2 - abs(Δ)^2))
RL = circleRadius(S22, S12, S21, Δ)

Cs = circleCenter(S11, S22, Δ)
Rs = circleRadius(S11, S12, S21, Δ)

if abs(S11) < 1
	println("Stable Region for Γin contains origin")
else
	println("Stable region for Γin does not contain origin")
end

if abs(S22) < 1
	println("Stable Region for Γout contains origin")
else
	println("Stable region for Γout does not contain origin")
end


function ampΔ(S11, S12, S21, S22)
	S11 * S22 - S12 * S21
end

function ampK(S11, S12, S21, S22, Δ)
	(1 - abs(S11)^2 - abs(S22)^2 + abs(Δ)^2) / (2 * abs(S12 * S21))
end

#
S11 = 0.641 * exp(im * deg2rad(-171.3))
S12 = 0.057 * exp(im * deg2rad(16.3))
S21 = 2.058 * exp(im * deg2rad(28.5))
S22 = 0.572 * exp(im * deg2rad(-95.7))

# Step 1: Check Stability
Δ = ampΔ(S11, S12, S21, S22)
K = ampK(S11, S12, S21, S22, Δ)

if abs(Δ) < 1 && K > 1
	println("Unconditionally Stable")
else
	println("Potentially Stable")
end

# Step 2: Check if we can consider to be Unilateral
U = abs(S12) * abs(S21) * abs(S11) * abs(S22) / ((1 - abs(S11)^2) * (1 - abs(S22)^2))

lowerBound = 1 / (1 + U)^2
upperBound = 1 / (1 - U)^2

lowerBound_dB = 10 * log10(lowerBound)
upperBound_dB = 10 * log10(upperBound)

if upperBound_dB - lowerBound_dB > 0.1
	println("We cannot make the Unilateral assumption, because Unilateral Figure of Merit range is too big")
else
	println("The range of the Unilateral Figure of Merit is small enough to make Unilateral assumption")
end

B1 = 1 + abs(S11)^2 - abs(S22)^2 - abs(Δ)^2
B2 = 1 + abs(S22)^2 - abs(S11)^2 - abs(Δ)^2
C1 = S11 - Δ * conj(S22)
C2 = S22 - Δ * conj(S11)
Γs_pos = (B1 + sqrt(B1^2 - 4 * abs(C1)^2)) / (2 * C1)
Γs_neg = (B1 - sqrt(B1^2 - 4 * abs(C1)^2)) / (2 * C1)
ΓL_pos = (B2 + sqrt(B2^2 - 4 * abs(C2)^2)) / (2 * C2)
ΓL_neg = (B2 - sqrt(B2^2 - 4 * abs(C2)^2)) / (2 * C2)

# Check +/- by checking if abs>1
Γs = 0
ΓL = 0
if abs(Γs_pos) > 1 && abs(Γs_neg) < 1
	println("Use Negative Solution")
	Γs = Γs_neg
	ΓL = ΓL_neg
elseif abs(Γs_pos) < 1 && abs(Γs_neg) > 1
	println("Use Positive Solution")
	Γs = Γs_pos
	ΓL = ΓL_pos
else
	println("I don't know")
end

Gs = 1 / (1 - abs(Γs)^2)
G0 = abs(S21)^2
GL = (1 - abs(ΓL)^2) / abs(1 - S22 * ΓL)^2

G_Tmax = Gs * G0 * GL
G_Tmax_dB = 10 * log10(G_Tmax)
