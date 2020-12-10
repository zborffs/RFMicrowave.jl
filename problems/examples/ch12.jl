# Example 12.4
f = [3, 4, 5]
S11 = [0.8 * exp(im * deg2rad(-90)), 0.75 * exp(im * deg2rad(-120)), 0.71 * exp(im * deg2rad(-140))]
S12 = [0, 0, 0]
S21 = [2.8 * exp(im * deg2rad(100)), 2.5 * exp(im * deg2rad(80)), 2.3 * exp(im * deg2rad(60))]
S22 = [0.66 * exp(im * deg2rad(-50)), 0.6 * exp(im * deg2rad(-70)), 0.58 * exp(im * deg2rad(-85))]

Gsmax = 1 ./ (1 .- abs.(S11).^2)
Glmax = 1 ./ (1 .- abs.(S22).^2)

Gsmax_dB = 10 * log10.(Gsmax)
Glmax_dB = 10 * log10.(Glmax)

G0 = abs.(S21).^2
G0_dB = 10 * log10.(G0)

GT_max = G0_dB .+ Gsmax_dB .+ Glmax_dB

# Gs and GL values
Gs_dB = [2, 3]
Gs = 10 .^(Gs_dB/10)
GL_dB = [0, 1]
GL = 10 .^(GL_dB/10)

# Compute gs values
gs = Gs ./ Gsmax[2]
gL = GL ./ Glmax[2]

# Compute Cs from gs
Cs = gs * conj(S11[2]) ./ (1 .- (1 .- gs) * abs(S11[2])^2)

# Compute CL from gL
CL = gL * conj(S22[2]) ./ (1 .- (1 .- gL) * abs(S22[2])^2)

# Compute Rs from gs
Rs = sqrt.(1 .- gs) * (1 - abs(S11[2])^2) ./ (1 .- (1 .- gs) * abs(S11[2])^2)

# Compute RL from gL
RL = sqrt.(1 .- gL) * (1 - abs(S22[2])^2) ./ (1 .- (1 .- gL) * abs(S22[2])^2)
