import sys
import numpy as np
import matplotlib.pyplot as plt
import math


# function to get Normal PDF
def normal_pdf(x, mu, sigma):
    return (1.0 / (sigma * math.sqrt(2 * math.pi))) * np.exp(-0.5 * ((x - mu) / sigma) ** 2)

def main():
    if len(sys.argv) < 4:
        print("Insufficient arguments")
        return

    mode = int(sys.argv[1])
    n = int(sys.argv[2])
    N = int(sys.argv[3])

    # Bernoulli
    if mode == 0:
        p = float(sys.argv[4])
        X = np.random.binomial(1, p, (N, n))
        mean = p
        var = p * (1 - p)
    # uniform
    elif mode == 1:
        X = np.random.uniform(0, 1, (N, n))
        mean = 0.5 # (b-a)/2
        var = 1 / 12 # (b-a)^2 / 12
    # Exponential
    elif mode == 2:
        lambd = float(sys.argv[4])
        X = np.random.exponential(1 / lambd, (N, n))
        mean = 1 / lambd
        var = 1 / (lambd ** 2)

    else:
        print("Invalid mode. Use 0 for Bernoulli, 1 for Uniform, 2 for Exponential.")
        return

    Y = X.mean(axis=1)

    # Plotting
    plt.figure(figsize=(10, 6))
    
    # Histogram
    plt.hist(Y, bins=50, density=True, alpha=0.6, color='skyblue', label="Sample Mean Histogram")

    # Normal PDF
    x = np.linspace(min(Y), max(Y), 1000)
    pdf = normal_pdf(x, mean, math.sqrt(var / n))
    plt.plot(x, pdf, 'r', linewidth=2, label="Normal PDF")

    # Labels and title
    plt.title("Histogram of Sample Means and Normal PDF")
    plt.xlabel("Sample Mean")
    plt.ylabel("Density")
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    main()
