using Unitful, LinearAlgebra

Z0 = 50u"Ω"
V1 = 10 * exp(im * deg2rad(90))u"V"
V2 = 8u"V"
I1 = 0.2 * exp(im * deg2rad(90))u"A"
I2 = 0.16 * exp(im * deg2rad(-90))u"A"

Zin_1 = uconvert(u"Ω" ,V1 / I1)
Zin_2 = uconvert(u"Ω", V2 / I2)

Vp_n(Vn, Z0, In) = (Vn + Z0 * In) / 2
Vn_n(Vn, Z0, In) = (Vn - Z0 * In) / 2

Vp_1 = uconvert(u"V", Vp_n(V1, Z0, I1))
Vp_2 = uconvert(u"V", Vp_n(V2, Z0, I2))
Vn_1 = uconvert(u"V", Vn_n(V1, Z0, I1))
Vn_2 = uconvert(u"V", Vn_n(V2, Z0, I2))
