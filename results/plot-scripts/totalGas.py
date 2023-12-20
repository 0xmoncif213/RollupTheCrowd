import json

def calculate_sum_of_operations(data):
    for function_name, scenarios in data['functions'].items():
        print(f"Function: {function_name}")
        for scenario in scenarios:
            committing = scenario.get("committing", 0)
            proving = scenario.get("proving", 0)
            execution = scenario.get("execution", 0)
            num_blocks = scenario["Number of calls"]

            total_operations = committing + proving + execution
            print(f"Blocks: {num_blocks}, Sum of Committing, Proving, Execution: {total_operations}")

if __name__ == "__main__":
    file_path = '../data/gas/N-Calls/createTask-L2-L1.json'

    with open(file_path, 'r') as file:
        data = json.load(file)

    calculate_sum_of_operations(data)
