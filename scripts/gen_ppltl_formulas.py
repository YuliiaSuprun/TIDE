import json

def generate_ppltl_formula(num_blocks):
    """Generate the PPLTL formula for a given number of blocks."""
    # First part of the formula
    initial_formula = " & ".join(f"on_b{i}_b{i+1}" for i in range(num_blocks - 1, 0, -1))
    # Second part (nested "Y(O(...))")
    next_formula = " & ".join(f"on_b{i+1}_b{i}" for i in range(1, num_blocks))
    formula = f"O({initial_formula} & Y(O({next_formula})))"
    return formula

def generate_json_data(start, end):
    """Generate a dictionary with keys pN and their corresponding PPLTL formulas."""
    data = {}
    for i in range(start, end + 1):
        key = f"p{i}"
        value = generate_ppltl_formula(i)
        data[key] = value
    return data

def save_to_json_file(data, filename):
    """Save the dictionary to a JSON file."""
    with open(filename, "w") as json_file:
        json.dump(data, json_file, indent=4)
    print(f"JSON file saved as {filename}")

def main():
    start, end = 3, 30
    filename = "tower_formulas.json"
    
    # Generate data
    data = generate_json_data(start, end)
    
    # Save to JSON
    save_to_json_file(data, filename)

if __name__ == "__main__":
    main()
