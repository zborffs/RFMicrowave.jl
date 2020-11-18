ABCD1 = [1 50; 0 1]
ABCD2 = [1/2 0;0 2]
ABCD3 = [0 50im; (1/50)im 0]
ABCD4 = [1 0; 1/25 0]
ABCD = ABCD1 * ABCD2 * ABCD3 * ABCD4
V = 3
A = ABCD[1]

VL = V / A
