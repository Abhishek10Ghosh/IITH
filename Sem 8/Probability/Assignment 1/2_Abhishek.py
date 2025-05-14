import sys
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Function to generate bernoulli samples
def generate_bernoulli(uniform_samples, p, output_filename):
    bernoulli_samples = (uniform_samples < p) * 1 # less than p then 1 else 0
    df = pd.DataFrame(bernoulli_samples,columns=["Bernoulli"])
    df.to_csv(output_filename, index=False)
    print(round(df.mean(), 3))

# Function to generate exponential samples
def generate_exponential(uniform_samples, lambd, output_filename):
    # avoid division by zero
    if lambd <= 0 :
        return
    
    # replace 0 with very small value to avoid log(0)
    uniform_samples = np.clip(uniform_samples,0,1-1e-12)

    # Fx = 1-exp(-lambd*x) => x = -log(1-Fx)/lambd
    exponential_samples = -np.log(1 - uniform_samples) / lambd
    df = pd.DataFrame(exponential_samples,columns=["Exponential"])
    df.to_csv(output_filename, index=False)
    plt.hist(exponential_samples, bins=int(np.sqrt(len(uniform_samples))))
    plt.xlabel('Value')
    plt.ylabel('Frequency')
    plt.title('Exponential Distribution Histogram')
    plt.show()

# Function to generate CDF samples
def generate_cdf_x(uniform_samples, output_filename):
    x_samples = np.where(uniform_samples <= 1/3, np.sqrt(3 * uniform_samples), 
             np.where(uniform_samples <= 2/3, 2, 
                      6 * uniform_samples - 2))
    df = pd.DataFrame(x_samples,columns=["CDFX"])
    df.to_csv(output_filename, index=False)
    print((x_samples == 2).sum())
    plt.hist(x_samples, bins=int(np.sqrt(len(uniform_samples))))
    plt.xlabel('Value')
    plt.ylabel('Frequency')
    plt.title('Histogram of X')
    plt.show()

def main():
    mode = int(sys.argv[1])
    input_file = sys.argv[2]
    
    df = pd.read_csv(input_file)
    uniform_samples = df[df.columns[0]].values
    
    if mode == 0:
        p = float(sys.argv[3])
        output_filename = f'Bernoulli_{str(p).replace(".", "p")}.csv'
        generate_bernoulli(uniform_samples, p, output_filename)
    elif mode == 1:
        lambd = float(sys.argv[3])
        output_filename = f'Exponential_{str(lambd).replace(".", "p")}.csv'
        generate_exponential(uniform_samples, lambd, output_filename)
    elif mode == 2:
        output_filename = 'CDFX.csv'
        generate_cdf_x(uniform_samples, output_filename)
    else:
        print("Invalid mode. Use 0 for Bernoulli, 1 for Exponential, or 2 for CDF X.")

if __name__ == "__main__":
    main()
