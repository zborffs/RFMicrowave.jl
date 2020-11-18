using Unitful, LinearAlgebra

# Given
N = 3
f = 10u"GHz"
W = 1.2446u"mm"
H = 1.27u"mm"
ϵr = 9.8
L = 5.8u"mm" * N
l1 = 5u"mm"
l2 = 2.9u"mm"
Z0 = 50u"Ω"
c = 3e8u"m/s"

# Use equivalent circuit for microstrip T-junction to calculate the scattering
# matrix of the microstrip circuit shown on exam sheet
W_h = W / H
Lw = uconvert(u"H/m", Z0 * sqrt(ϵr) / c)
L1 = uconvert(u"H", H * (-W_h * (W_h * (-0.016 * W_h + 0.064) + 0.016/W_h) * Lw))
L2 = uconvert(u"H", (((0.12 * W_h - 0.47) * W_h + 0.195 * W_h - 0.357 + 0.0283 * sin(π * W_h - 0.75 * π)) * Lw) * H)

CT = (ustrip(uconvert(u"m", W)) * ((100 / tanh(0.0072 * ustrip(Z0))) + 0.64 * ustrip(Z0) - 261))u"pF"

λ0 = c / f
λ = λ0 / sqrt(ϵr)
β = 2 * π / λ
Zin_sc1 = im * Z0 * tan(β * l2 / 2)
Zin_scL = im * Z0 * tan(β * L)
Zin_oc1 = -im * Z0 * cot(β * l2 / 2)
ω = 2 * π * f

function parallel(Z1, Z2)
	Z1 * Z2 / (Z1 + Z2)
end

Zeq_sc = uconvert(u"Ω", parallel(parallel(Zin_sc1 + im * ω * L1, 1 / (im * ω * CT)), Zin_scL + im * ω * L2) + (im * ω * L1))
Zeq_oc = uconvert(u"Ω", parallel(parallel(Zin_oc1 + im * ω * L1, 1 / (im * ω * CT)), Zin_scL + im * ω * L2) + (im * ω * L1))

zL_sc_eq = Zeq_sc / Z0
zL_oc_eq = Zeq_oc / Z0

Zin_sc_final = Z0 * (zL_sc_eq + im * tan(β * l1)) / (1 + im * zL_sc_eq * tan(β * l1))
Zin_oc_final = Z0 * (zL_oc_eq + im * tan(β * l1)) / (1 + im * zL_oc_eq * tan(β * l1))

Se = (Zin_sc_final - Z0) / (Zin_sc_final + Z0)
Sm = (Zin_oc_final - Z0) / (Zin_oc_final + Z0)

S11 = 1/2 * (Sm + Se)
S22 = S11
S12 = 1/2 * (Sm - Se)
S21 = S12
S = [S11 S12; S21 S22]
