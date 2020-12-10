using RFMicrowave, Unitful, Roots, LinearAlgebra, Luxor

# Given
L1 = 1/4
Za = (im * 30)u"Ω"
Z0 = 50u"Ω"
Sm = [0 1/sqrt(2)-im/sqrt(2); 1/sqrt(2)-im/sqrt(2) 0]

# Find
Γe = round(-1 * exp(-im * 2 * 2 * π * L1); digits=5)
Γo = round(1 * exp(-im * 2 * 2 * π * L1); digits=5)

Γine = Sm[1,1] + (Sm[1,2] * Γe * Sm[2,1]) / (1 - S[2,2] * Γe)
Γino = Sm[1,1] + (Sm[1,2] * Γo * Sm[2,1]) / (1 - S[2,2] * Γo)
printComplex(Γine)
printComplex(Γino)

Zine = Z0 * (1 + Γine) / (1 - Γine)
Zino = Z0 * (1 + Γino) / (1 - Γino)

Zeqe = Zine + Za
Zeqo = Zino + Za

Γeqe = (Zeqe - Z0) / (Zeqe + Z0)
Γeqo = (Zeqo - Z0) / (Zeqo + Z0)
printComplex(Γeqe)
printComplex(Γeqo)

Se = Γeqe * exp(-im * 2 * 2 * π * 1/4)
Sm = Γeqo * exp(-im * 2 * 2 * π * 1/4)
printComplex(Se)
printComplex(Sm)

S11 = 1/2 * (Se + Sm)
S21 = 1/2 * (Se - Sm)
printComplex(S11)
printComplex(S21)
