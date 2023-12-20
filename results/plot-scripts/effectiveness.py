import matplotlib.pyplot as plt
import numpy as np
import random
import json

# Constants
initial_rep = 0.7  # Initial reputation for the first round
min_good_behavior_eval = 0.7  # Minimum current task evaluation for good behavior
max_good_behavior_eval = 0.85  # Maximum current task evaluation for good behavior
bad_behavior_eval = 0.2  # Current task evaluation for bad behavior
num_submissions = 25  # Number of submissions

# Initialize lists to store reputation values
reputation_values = []

# Initialize good_behavior_eval incrementally
good_behavior_eval = min_good_behavior_eval

# Simulate reputation update for good and bad behavior
for i in range(num_submissions):
    if i < 19:
        # Incrementally update good_behavior_eval
        good_behavior_eval += (max_good_behavior_eval - min_good_behavior_eval) / 19
        # Make sure it doesn't exceed the maximum value
        good_behavior_eval = min(good_behavior_eval, max_good_behavior_eval)
        updated_rep = (1 - np.tanh(i)) * initial_rep + np.tanh(i) * good_behavior_eval
    else:
        # Switch to bad behavior scenario with the last reputation from good behavior
        updated_rep = (1 - np.tanh(i)) * reputation_values[-1] + np.tanh(i) * bad_behavior_eval
    
    # Append the updated reputation to the list
    reputation_values.append(updated_rep)

# Load data from the JSON file
ipot_data = [{"x": "0", "y": "0.7"},
{"x": "1", "y": "0.7292565947242207"},
{"x": "2", "y": "0.7450839328537171"},
{"x": "3", "y": "0.7589928057553957"},
{"x": "4", "y": "0.7724220623501199"},
{"x": "5", "y": "0.7815347721822543"},
{"x": "6", "y": "0.7920863309352519"},
{"x": "7", "y": "0.8045563549160673"},
{"x": "8", "y": "0.813189448441247"},
{"x": "9", "y": "0.8227817745803359"},
{"x": "10", "y": "0.8323741007194245"},
{"x": "11", "y": "0.8410071942446045"},
{"x": "12", "y": "0.8505995203836931"},
{"x": "13", "y": "0.8592326139088731"},
{"x": "14", "y": "0.866906474820144"},
{"x": "15", "y": "0.8726618705035971"},
{"x": "16", "y": "0.8793764988009594"},
{"x": "17", "y": "0.8870503597122303"},
{"x": "18", "y": "0.8918465227817747"},
{"x": "19", "y": "0.602158273381295"},
{"x": "20", "y": "0.4688249400479616"},
{"x": "21", "y": "0.41223021582733815"},
{"x": "22", "y": "0.3834532374100719"},
{"x": "23", "y": "0.3738609112709832"},
{"x": "24", "y": "0.36810551558752996"}]

# Extract x and y values from the JSON data
x_values = [int(entry["x"]) for entry in ipot_data]
y_values = [float(entry["y"]) for entry in ipot_data]

# Plot the reputation update and JSON data
plt.figure(figsize=(10, 5))
plt.plot(range(num_submissions), reputation_values, marker='o', linestyle='-', color='b', label='Proposed work')
plt.plot(x_values, y_values, marker='x', linestyle='-', color='g', label='IPoT')
plt.xlabel('Number of Submissions',fontdict={"size":18})
plt.ylabel('Reputation values',fontdict={"size":18})
plt.title('')
plt.grid(True)
plt.legend(loc='upper right')
plt.axvline(x=19, color='r', linestyle='--', label='Behavior Switch')
plt.legend()
plt.savefig('IPOT_comparison.png')

