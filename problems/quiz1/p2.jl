using LinearAlgebra, Unitful

# Given
Z0 = 50
SA_11 = 1/3 + im * 2/3
SA_21 = im * 2/3
SA_12 = im * 2/3
SA_22 = 1/3 - im * 2/3
SA = [S11 S12; S21 S22]

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

function ABCD_to_S(ABCD; Z0=50)
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
	B = im * Z0 * sin(βl)
	C = im * Y0 * sin(βl)
	D = A
	return [A B; C D]
end

# Find
# (a.)
ZA = S_to_Z(SA)
YA = S_to_Y(SA)

# (b.)
ABCD_A = S_to_ABCD(SA)
ABCD_015 = ABCD_TL(0.15 * 2 * π)
ABCD_025 = ABCD_TL(0.25 * 2 * π)
ABCD_tot_qb = ABCD_A * ABCD_015 * ABCD_A * ABCD_025 * ABCD_A
S_tot_qb = ABCD_to_S(ABCD_tot_qb)

# (c.)
SB_11 = 1/3 - 2/3*im
SB_21 = 2/3*im
SB_12 = 2/3*im
SB_22 = 1/3 + 2/3*im
SB = [SB_11 SB_12; SB_21 SB_22]
ABCD_B = S_to_ABCD(SB)
ABCD_04 = ABCD_TL(0.4 * 2 * π)
ABCD_025 = ABCD_TL(0.25 * 2 * π)

ABCD_tot_qc = ABCD_B * ABCD_04 * ABCD_B * ABCD_025
S_tot_qc = ABCD_to_S(ABCD_tot)

function STAndLoad_to_Γin(ST, Γ)
	S11 = ST[1]
	S21 = ST[2]
	S12 = ST[3]
	S22 = ST[4]
	return S11 + S12 * Γ * S21 / (1 - Γ * S22)
end

function Γ_to_S(Γ)
	Γ_abs = abs(Γ)
	return (1 + Γ_abs) / (1 - Γ_abs)
end

function symSeSm_to_S(Se, Sm)
	S11 = (Sm + Se) / 2
	S22 = S11
	S12 = (Sm - Se) / 2
	S21 = S12
	return [S11 S12; S21 S22]
end

Γine = STAndLoad_to_Γin(S_tot_qc, -1)
Γinm = STAndLoad_to_Γin(S_tot_qc, 1)
Se = Γ_to_S(Γine)
Sm = Γ_to_S(Γinm)
S_sym_tot_qc = symSeSm_to_S(Se, Sm)
