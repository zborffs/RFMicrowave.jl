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

ABCD1 = [complex(1.0)u"NoUnits" complex(50.0)u"Ω"; complex(0.0)u"1/Ω" complex(1.0)u"NoUnits"]
ABCD2 = [complex(1/2)u"NoUnits" complex(0)u"Ω"; complex(0)u"1/Ω" complex(2.0)u"NoUnits"]
ABCD3 = [complex(0.0)u"NoUnits" complex(im * 50)u"Ω"; complex(im / 50)u"1/Ω" complex(0)u"NoUnits"]
ABCD4 = [complex(1.0)u"NoUnits" complex(0.0)u"Ω"; complex(1/25)u"1/Ω" complex(1)u"NoUnits"]

ABCDtot = ABCD1 * ABCD2 * ABCD3 * ABCD4
Vs = complex(3.0)u"V"

I2 = Vs * ABCDtot[2]
ZL = 25u"Ω"
VL = I2 * ZL
