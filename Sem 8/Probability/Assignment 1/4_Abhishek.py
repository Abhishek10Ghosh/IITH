import numpy as np
import matplotlib.pyplot as plt
import sys

# here chord lenght, l = 2*sin(theta)
def mode_0(N):
    """Mode 0: Chords based on random angle from (0,1)."""
    theta = np.random.uniform(0, np.pi, N)
    chord_length = 2 * np.sin(theta)
    return chord_length

# here chord lenght, l = 2*sqrt(1-U^2)
def mode_1(N):
    """Mode 1: Chords based on random distance from the center."""
    U = np.random.uniform(0, 1, N)
    chord_length = 2 * np.sqrt(1 - U**2)
    return chord_length

#here chord lenght, l = 2*sqrt(1-sqrt(x^2+y^2))
def mode_2(N):
    """Mode 2: Chords based on random center within the circle."""
    X, Y = np.random.uniform(-1, 1, N), np.random.uniform(-1, 1, N)
    valid = X**2 + Y**2 <= 1 
    X, Y = X[valid], Y[valid] #filter out all valid coordinates that are within the unit circle
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
