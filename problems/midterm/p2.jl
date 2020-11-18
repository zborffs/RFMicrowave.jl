using Unitful, LinearAlgebra

# Given
N = 3
C = (0.05 * N)
Sa = [0 1 0; 1 0 C; 0 C 1]

# Find
# S-Parameters of the following 2 port network
Spp = [0 0;
       0 0]
Spc = [0 1 0 0 0 0 0;
       0 0 1 0 0 0 0]
Scp = [0 0;
       1 0;
	   0 1;
	   0 0;
	   0 0;
	   0 0;
	   0 0]
Scc = [1 0.15 0 0 0 0 0;
       0.15 0 0 0 0 0 0;
	   0 0 0 0.15 0 0 0;
	   0 0 0.15 1 0 0 0;
	   0 0 0 0 0 1 0;
	   0 0 0 0 1 0 0.15;
	   0 0 0 0 0 0.15 1]
Γ = [0 0 0 0 1 0 0;
	 0 0 1 0 0 0 0;
	 0 1 0 0 0 0 0;
	 0 0 0 0 0 1 0;
	 1 0 0 0 0 0 0;
	 0 0 0 1 0 0 0;
	 0 0 0 0 0 0 0]

S = Spp + Spc * inv(Γ - Scc) * Scp
