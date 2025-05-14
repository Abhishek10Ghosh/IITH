import sys
import pandas as pd
import matplotlib.pyplot as plt

def process_csv(file_path):
    try:
        df = pd.read_csv(file_path)
        print("Reading contents of", file_path)
        return df
    except Exception as e:
        print(f"Error reading CSV file: {e}")
        sys.exit(1)

if __name__ == "__main__":        
    # Read arguments
    assert len(sys.argv) == 4, "Usage: python script.py mu_x var_x samples.csv"
    mu_x = float(sys.argv[1])
    var_x = float(sys.argv[2])
    input_fn = sys.argv[3]

    print("Mean of X:", mu_x)
    print("Variance of X:", var_x)
    print("Input file:", input_fn)

    # Read samples
    mmse_samples = process_csv(input_fn)
    mmse_samples_array = mmse_samples.to_numpy()
    N = len(mmse_samples_array)
    print("Number of samples (N):", N)

    # Check expected shape: 2 columns (Y_i, sigma_i^2)
    if mmse_samples_array.shape[1] < 2:
        print("Error: CSV must contain at least 2 columns: Yi and sigma_i^2")
        sys.exit(1)

    mmse_estimates = []

    numerator = 0
    denom = 1 / var_x

    for i in range(N):
        Yi = mmse_samples_array[i][0]
        sigma_i_sq = mmse_samples_array[i][1]

        numerator += Yi / sigma_i_sq
        denom += 1 / sigma_i_sq

        x_hat_i = numerator / denom
        mmse_estimates.append(x_hat_i)

    # Plotting MMSE estimates
    plt.figure(figsize=(10, 6))
    plt.scatter(range(1, N + 1), mmse_estimates, color='blue', s=10, label='MMSE Estimate')
    plt.axhline(mu_x, color='green', linestyle='--', label="True Mean ($\\mu_X$)")
    plt.xlabel("n (number of observations)")
    plt.ylabel("MMSE Estimate of X")
    plt.title("MMSE Estimates of X vs Number of Observations")
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.show()
