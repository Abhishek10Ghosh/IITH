import numpy as np
import matplotlib.pyplot as plt
import sys

def generate_subsets(n, k, N):
    # Step 1: Generate n × N uniform [0,1] samples
    U = np.random.uniform(0, 1, (n, N))
    
    I = np.zeros((n,N),dtype=int)
    # Step 2: Compute binary indicators I_{i,j}
    for j in range(N):
        if U[0][j] <= k/n :
            I[0][j]=1
        else:
            I[0][j]=0
    
    for j in range(N):
        count=I[0][j]
        for i in range(1,n,1):
            if U[i][j] <= (k-count)/(n-(i)):
                I[i][j]=1
            else:
                I[i][j]=0
                
            count+=I[i][j]
    # print(I)
    return I


# Function to convert ith column to decimal
def get_decimal(subset_values):
    decimal = []
    for i in range(len(subset_values[0])):
        res = 0
        for j in range(len(subset_values)):
            res+=(2**j)*subset_values[j][i]
        decimal.append(res)
    return decimal


# Function to plot histogram of decimal value frequency
def plot_histogram(decimal_values, n, N):
    bins = np.arange(2 ** n + 1) - 0.5  # Define bin edges
    plt.hist(decimal_values, bins=bins, density=True, edgecolor='black', alpha=0.7)
    plt.xticks(range(2 ** n))
    plt.xlabel("Subset Decimal Representation")
    plt.ylabel("Frequency")
    plt.title(f"Histogram of Subset Values (n={n}, N={N})")
    plt.show()

def main():
    # Read command-line arguments
    if len(sys.argv) != 4:
        print("Usage: python script.py n k N")
        return
    
    n = int(sys.argv[1])  # Number of elements
    k = int(sys.argv[2])  # Subset size
    N = int(sys.argv[3])  # Number of trials
    
    subset_values = generate_subsets(n, k, N)
    decimal_values = get_decimal(subset_values)
    # print(*decimal_values)
    plot_histogram(decimal_values, n, N)

if __name__ == "__main__":
    main()
