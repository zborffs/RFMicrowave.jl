using Unitful, LinearAlgebra

# Given
N = 3
Za = (100im)u"Ω"
Zb = (100im)u"Ω"
Zc = (50im)u"Ω"
L = (0.1 * N) # wavelengths
Z0 = 50u"Ω"

# Some Functions
function S_to_ABCD(S; Z0=50)
	S11 = S[1]
	S21 = S[2]
	S12 = S[3]
	S22 = S[4]
	A = ((1 + S11) * (1 - S22) + S12 * S21) / (2 * S21)
	B = Z0 * ((1 + S11) * (1 + S22) - S12 * S21) / (2 * S21)
	C = 1 / Z0 * ((1 - S11) * (1 - S22) - S12 * S21) / (2 * S21)
	D = ((1 - S11) * (1 + S22) + S12 * S21) / (2 * S21)
	return [A B; C D]
end

function ABCD_to_S(ABCD; Z0=50u"Ω")
	A = ABCD[1]
	C = ABCD[2]
	B = ABCD[3]
	D = ABCD[4]
	S11 = (A + B/Z0 - C * Z0 - D) / (A + B/Z0 + C * Z0 + D)
	S12 = 2 * (A * D - B * C) / (A + B/Z0 + C * Z0 + D)
	S21 = 2 / (A + B / Z0 + C*Z0 + D)
	S22 = (-A + B/Z0 - C * Z0 + D) / (A + B / Z0 + C * Z0 + D)
	return [S11 S12; S21 S22]
end

function S_to_Z(S; Z0=50)
	S11 = S[1]
	S21 = S[2]
	S12 = S[3]
	S22 = S[4]
	denom = ((1 - S11) * (1 - S22) - S12 * S21)
	Z11 = Z0 * ((1 + S11) * (1 - S22) + S12 * S21) / denom
	Z12 = Z0 * (2 * S12) / denom
	Z21 = Z0 * (2 * S21) / denom
	Z22 = Z0 * ((1 - S11) * (1 + S22) + S12 * S21) / denom
	return [Z11 Z12; Z21 Z22]
end

function S_to_Y(S; Z0=50)
	Z = S_to_Z(S; Z0=Z0)
	Z11 = Z[1]
	Z21 = Z[2]
	Z12 = Z[3]
	Z22 = Z[4]
	myDet = det(Z)
	Y11 = Z22 / myDet
	Y12 = -Z12 / myDet
	Y21 = -Z21 / myDet
	Y22 = Z11 / myDet
	return [Y11 Y12; Y21 Y22]
end

function ABCD_TL(βl; Z0=50)
	Y0 = 1 / Z0
	A = cos(βl)
	B = (im * Z0 * sin(βl))u"Ω"
	C = (im * Y0 * sin(βl))u"Ω^-1"
	D = (A)
	return [A B; C D]
end

function ABCD_Y(Y1, Y2, Y3)
	A = 1 + Y2 / Y3
	B = 1 / Y3
	C = Y1 + Y2 + Y1 * Y2 / Y3
	D = 1 + Y1 / Y3
	return [A B; C D]
end

# Find
# S-Parameters of the following 2 port network
βl1 = 2 * π * L
ABCD_1 = ABCD_TL(βl1)
βl2 = 2 * π * 0.25
ABCD_2 = ABCD_TL(βl2)
ABCD_2 = [round(ABCD_2[1]) ABCD_2[3]; ABCD_2[2] round(ABCD_2[4])]
ABCD_Za = [1 Za; 0u"Ω^-1" 1]
Yb = 1 / Zb
Yc = 1 / Zc
ABCD_ZbZc = ABCD_Y(Yc, Yc, Yb)
ABCD_overall = ABCD_1 * ABCD_Za * ABCD_ZbZc * ABCD_Za * ABCD_2
S_overall = ABCD_to_S(ABCD_overall)

# Scattering Matrix if Za is replaced by an open circuit
# - in other words, Za = infinity
S_1 = ABCD_to_S(ABCD_1)
S_2 = ABCD_to_S(ABCD_2)

Γin_1 = S_1[2] * S_1[3] * -1
Γin_2 = S_2[2] * S_2[3] * -1
