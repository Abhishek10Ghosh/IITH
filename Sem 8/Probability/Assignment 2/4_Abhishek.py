import sys
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import multivariate_normal

# covariance function
def check_covariance(K):
    if not np.allclose(K, K.T):
        print("Covariance matrix is not symmetric.")
        return False
    eigvals = np.linalg.eigvalsh(K)
    if np.any(eigvals < 0):
        print("Covariance matrix is not positive semi-definite.")
        return False
    print("Covariance matrix is symmetric and positive semi-definite.")
    return True

def plot_results(samples, M, K, U, title):
    x, y = samples[:, 0], samples[:, 1]
    plt.figure(figsize=(8, 6))
    plt.scatter(x, y, alpha=0.4, label='Samples')

    # Plot contour of joint PDF
    X, Y = np.meshgrid(np.linspace(x.min()-1, x.max()+1, 100),
                       np.linspace(y.min()-1, y.max()+1, 100))
    pos = np.dstack((X, Y))
    rv = multivariate_normal(mean=M, cov=K)
    Z = rv.pdf(pos)
    plt.contour(X, Y, Z, levels=5, colors='black')

    # Plot mean and eigen directions
    plt.plot(*M, 'ro', label='Mean M')
    scale = 2  # vector scale for visualization
    plt.quiver(*M, *U[:, 0], angles='xy', scale_units='xy', scale=1, color='r', label='u1')
    plt.quiver(*M, *U[:, 1], angles='xy', scale_units='xy', scale=1, color='g', label='u2')

    plt.title(title)
    plt.xlabel('X1')
    plt.ylabel('X2')
    plt.axis('equal')
    plt.legend()
    plt.grid(True)

def main():
    if len(sys.argv) != 8:
        print("Usage: python myprog.py m1 m2 k11 k12 k21 k22 N")
        return

    m1, m2 = float(sys.argv[1]), float(sys.argv[2])
    k11, k12, k21, k22 = map(float, sys.argv[3:7])
    N = int(sys.argv[7])

    M = np.array([m1, m2])
    K = np.array([[k11, k12], [k21, k22]])

    print("Mean vector M:\n", M)
    print("Covariance matrix K:\n", K)

    if not check_covariance(K):
        return

    # Eigen-decomposition K = U D U^T
    eigvals, U = np.linalg.eigh(K)  # U has orthonormal eigenvectors
    D = np.diag(eigvals)
    D_sqrt = np.diag(np.sqrt(eigvals))
    A = U @ D_sqrt

    # Method 1: Using numpy's multivariate normal
    samples1 = np.random.multivariate_normal(mean=M, cov=K, size=N)

    # Method 2: Using standard normals and transformation
    S = np.random.randn(N, 2)  # N x 2 samples from N(0, 1)
    samples2 = S @ A.T + M  # (AS^T)^T + M

    # Plot both results
    plot_results(samples1, M, K, U, "Samples from numpy.multivariate_normal")
    plot_results(samples2, M, K, U, "Samples via Eigen-transformation")
    plt.show()

if __name__ == "__main__":
    main()
