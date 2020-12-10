Za = (im * 100)u"Ω"
Zb = (im * 100)u"Ω"
Zc = (im * 50)u"Ω"
Z0 = 50u"Ω"

Γe = (Za - Z0) / (Za + Z0)
Zeq = Za + (2 * Za * Zb / (2 * Za + Zb))
Γo = (Zeq - Z0) / (Zeq + Z0)
printComplex(Γe)
printComplex(Γo)

Se = Γe
Sm = Γo

S11 = 1/2 * (Se + Sm)
S22 = S11
S12 = 1/2 * (Se - Sm)
S21 = S12
printComplex(S11)
printComplex(S22)
printComplex(S12)
printComplex(S21)

S11 = S11 * exp(-im * 6 * π / 5)
S22 = S22 * exp(-im * π)
S12 = S12 * exp(-im * π)
S21 = S21 * exp(-im * 11 * π / 10)

S = [S11 S12; S21 S22]

printComplex.(S)
