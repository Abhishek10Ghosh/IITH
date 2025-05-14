# import random

# def simulate_game():
#     k = 1
#     while random.choice(["H", "T"]) == "H":
#         k += 1
#     return 2 ** k

# def average_payout(m):
#     total_payout = sum(simulate_game() for _ in range(m))
#     return round(total_payout / m, 3)

# m_values = [100, 10000, 1000000]
# results = [average_payout(m) for m in m_values]

# print(*results)


# import sys
# import pandas as pd
# import numpy as np
# import matplotlib.pyplot as plt

# def generate_bernoulli(uniform_samples, p, output_filename):
#     bernoulli_samples = (uniform_samples < p).astype(int)
#     df = pd.DataFrame(bernoulli_samples,columns=["Bernoulli"])
#     df.to_csv(output_filename, index=False)
#     print(round(df.mean(), 3))

# def generate_exponential(uniform_samples, lambd, output_filename):
#     if lambd <= 0 :return
#     uniform_samples = np.clip(uniform_samples,0,1-1e-12)
#     exponential_samples = -np.log(1 - uniform_samples) / lambd
#     df = pd.DataFrame(exponential_samples,columns=["Exponential"])
#     df.to_csv(output_filename, index=False)
#     plt.hist(exponential_samples, bins=int(np.sqrt(len(uniform_samples))))
#     plt.xlabel('Value')
#     plt.ylabel('Frequency')
#     plt.title('Exponential Distribution Histogram')
#     plt.show()

# def generate_cdf_x(uniform_samples, output_filename):
#     x_samples = np.where(uniform_samples <= 1/3, np.sqrt(3 * uniform_samples), 
#              np.where(uniform_samples <= 2/3, 2, 
#                       6 * uniform_samples - 2))
#     df = pd.DataFrame(x_samples,columns=["CDF"])
#     df.to_csv(output_filename, index=False)
#     print((x_samples == 2).sum())
#     plt.hist(x_samples, bins=int(np.sqrt(len(uniform_samples))))
#     plt.xlabel('Value')
#     plt.ylabel('Frequency')
#     plt.title('Histogram of X')
#     plt.show()

# def main():
#     mode = int(sys.argv[1])
#     input_file = sys.argv[2]
    
#     df = pd.read_csv(input_file)
#     uniform_samples = df[df.columns[0]].values
    
#     if mode == 0:
#         p = float(sys.argv[3])
#         output_filename = f'Bernoulli{int(p*100)}.csv'
#         generate_bernoulli(uniform_samples, p, output_filename)
#     elif mode == 1:
#         lambd = float(sys.argv[3])
#         output_filename = f'Exponential{str(lambd).replace(".", "p")}.csv'
#         generate_exponential(uniform_samples, lambd, output_filename)
#     elif mode == 2:
#         output_filename = 'CDFX.csv'
#         generate_cdf_x(uniform_samples, output_filename)
#     else:
#         print("Invalid mode. Use 0 for Bernoulli, 1 for Exponential, or 2 for CDF X.")

# if __name__ == "__main__":
#     main()

# import numpy as np
# import matplotlib.pyplot as plt
# import sys

# def generate_subsets(n, k, N):
#     # Step 1: Generate n × N uniform [0,1] samples
#     # U = np.random.uniform(0, 1, (n, N))
#     U = [[0.8147,0.9134,0.2785,0.9649,0.9572],[0.9058,0.6324,0.5469,0.1576,0.4854],[0.1270,0.0975,0.9575,0.9706,0.8003]]
    
#     I = np.zeros((n,N),dtype=int)
#     # Step 2: Compute binary indicators I_{0,j}
#     for j in range(N):
#         if U[0][j] <= k/n :
#             I[0][j]=1
#         else:
#             I[0][j]=0
    
#     for j in range(N):
#         count=I[0][j]
#         for i in range(1,n,1):
#             if U[i][j] <= (k-count)/(n-(i)):
#                 I[i][j]=1
#             else:
#                 I[i][j]=0
                
#             count+=I[i][j]
#     # print(I)
#     return I

# def get_decimal(subset_values):
#     decimal = []
#     for i in range(len(subset_values[0])):
#         res = 0
#         for j in range(len(subset_values)):
#             res+=(2**j)*subset_values[j][i]
#         decimal.append(res)
#     return decimal

# def plot_histogram(subset_values, n, N):
#     bins = np.arange(2 ** n + 1) - 0.5  # Define bin edges
#     plt.hist(subset_values, bins=bins, density=True, edgecolor='black', alpha=0.7)
#     plt.xticks(range(2 ** n))
#     plt.xlabel("Subset Decimal Representation")
#     plt.ylabel("Frequency")
#     plt.title(f"Histogram of Subset Values (n={n}, N={N})")
#     plt.show()

# def main():
#     # Read command-line arguments
#     if len(sys.argv) != 4:
#         print("Usage: python script.py n k N")
#         return
    
#     n = int(sys.argv[1])  # Number of elements
#     k = int(sys.argv[2])  # Subset size
#     N = int(sys.argv[3])  # Number of trials
    
#     subset_values = generate_subsets(n, k, N)
#     decimal_values = get_decimal(subset_values)
#     # print(*decimal_values)
#     plot_histogram(decimal_values, n, N)

# if __name__ == "__main__":
#     main()


import numpy as np
import matplotlib.pyplot as plt
import sys

# here chord lenght, l = 2*sin(theta)
def mode_0(N):
    """Mode 0: Chords based on random angle from (0,1)."""
    theta = np.random.uniform(0, np.pi, N)
    chord_length = 2 * np.sin(theta)
    return chord_length

def mode_1(N):
    """Mode 1: Chords based on random distance from the center."""
    U = np.random.uniform(0, 1, N)
    chord_length = 2 * np.sqrt(1 - U**2)
    return chord_length

def mode_2(N):
    """Mode 2: Chords based on random center within the circle."""
    X, Y = np.random.uniform(-1, 1, N), np.random.uniform(-1, 1, N)
    valid = X**2 + Y**2 <= 1
    X, Y = X[valid], Y[valid]
    R = np.sqrt(X**2 + Y**2)
    chord_length = 2 * np.sqrt(1 - R**2)
    return chord_length

def main():
    if len(sys.argv) != 3:
        print("Usage: python script.py <mode> <N>")
        return
    
    mode = int(sys.argv[1])
    N = int(sys.argv[2])
    
    if mode == 0:
        chords = mode_0(N)
    elif mode == 1:
        chords = mode_1(N)
    elif mode == 2:
        chords = mode_2(N)
    else:
        print("Invalid mode. Choose 0, 1, or 2.")
        return
    
    # Compute fraction of chords with length > sqrt(3)
    # prob = np.mean(chords >= np.sqrt(3))
    count = 0 
    for i in range(len(chords)):
        if chords[i]>=np.sqrt(3):
            count+=1
    prob = count/len(chords)
    print(f"Fraction of chords with length >= sqrt(3): {prob:.4f}")
    
    # Plot histogram
    plt.hist(chords, bins=int(np.sqrt(N)), edgecolor='black', alpha=0.7)
    plt.xlabel("Chord Length")
    plt.ylabel("Frequency")
    plt.title(f"Histogram of Chord Lengths (Mode {mode})")
    plt.show()

if __name__ == "__main__":
    main()
