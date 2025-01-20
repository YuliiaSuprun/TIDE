import json

def generate_ltlf_formula(num_blocks):
    """Generate the LTLf formula for a given number of blocks."""
    # First part of the formula: stack blocks in increasing order
    initial_formula = " & ".join(f"on_b{i+1}_b{i}" for i in range(1, num_blocks))

    # Second part: place the lowest block (b1) on top while keeping other blocks ordered
    next_formula = " & ".join(f"on_b{i}_b{i-1}" for i in range(num_blocks, 2, -1)) + f" & on_b1_b{num_blocks}"

    formula = f"(F ({initial_formula} & (X (F ({next_formula})))))"
    return formula

def generate_json_data(start, end):
    """Generate a dictionary with keys tN and their corresponding LTLf formulas."""
    data = {}
    for i in range(start, end + 1):
        key = f"t{i}"
        value = generate_ltlf_formula(i)
        data[key] = value
    return data

def save_to_json_file(data, filename):
    """Save the dictionary to a JSON file."""
    with open(filename, "w") as json_file:
        json.dump(data, json_file, indent=4)
    print(f"JSON file saved as {filename}")

def main():
    start, end = 3, 30
    filename = "ltlf_formulas.json"

    # Generate data
    data = generate_json_data(start, end)

    # Save to JSON
    save_to_json_file(data, filename)

if __name__ == "__main__":
    main()