CdB = 15 # dB
Z0 = 50 # Ohm

C = 10^(CdB / -20)
Z0e = Z0 * sqrt((1 + C) / (1-C))
Z0o = Z0 * sqrt((1-C) / (1+C))
