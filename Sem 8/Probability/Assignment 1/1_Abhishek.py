import random

# Function to simulate St. Petersburg Paradox
def simulate_game():
    k = 1
    while random.choice(["H", "T"]) == "H":
        k += 1
    return 2 ** k

# Function to return average of St. Petersburg for m times
def average_score(m):
    sum = 0
    for _ in range (m):
        sum += simulate_game()
    return round(sum/m,3)

m_values = [100,10000,1000000]

results = []

for m in m_values:
    results.append(average_score(m))

print(*results)