import sys
import numpy as np
import matplotlib.pyplot as plt
import math

# functions fa and fb
def fa(x):
    # fa(x) = 6! / (3! * 2!) * x^3 * (1 - x)^2
    return (720 / (6 * 2)) * (x ** 3) * ((1 - x) ** 2)

def fb(x):
    # fb(x) = 6! / (4! * 1!) * x^4 * (1 - x)
    return (720 / (24 * 1)) * (x ** 4) * (1 - x)

# function to sort the N x 6 row wise and pick the 4th column
def simulate_X(N):
    samples = np.random.uniform(0, 1, (N, 6))
    samples_sorted = np.sort(samples, axis=1)
    X = samples_sorted[:, 3]  # 4th friend (0-indexed)
    return X

def main():
    if len(sys.argv) < 2:
        print("Usage: python 2Myna.py <number_of_samples>")
        return

    N = int(sys.argv[1])
    X = simulate_X(N)

    # Plotting
    plt.figure(figsize=(10, 6))

    # Histogram of X
    plt.hist(X, bins=100, range=(0, 1), density=True, alpha=0.6, color='skyblue', label="Histogram of X")

    # Plot fa and fb
    x_vals = np.linspace(0, 1, N)
    fa_vals = fa(x_vals)
    fb_vals = fb(x_vals)

    plt.plot(x_vals, fa_vals, 'r', label="fa(x)", linewidth=2)
    plt.plot(x_vals, fb_vals, 'g', label="fb(x)", linewidth=2)

    plt.title("Histogram of X and PDFs fa(x), fb(x)")
    plt.xlabel("X (normalized time of 4th arrival)")
    plt.ylabel("Density")
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.show()

    # Compare the true values of fa and fb at histogram bin centers
    hist, bin_edges = np.histogram(X, bins=100, range=(0, 1), density=True)
    bin_centers = (bin_edges[:-1] + bin_edges[1:]) / 2

    fa_vals = fa(bin_centers)
    fb_vals = fb(bin_centers)
    
    # root mean square error
    err_fa = np.mean((hist - fa_vals) ** 2)
    err_fb = np.mean((hist - fb_vals) ** 2)

    print("fa" if err_fa < err_fb else "fb")

if __name__ == "__main__":
    main()
