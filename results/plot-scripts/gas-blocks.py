import json
import matplotlib.pyplot as plt
import numpy as np

def plot_podium(data, title):
    functions = data["functions"]
    num_blocks = np.array([entry["Number of blocks"] for entry in functions["createTask"]])

    bar_width = 0.2
    opacity = 0.7
    index = np.arange(len(num_blocks))

    plt.figure(figsize=(10, 5))

    for i, (func, values) in enumerate(functions.items()):
        if func == "createTask":
            gas_used = np.array([entry["Gas used"] / 10000 for entry in values], dtype=float)
            plt.bar(index + i * bar_width, gas_used, bar_width, label=func)
        elif func == "createTask-zkRollup":
            committing = np.array([entry["committing"] / 10000 for entry in values], dtype=float)
            proving = np.array([entry["proving"] / 10000 for entry in values], dtype=float)
            execution = np.array([entry["execution"] / 10000 for entry in values], dtype=float)

            # Combined bar for committing + proving + execution
            bottom_values = np.zeros_like(num_blocks, dtype=float)
            plt.bar(index + i * bar_width, committing, bar_width, label=f"{func}-Committing", alpha=opacity, color='r', bottom=bottom_values)
            bottom_values += committing

            plt.bar(index + i * bar_width, proving, bar_width, label=f"{func}-Proving", alpha=opacity, color='g',  bottom=bottom_values)
            bottom_values += proving

            plt.bar(index + i * bar_width, execution, bar_width, label=f"{func}-Executing", alpha=opacity, color='y',  bottom=bottom_values)

    plt.xlabel("Number of calls", fontdict={"size":18})
    plt.ylabel("Gas used (10^4)" ,fontdict={"size":18})
    plt.title(title)
    plt.xticks(index + bar_width, num_blocks)
    plt.legend()
    plt.grid(True)
    plt.show()

def main():
    # Adjust the file name based on the specific function you intend to plot.
    json_file_path = "../data/gas/N-Blocks/createTask-L2-L1.json" 

    with open(json_file_path, "r") as file:
        data = json.load(file)

    plot_podium(data, "")

if __name__ == "__main__":
    main()
