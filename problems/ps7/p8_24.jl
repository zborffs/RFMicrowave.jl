using RFMicrowave, Unitful, PrettyTables

# BPF - 30 dB at lowest end of transmit frequency band (869-894 MHz)
# 1 dB equal-ripple bpf using Capacitively coupled short-circuited shunt stub
# resonators. Assume an impedance of Z0 = 50

f1 = 824u"MHz"
f2 = 849u"MHz"
ω1 = uconvert(u"rad/s", 2 * π * f1)
ω2 = uconvert(u"rad/s", 2 * π * f2)
ω0 = find_center_freq(ω1, ω2)
f0 = uconvert(u"MHz", ω0 / (2 * π))
Δ = (ω2 - ω1) / ω0

ω = 2 * π * 869u"MHz" # edge of 30dB rejection band
